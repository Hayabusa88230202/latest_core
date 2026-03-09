use std::fmt;

use crate::cache::{Cache, CacheStats};
use crate::instructions::{FWord, Instruction, InstructionType, Register, Word};
use crate::memory::{Memory, MemoryAddress, MemoryError};

use crate::fpu_hw;

/// MIPSプロセッサのレジスタ数
pub const REGISTER_COUNT: usize = 32;

/// プログラムカウンタの初期値
pub const PC_INITIAL: MemoryAddress = 0x00040000;

const CLOCK_FREQ: u64 = 25 * 1000 * 1000;

/// MIPSプロセッサ
#[derive(Debug)]
pub struct Processor {
    /// 汎用レジスタ（$0-$31）
    registers: [Word; REGISTER_COUNT],
    /// 浮動小数点数レジスタ
    f_registers: [FWord; REGISTER_COUNT],
    /// condition flag用レジスタ
    fcsr: bool,
    /// プログラムカウンタ
    pub pc: MemoryAddress,
    /// メモリシステム
    pub memory: Memory,
    /// キャッシュシステム
    pub cache: Cache,
    /// 実行統計
    stats: ProcessorStats,
    /// 次命令のIFステージ開始サイクル（予測用）
    pipeline_next_if_cycle: u64,
    /// 整数レジスタ依存情報（予測用）
    int_dependencies: [Option<PipelineDependency>; REGISTER_COUNT],
    /// 浮動小数点レジスタ依存情報（予測用）
    float_dependencies: [Option<PipelineDependency>; REGISTER_COUNT],
    /// 条件フラグ依存情報（予測用）
    fcsr_dependency: Option<PipelineDependency>,
    // 次に読み込みした時に出力する入力データのメモリアドレス
    pub input_front: MemoryAddress,
    // 次に書き込みした時に出力する出力データのメモリアドレス
    pub output_front: MemoryAddress,
}

/// プロセッサ統計情報
#[derive(Debug, Clone, Default)]
pub struct ProcessorStats {
    /// 実行命令数
    pub instructions_executed: u64,
    /// 分岐命令数
    pub branches_taken: u64,
    /// ロード命令数
    pub loads_executed: u64,
    /// ストア命令数
    pub stores_executed: u64,
    /// 実行に要した合計サイクル数（パイプライン予測値）
    pub total_cycles: u64,
}

#[derive(Debug, Clone, Copy)]
struct PipelineDependency {
    /// フォワーディング可能になるサイクル
    ready_cycle: u64,
    /// レジスタ更新完了サイクル（WB）
    wb_cycle: u64,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum PipelineOperandKind {
    Int,
    Float,
    Fcsr,
}

#[derive(Debug, Clone, Copy)]
struct PipelineOperand {
    kind: PipelineOperandKind,
    reg: Register,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum WriteReadyStage {
    Ex,
    Mem,
}

impl Processor {
    /// 新しいプロセッサを作成
    #[allow(dead_code)]
    pub fn new() -> Self {
        let processor = Self {
            registers: [0; REGISTER_COUNT],
            f_registers: [0.0; REGISTER_COUNT],
            fcsr: false,
            pc: PC_INITIAL,
            memory: Memory::new(),
            cache: Cache::new(),
            stats: ProcessorStats::default(),
            pipeline_next_if_cycle: 1,
            int_dependencies: [None; REGISTER_COUNT],
            float_dependencies: [None; REGISTER_COUNT],
            fcsr_dependency: None,
            input_front: 0x07000000,
            output_front: 0x07FFFFEC,
        };

        processor
    }

    /// 指定されたサイズのメモリでプロセッサを作成
    pub fn with_memory_size(memory_size: usize) -> Self {
        let processor = Self {
            registers: [0; REGISTER_COUNT],
            f_registers: [0.0; REGISTER_COUNT],
            fcsr: false,
            pc: PC_INITIAL,
            memory: Memory::with_size(memory_size),
            cache: Cache::new(),
            stats: ProcessorStats::default(),
            pipeline_next_if_cycle: 1,
            int_dependencies: [None; REGISTER_COUNT],
            float_dependencies: [None; REGISTER_COUNT],
            fcsr_dependency: None,
            input_front: 0x07000000,
            output_front: 0x07FFFFEC,
        };

        processor
    }

    /// 整数レジスタの値を取得
    pub fn get_register(&self, reg: Register) -> Word {
        if reg == 0 {
            0 // $0は常に0
        } else {
            self.registers[reg as usize]
        }
    }

    /// 整数レジスタに値を設定
    pub fn set_register(&mut self, reg: Register, value: Word) {
        if reg != 0 {
            self.registers[reg as usize] = value;
        }
    }

    /// 浮動小数点数レジスタの値を取得
    pub fn get_f_register(&self, reg: Register) -> FWord {
        self.f_registers[reg as usize]
    }

    /// 浮動小数点数レジスタに値を設定
    pub fn set_f_register(&mut self, reg: Register, value: FWord) {
        self.f_registers[reg as usize] = value;
    }

    pub fn dump_registers(&self) -> String {
        let mut result = String::new();
        result.push_str("\n=== 整数レジスタ ===\n");
        for i in 0..REGISTER_COUNT {
            let reg_name = match i {
                0 => "$zero",
                1 => "$at",
                2 => "$v0",
                3 => "$v1",
                4 => "$a0",
                5 => "$a1",
                6 => "$a2",
                7 => "$a3",
                8 => "$t0",
                9 => "$t1",
                10 => "$t2",
                11 => "$t3",
                12 => "$t4",
                13 => "$t5",
                14 => "$t6",
                15 => "$t7",
                16 => "$s0",
                17 => "$s1",
                18 => "$s2",
                19 => "$s3",
                20 => "$s4",
                21 => "$s5",
                22 => "$s6",
                23 => "$s7",
                24 => "$t8",
                25 => "$t9",
                26 => "$k0",
                27 => "$k1",
                28 => "$gp",
                29 => "$sp",
                30 => "$fp",
                31 => "$ra",
                _ => "???",
            };
            result.push_str(&format!(
                "{}: 0x{:08X} ({})\n",
                reg_name, self.registers[i], self.registers[i] as i32
            ));
        }
        result
    }

    pub fn dump_f_registers(&self) -> String {
        let mut result = String::new();
        result.push_str("\n=== 浮動小数点レジスタ ===\n");
        for i in 0..REGISTER_COUNT {
            let reg_name = match i {
                0 => "$f0 ",
                1 => "$f1 ",
                2 => "$f2 ",
                3 => "$f3 ",
                4 => "$f4 ",
                5 => "$f5 ",
                6 => "$f6 ",
                7 => "$f7 ",
                8 => "$f8 ",
                9 => "$f9 ",
                10 => "$f10",
                11 => "$f11",
                12 => "$f12",
                13 => "$f13",
                14 => "$f14",
                15 => "$f15",
                16 => "$f16",
                17 => "$f17",
                18 => "$f18",
                19 => "$f19",
                20 => "$f20",
                21 => "$f21",
                22 => "$f22",
                23 => "$f23",
                24 => "$f24",
                25 => "$f25",
                26 => "$f26",
                27 => "$f27",
                28 => "$f28",
                29 => "$f29",
                30 => "$f30",
                31 => "$f31",
                _ => "???",
            };
            result.push_str(&format!(
                "{}: 0x{:08X} ({})\n",
                reg_name,
                self.f_registers[i].to_bits(),
                self.f_registers[i]
            ));
        }
        result
    }

    // condition flagを取得
    #[allow(dead_code)]
    pub fn get_condition_flag(&self) -> bool {
        self.fcsr
    }

    // condition flagを設定
    pub fn set_condition_flag(&mut self, value: bool) {
        self.fcsr = value;
    }

    /// プログラムカウンタを取得
    pub fn get_pc(&self) -> MemoryAddress {
        self.pc
    }

    /// プログラムカウンタを設定
    #[allow(dead_code)]
    pub fn set_pc(&mut self, pc: MemoryAddress) {
        self.pc = pc;
    }

    /// メモリから命令を読み込む
    pub fn fetch_instruction(&mut self) -> Result<Instruction, MemoryError> {
        // debug!("PC=0x{:08X} から命令をフェッチ", self.pc);
        let instruction = self.cache.read_word(&mut self.memory, self.pc)?;
        // debug!("フェッチした命令: 0x{:08X}", instruction);
        Ok(instruction)
    }

    /// 命令を実行
    pub fn execute_instruction(
        &mut self,
        instruction: Instruction,
    ) -> Result<bool, ProcessorError> {
        let instruction_type = InstructionType::decode(instruction);

        match instruction_type {
            InstructionType::Sll { rd, rt, shamt } => {
                let rt_val = self.get_register(rt);
                self.set_register(rd, rt_val << shamt);
            }
            InstructionType::Srl { rd, rt, shamt } => {
                let rt_val = self.get_register(rt);
                self.set_register(rd, rt_val >> shamt);
            }
            InstructionType::Sra { rd, rt, shamt } => {
                let rt_val = self.get_register(rt);
                self.set_register(rd, ((rt_val as i32) >> shamt) as u32); // i32にキャストしてからシフトすることで最上位ビットと同じ値を開いたビットに埋める
            }
            InstructionType::Jr { rs } => {
                let rs_val = self.get_register(rs);
                // debug!(
                //     "[JUMP] From: 0x{:08X}, To: 0x{:08X}",
                //     self.pc, rs_val
                // );
                self.pc = rs_val;
                self.stats.branches_taken += 1;
                return Ok(true); // 分岐が発生
            }
            InstructionType::Jalr { rd, rs } => {
                let rs_val = self.get_register(rs);
                // debug!(
                //     "[JUMP] From: 0x{:08X}, To: 0x{:08X}",
                //     self.pc, rs_val
                // );
                self.set_register(rd, self.pc + 4); // $rdに戻りアドレスを保存
                self.pc = rs_val;
                self.stats.branches_taken += 1;
                return Ok(true); // 分岐が発生
            }
            InstructionType::Add { rd, rs, rt } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);
                self.set_register(rd, rs_val.wrapping_add(rt_val));
            }
            InstructionType::Sub { rd, rs, rt } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);
                self.set_register(rd, rs_val.wrapping_sub(rt_val));
            }
            InstructionType::And { rd, rs, rt } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);
                self.set_register(rd, rs_val & rt_val);
            }
            InstructionType::Or { rd, rs, rt } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);
                self.set_register(rd, rs_val | rt_val);
            }
            InstructionType::Xor { rd, rs, rt } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);
                self.set_register(rd, rs_val ^ rt_val);
            }
            InstructionType::Nor { rd, rs, rt } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);
                self.set_register(rd, !(rs_val | rt_val));
            }
            InstructionType::Slt { rd, rs, rt } => {
                let rs_val = self.get_register(rs) as i32;
                let rt_val = self.get_register(rt) as i32;
                self.set_register(rd, if rs_val < rt_val { 1 } else { 0 });
            }
            InstructionType::Beq { rs, rt, imm } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);
                if rs_val == rt_val {
                    let base_pc = self.pc.wrapping_add(4);
                    // オフセットを計算 (immは16bitなのでi32に符号拡張してから4倍)
                    let offset = (imm as u16 as i32).wrapping_mul(4);
                    self.pc = base_pc.wrapping_add_signed(offset);

                    self.stats.branches_taken += 1;
                    return Ok(true); // 分岐が発生
                }
            }
            InstructionType::Bne { rs, rt, imm } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);

                if rs_val != rt_val {
                    let base_pc = self.pc.wrapping_add(4);
                    // オフセットを計算 (immは16bitなのでi32に符号拡張してから4倍)
                    let offset = (imm as i16 as i32).wrapping_mul(4);
                    self.pc = base_pc.wrapping_add_signed(offset);

                    self.stats.branches_taken += 1;
                    return Ok(true); // 分岐が発生
                }
            }
            InstructionType::Addi { rt, rs, imm } => {
                let rs_val = self.get_register(rs) as i32;
                let result = rs_val.wrapping_add(imm as i16 as i32) as u32;
                self.set_register(rt, result);
            }
            InstructionType::Subi { rt, rs, imm } => {
                let rs_val = self.get_register(rs) as i32;
                let result = rs_val.wrapping_sub(imm as i16 as i32) as u32;
                self.set_register(rt, result);
            }
            InstructionType::Slti { rt, rs, imm } => {
                let rs_val = self.get_register(rs) as i32;
                self.set_register(rt, if rs_val < imm as i32 { 1 } else { 0 });
            }
            InstructionType::Sgti { rt, rs, imm } => {
                let rs_val = self.get_register(rs) as i32;
                self.set_register(rt, if rs_val > imm as i32 { 1 } else { 0 });
            }
            InstructionType::Ori { rt, rs, imm } => {
                let rs_val = self.get_register(rs);
                self.set_register(rt, rs_val | (imm as u32));
            }
            InstructionType::Lui { rt, imm } => {
                self.set_register(rt, (imm as u32) << 16);
            }
            InstructionType::Lw { rt, rs, imm } => {
                let rs_val = self.get_register(rs);
                let address = rs_val.wrapping_add_signed(imm as i16 as i32);
                let value;
                if address == 0xFFFF0000 {
                    value = self
                        .memory
                        .read_word(self.input_front)
                        .map_err(|e| ProcessorError::MemoryError(e))?;
                    self.input_front += 4;
                    // println!("{:08X}", self.input_front);
                } else {
                    value = self
                        .cache
                        .read_word(&mut self.memory, address)
                        .map_err(|e| ProcessorError::MemoryError(e))?;
                }
                self.set_register(rt, value);
                self.stats.loads_executed += 1;
            }
            InstructionType::Sw { rt, rs, imm } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_register(rt);
                let address = rs_val.wrapping_add_signed(imm as i16 as i32);
                if address == 0xFFFF0000 {
                    self.memory
                        .write_word(self.output_front, rt_val)
                        .map_err(|e| ProcessorError::MemoryError(e))?;
                    self.output_front -= 4;
                } else {
                    self.cache
                        .write_word(&mut self.memory, address, rt_val)
                        .map_err(|e| ProcessorError::MemoryError(e))?;
                }
                self.stats.stores_executed += 1;
            }
            InstructionType::J { addr } => {
                // debug!(
                //     "[JUMP] From: 0x{:08X}, To: 0x{:08X} (addr field: 0x{:07X})",
                //     self.pc,
                //     (self.pc & 0xF0000000) | (addr << 2),
                //     addr
                // );
                self.pc = (self.pc & 0xF0000000) | (addr << 2);
                self.stats.branches_taken += 1;
                return Ok(true); // 分岐が発生
            }
            InstructionType::Jal { addr } => {
                // debug!(
                //     "[JUMP] From: 0x{:08X}, To: 0x{:08X} (addr field: 0x{:07X})",
                //     self.pc, (self.pc & 0xF0000000) | (addr << 2), addr
                // );
                self.set_register(31, self.pc + 4); // $raに戻りアドレスを保存
                self.pc = (self.pc & 0xF0000000) | (addr << 2);
                self.stats.branches_taken += 1;
                return Ok(true); // 分岐が発生
            }
            InstructionType::Fadd { rd, rs, rt } => {
                let rs_val = self.get_f_register(rs);
                let rt_val = self.get_f_register(rt);
                let hw_result = fpu_hw::hardware_fadd(rs_val, rt_val);
                self.set_f_register(rd, hw_result);
            }
            InstructionType::Fsub { rd, rs, rt } => {
                let rs_val = self.get_f_register(rs);
                let rt_val = self.get_f_register(rt);
                let hw_result = fpu_hw::hardware_fadd(rs_val, -rt_val);
                self.set_f_register(rd, hw_result);
            }
            InstructionType::Fmul { rd, rs, rt } => {
                let rs_val = self.get_f_register(rs);
                let rt_val = self.get_f_register(rt);
                let hw_result = fpu_hw::hardware_fmul(rs_val, rt_val);
                self.set_f_register(rd, hw_result);
            }
            InstructionType::Fdiv { rd, rs, rt } => {
                let rs_val = self.get_f_register(rs);
                let rt_val = self.get_f_register(rt);
                let hw_result = fpu_hw::hardware_fdiv(rs_val, rt_val);
                self.set_f_register(rd, hw_result);
            }
            InstructionType::Flw { rt, rs, imm } => {
                let rs_val = self.get_register(rs);
                let address = rs_val.wrapping_add_signed(imm as i16 as i32);
                let value;
                if address == 0xFFFF0000 {
                    value = self
                        .memory
                        .read_word(self.input_front)
                        .map_err(|e| ProcessorError::MemoryError(e))?;
                    self.input_front += 4;
                } else {
                    value = self
                        .cache
                        .read_word(&mut self.memory, address)
                        .map_err(|e| ProcessorError::MemoryError(e))?;
                }
                self.set_f_register(rt, f32::from_bits(value)); // f32::from_bitsでu32データをそのビット列のままfpとして解釈
                self.stats.loads_executed += 1;
            }
            InstructionType::Fsw { rt, rs, imm } => {
                let rs_val = self.get_register(rs);
                let rt_val = self.get_f_register(rt);
                let address = rs_val.wrapping_add_signed(imm as i16 as i32);
                self.cache
                    .write_word(&mut self.memory, address, rt_val.to_bits()) // to_bits()でfpをそのビット列のままのu32データとして解釈
                    .map_err(|e| ProcessorError::MemoryError(e))?;
                self.stats.stores_executed += 1;
            }
            InstructionType::Feq { rs, rt } => {
                let rs_val = self.get_f_register(rs);
                let rt_val = self.get_f_register(rt);
                if rs_val == rt_val {
                    self.fcsr = true;
                } else {
                    self.fcsr = false;
                }
            }
            InstructionType::Flt { rs, rt } => {
                let rs_val = self.get_f_register(rs);
                let rt_val = self.get_f_register(rt);
                if rs_val < rt_val {
                    self.set_condition_flag(true);
                } else {
                    self.set_condition_flag(false);
                }
            }
            InstructionType::Fle { rs, rt } => {
                let rs_val = self.get_f_register(rs);
                let rt_val = self.get_f_register(rt);
                if rs_val <= rt_val {
                    self.set_condition_flag(true);
                } else {
                    self.set_condition_flag(false);
                }
            }
            InstructionType::Fbt { imm } => {
                if self.fcsr {
                    let base_pc = self.pc.wrapping_add(4);
                    // オフセットを計算 (immは16bitなのでi32に符号拡張してから4倍)
                    let offset = (imm as i16 as i32).wrapping_mul(4);
                    // debug!(
                    //     "[JUMP] From: 0x{:08X}, To: 0x{:08X} (addr field: 0x{:07X})",
                    //     self.pc, base_pc.wrapping_add(offset), imm as u32
                    // );
                    self.pc = base_pc.wrapping_add_signed(offset);
                    self.stats.branches_taken += 1;
                    return Ok(true); // 分岐が発生
                }
            }
            InstructionType::Fbf { imm } => {
                if !self.fcsr {
                    let base_pc = self.pc.wrapping_add(4);
                    // オフセットを計算 (immは16bitなのでi32に符号拡張してから4倍)
                    let offset = (imm as i16 as i32).wrapping_mul(4);
                    // debug!(
                    //     "[JUMP] From: 0x{:08X}, To: 0x{:08X} (addr field: 0x{:07X})",
                    //     self.pc, base_pc.wrapping_add(offset), imm as u32
                    // );
                    self.pc = base_pc.wrapping_add_signed(offset);
                    self.stats.branches_taken += 1;
                    return Ok(true); // 分岐が発生
                }
            }
            InstructionType::Fmove { rd, rs } => {
                let rs_val = self.get_f_register(rs);
                self.set_f_register(rd, rs_val);
            }
            InstructionType::Fneg { rd, rs } => {
                let rs_val = self.get_f_register(rs);
                self.set_f_register(rd, -rs_val);
            }
            InstructionType::Fsqrt { rd, rs } => {
                let rs_val = self.get_f_register(rs);
                // let result = rs_val.sqrt();
                let hw_result = fpu_hw::hardware_fsqrt(rs_val);
                self.set_f_register(rd, hw_result);
            }
            InstructionType::Fabs { rd, rs } => {
                let rs_val = self.get_f_register(rs);
                self.set_f_register(rd, rs_val.abs());
            }
            InstructionType::Floor { rd, rs } => {
                let rs_val = self.get_f_register(rs);
                self.set_f_register(rd, rs_val.floor());
            }
            InstructionType::Itof { rd, rs } => {
                let rs_val = self.get_register(rs);
                let hw_result = fpu_hw::hardware_itof(rs_val);
                self.set_f_register(rd, hw_result);
            }
            InstructionType::Ftoi { rd, rs } => {
                let rs_val = self.get_f_register(rs);
                // let result = rs_val.round() as i32 as u32;
                let hw_result = fpu_hw::hardware_ftoi(rs_val);
                self.set_register(rd, hw_result);
            }
            InstructionType::Syscall => {
                // システムコールの実装
                // self.set_register(2, 10); // $v0 = 10 (exit syscall)
                let syscall_number = self.get_register(2); // $v0レジスタからシステムコール番号を取得
                println!(
                    "Syscall実行: $v0 = {} (syscall番号: {})",
                    self.get_register(2),
                    syscall_number
                );

                match syscall_number {
                    1 => {
                        // print_int: $a0レジスタの値を整数として出力
                        let value = self.get_register(4); // $a0レジスタ
                        println!("{}", value as i32);
                    }
                    2 => {
                        // print_float: $f0レジスタの値を浮動小数点数として出力
                        let value = self.get_f_register(0); // $f0レジスタ
                        println!("{}", value as f32);
                    }
                    4 => {
                        // print_string: $a0レジスタのアドレスから文字列を出力
                        let address = self.get_register(4); // $a0レジスタ
                        self.print_string(address)?;
                    }
                    10 => {
                        // exit: プログラム終了
                        println!("プログラムが終了しました");
                        return Err(ProcessorError::ProgramEnd); // プログラム終了
                    }
                    11 => {
                        // print_char: $a0レジスタの値を文字として出力
                        let value = self.get_register(4); // $a0レジスタ
                        print!("{}", value as u8 as char);
                    }
                    _ => {
                        println!("未対応のシステムコール: {}", syscall_number);
                        return Err(ProcessorError::InvalidInstruction(instruction));
                    }
                }
            }
            InstructionType::Invalid => {
                return Err(ProcessorError::InvalidInstruction(instruction));
            } // _ => return Err(ProcessorError::InvalidInstruction(instruction)),
        }
        Ok(false) // 通常の命令の場合、分岐なしを返す
    }

    fn reset_pipeline_timing_state(&mut self) {
        self.pipeline_next_if_cycle = 1;
        self.int_dependencies = [None; REGISTER_COUNT];
        self.float_dependencies = [None; REGISTER_COUNT];
        self.fcsr_dependency = None;
    }

    fn clear_expired_dependencies(&mut self, current_id_cycle: u64) {
        for dep in &mut self.int_dependencies {
            if dep
                .as_ref()
                .is_some_and(|dependency| dependency.wb_cycle < current_id_cycle)
            {
                *dep = None;
            }
        }

        for dep in &mut self.float_dependencies {
            if dep
                .as_ref()
                .is_some_and(|dependency| dependency.wb_cycle < current_id_cycle)
            {
                *dep = None;
            }
        }

        if self
            .fcsr_dependency
            .as_ref()
            .is_some_and(|dependency| dependency.wb_cycle < current_id_cycle)
        {
            self.fcsr_dependency = None;
        }
    }

    fn int_operand(reg: Register) -> PipelineOperand {
        PipelineOperand {
            kind: PipelineOperandKind::Int,
            reg,
        }
    }

    fn float_operand(reg: Register) -> PipelineOperand {
        PipelineOperand {
            kind: PipelineOperandKind::Float,
            reg,
        }
    }

    fn fcsr_operand() -> PipelineOperand {
        PipelineOperand {
            kind: PipelineOperandKind::Fcsr,
            reg: 0,
        }
    }

    fn source_operands(instruction_type: &InstructionType) -> [Option<PipelineOperand>; 3] {
        match instruction_type {
            InstructionType::Sll { rt, .. }
            | InstructionType::Srl { rt, .. }
            | InstructionType::Sra { rt, .. } => [Some(Self::int_operand(*rt)), None, None],
            InstructionType::Jr { rs } | InstructionType::Jalr { rs, .. } => {
                [Some(Self::int_operand(*rs)), None, None]
            }
            InstructionType::Add { rs, rt, .. }
            | InstructionType::Sub { rs, rt, .. }
            | InstructionType::And { rs, rt, .. }
            | InstructionType::Or { rs, rt, .. }
            | InstructionType::Xor { rs, rt, .. }
            | InstructionType::Nor { rs, rt, .. }
            | InstructionType::Slt { rs, rt, .. }
            | InstructionType::Beq { rs, rt, .. }
            | InstructionType::Bne { rs, rt, .. } => [
                Some(Self::int_operand(*rs)),
                Some(Self::int_operand(*rt)),
                None,
            ],
            InstructionType::Addi { rs, .. }
            | InstructionType::Subi { rs, .. }
            | InstructionType::Slti { rs, .. }
            | InstructionType::Sgti { rs, .. }
            | InstructionType::Ori { rs, .. }
            | InstructionType::Lw { rs, .. }
            | InstructionType::Flw { rs, .. }
            | InstructionType::Itof { rs, .. } => [Some(Self::int_operand(*rs)), None, None],
            InstructionType::Sw { rs, rt, .. } => [
                Some(Self::int_operand(*rs)),
                Some(Self::int_operand(*rt)),
                None,
            ],
            InstructionType::Fadd { rs, rt, .. }
            | InstructionType::Fsub { rs, rt, .. }
            | InstructionType::Fmul { rs, rt, .. }
            | InstructionType::Fdiv { rs, rt, .. }
            | InstructionType::Feq { rs, rt }
            | InstructionType::Flt { rs, rt }
            | InstructionType::Fle { rs, rt } => [
                Some(Self::float_operand(*rs)),
                Some(Self::float_operand(*rt)),
                None,
            ],
            InstructionType::Fsqrt { rs, .. }
            | InstructionType::Fabs { rs, .. }
            | InstructionType::Floor { rs, .. }
            | InstructionType::Fmove { rs, .. }
            | InstructionType::Fneg { rs, .. }
            | InstructionType::Ftoi { rs, .. } => [Some(Self::float_operand(*rs)), None, None],
            InstructionType::Fsw { rs, rt, .. } => [
                Some(Self::int_operand(*rs)),
                Some(Self::float_operand(*rt)),
                None,
            ],
            InstructionType::Fbt { .. } | InstructionType::Fbf { .. } => {
                [Some(Self::fcsr_operand()), None, None]
            }
            InstructionType::Syscall => [Some(Self::int_operand(2)), None, None],
            _ => [None, None, None],
        }
    }

    fn destination_operand(
        instruction_type: &InstructionType,
    ) -> Option<(PipelineOperand, WriteReadyStage)> {
        match instruction_type {
            InstructionType::Sll { rd, .. }
            | InstructionType::Srl { rd, .. }
            | InstructionType::Sra { rd, .. }
            | InstructionType::Add { rd, .. }
            | InstructionType::Sub { rd, .. }
            | InstructionType::And { rd, .. }
            | InstructionType::Or { rd, .. }
            | InstructionType::Xor { rd, .. }
            | InstructionType::Nor { rd, .. }
            | InstructionType::Slt { rd, .. }
            | InstructionType::Jalr { rd, .. }
            | InstructionType::Ftoi { rd, .. } => {
                Some((Self::int_operand(*rd), WriteReadyStage::Ex))
            }
            InstructionType::Addi { rt, .. }
            | InstructionType::Subi { rt, .. }
            | InstructionType::Slti { rt, .. }
            | InstructionType::Sgti { rt, .. }
            | InstructionType::Ori { rt, .. }
            | InstructionType::Lui { rt, .. } => {
                Some((Self::int_operand(*rt), WriteReadyStage::Ex))
            }
            InstructionType::Lw { rt, .. } => Some((Self::int_operand(*rt), WriteReadyStage::Mem)),
            InstructionType::Jal { .. } => Some((Self::int_operand(31), WriteReadyStage::Ex)),
            InstructionType::Fadd { rd, .. }
            | InstructionType::Fsub { rd, .. }
            | InstructionType::Fmul { rd, .. }
            | InstructionType::Fdiv { rd, .. }
            | InstructionType::Fsqrt { rd, .. }
            | InstructionType::Fabs { rd, .. }
            | InstructionType::Floor { rd, .. }
            | InstructionType::Itof { rd, .. }
            | InstructionType::Fmove { rd, .. }
            | InstructionType::Fneg { rd, .. } => {
                Some((Self::float_operand(*rd), WriteReadyStage::Ex))
            }
            InstructionType::Flw { rt, .. } => {
                Some((Self::float_operand(*rt), WriteReadyStage::Mem))
            }
            InstructionType::Feq { .. }
            | InstructionType::Flt { .. }
            | InstructionType::Fle { .. } => Some((Self::fcsr_operand(), WriteReadyStage::Ex)),
            _ => None,
        }
    }

    fn control_flush_penalty_cycles(instruction_type: &InstructionType, branch_taken: bool) -> u64 {
        match instruction_type {
            // ジャンプ命令は常に制御フローが変わる
            InstructionType::Jr { .. }
            | InstructionType::Jalr { .. }
            | InstructionType::J { .. }
            | InstructionType::Jal { .. } => 2,
            // 条件分岐は成立時のみフラッシュする
            InstructionType::Beq { .. }
            | InstructionType::Bne { .. }
            | InstructionType::Fbt { .. }
            | InstructionType::Fbf { .. }
                if branch_taken =>
            {
                2
            }
            _ => 0,
        }
    }

    fn fpu_execution_cycles(instruction_type: &InstructionType) -> Option<u64> {
        match instruction_type {
            InstructionType::Ftoi { .. } => Some(2),
            InstructionType::Fadd { .. }
            | InstructionType::Fsub { .. }
            | InstructionType::Fmul { .. }
            | InstructionType::Fdiv { .. }
            | InstructionType::Fsqrt { .. }
            | InstructionType::Fabs { .. }
            | InstructionType::Floor { .. }
            | InstructionType::Feq { .. }
            | InstructionType::Flt { .. }
            | InstructionType::Fle { .. }
            | InstructionType::Fmove { .. }
            | InstructionType::Fneg { .. }
            | InstructionType::Itof { .. } => Some(3),
            _ => None,
        }
    }

    fn get_dependency(&self, operand: PipelineOperand) -> Option<PipelineDependency> {
        match operand.kind {
            PipelineOperandKind::Int => {
                if operand.reg == 0 {
                    None
                } else {
                    self.int_dependencies[operand.reg as usize]
                }
            }
            PipelineOperandKind::Float => self.float_dependencies[operand.reg as usize],
            PipelineOperandKind::Fcsr => self.fcsr_dependency,
        }
    }

    fn set_dependency(&mut self, operand: PipelineOperand, dependency: PipelineDependency) {
        match operand.kind {
            PipelineOperandKind::Int => {
                if operand.reg != 0 {
                    self.int_dependencies[operand.reg as usize] = Some(dependency);
                }
            }
            PipelineOperandKind::Float => {
                self.float_dependencies[operand.reg as usize] = Some(dependency);
            }
            PipelineOperandKind::Fcsr => {
                self.fcsr_dependency = Some(dependency);
            }
        }
    }

    fn update_pipeline_cycle_estimate(
        &mut self,
        instruction: Instruction,
        cache_extra_cycles: u64,
        branch_taken: bool,
    ) {
        let instruction_type = InstructionType::decode(instruction);
        let mut if_cycle = self.pipeline_next_if_cycle;

        self.clear_expired_dependencies(if_cycle + 1);

        for source in Self::source_operands(&instruction_type)
            .into_iter()
            .flatten()
        {
            if let Some(dependency) = self.get_dependency(source) {
                let min_if_cycle = dependency.ready_cycle.saturating_sub(1);
                if min_if_cycle > if_cycle {
                    if_cycle = min_if_cycle;
                }
            }
        }

        let wb_cycle = if_cycle + 4;
        let fpu_extra_cycles = Self::fpu_execution_cycles(&instruction_type)
            .map_or(0, |cycles| cycles.saturating_sub(1));
        let completion_cycle = wb_cycle.saturating_add(fpu_extra_cycles);
        self.stats.total_cycles = self
            .stats
            .total_cycles
            .max(completion_cycle.saturating_add(cache_extra_cycles));

        self.pipeline_next_if_cycle = if_cycle + 1;
        let flush_penalty = Self::control_flush_penalty_cycles(&instruction_type, branch_taken);
        self.pipeline_next_if_cycle = self.pipeline_next_if_cycle.saturating_add(flush_penalty);
        self.pipeline_next_if_cycle = self
            .pipeline_next_if_cycle
            .saturating_add(cache_extra_cycles);

        if let Some((destination, ready_stage)) = Self::destination_operand(&instruction_type) {
            let ready_cycle = match ready_stage {
                WriteReadyStage::Ex => if_cycle + 2,
                WriteReadyStage::Mem => if_cycle + 3,
            };
            self.set_dependency(
                destination,
                PipelineDependency {
                    ready_cycle,
                    wb_cycle,
                },
            );
        }
    }

    fn cache_extra_cycles_since(&self, accesses_before: u64, latency_before: u64) -> u64 {
        let cache_accesses_after = self.cache.get_total_accesses();
        let cache_latency_after = self.cache.get_total_latency_cycles();
        let access_delta = cache_accesses_after.saturating_sub(accesses_before);
        let latency_delta = cache_latency_after.saturating_sub(latency_before);
        latency_delta.saturating_sub(access_delta)
    }

    /// 1命令を実行（フェッチ + 実行）
    pub fn step(&mut self) -> Result<bool, ProcessorError> {
        let cache_accesses_before = self.cache.get_total_accesses();
        let cache_latency_before = self.cache.get_total_latency_cycles();

        let instruction = self.fetch_instruction().map_err(|e| {
            println!("命令フェッチエラー: PC=0x{:08X}, エラー={}", self.pc, e);
            ProcessorError::MemoryError(e)
        })?;

        // if self.pc == 0x000800E4 {
        //     let instruction_type = InstructionType::decode(instruction);
        //     println!("実行: 0x{:08X} ({})", instruction, instruction_type);
        // }

        let branch_taken = match self.execute_instruction(instruction) {
            Ok(bt) => {
                let cache_extra_cycles =
                    self.cache_extra_cycles_since(cache_accesses_before, cache_latency_before);
                self.update_pipeline_cycle_estimate(instruction, cache_extra_cycles, bt);
                bt
            }
            Err(ProcessorError::ProgramEnd) => {
                let cache_extra_cycles =
                    self.cache_extra_cycles_since(cache_accesses_before, cache_latency_before);
                self.update_pipeline_cycle_estimate(instruction, cache_extra_cycles, false);
                println!("プログラムが正常に終了しました");
                return Err(ProcessorError::ProgramEnd);
            }
            Err(e) => {
                println!("命令実行エラー: PC=0x{:08X}, エラー={}", self.pc, e);
                println!("{:08X}", self.input_front);
                // println!("{}", self.dump_registers());
                println!("{}", self.dump_registers());
                println!("{}", self.dump_f_registers());
                return Err(e);
            }
        };

        // 分岐が発生しなかった場合のみPCを4進める
        if !branch_taken {
            self.pc = self.pc.wrapping_add(4);
        }
        self.stats.instructions_executed += 1;

        Ok(branch_taken)
    }

    /// プログラムを実行
    pub fn run(&mut self) -> Result<(), ProcessorError> {
        // let mut instruction_count = 0;
        loop {
            let prev_pc = self.pc;

            match self.step() {
                Ok(true) => {
                    // 分岐が発生
                    if self.pc == prev_pc {
                        println!(
                            "PC 0x{:08x} で無限ループ発生 プログラムを終了します",
                            prev_pc
                        );
                        break;
                    }
                    // instruction_count += 1;
                }
                Ok(false) => {
                    // instruction_count += 1;
                    continue;
                }
                Err(e) => {
                    match e {
                        // ProgramEndエラーなら、正常終了として扱う
                        ProcessorError::ProgramEnd => {
                            break; // ループを抜ける
                        }
                        // それ以外のエラーは本当にエラーとして処理
                        _ => return Err(e),
                    }
                }
            }
        }
        Ok(())
    }

    /// メモリにプログラムをロード
    pub fn load_program(
        &mut self,
        program: &[Instruction],
        start_address: MemoryAddress,
    ) -> Result<(), MemoryError> {
        println!("プログラムをロード中: {} 命令", program.len());
        for (i, instruction) in program.iter().enumerate() {
            let address = start_address + (i * 4) as u32;
            // debug!("命令 {}: 0x{:08X} をアドレス 0x{:08X} に書き込み", i, instruction, address);
            self.memory.write_instruction(address, *instruction)?;
        }
        Ok(())
    }

    /// メモリからデータを読み込む
    #[allow(dead_code)]
    pub fn read_memory(&self, address: MemoryAddress) -> Result<Word, MemoryError> {
        self.memory.read_word(address)
    }

    /// メモリにデータを書き込む
    #[allow(dead_code)]
    pub fn write_memory(&mut self, address: MemoryAddress, value: Word) -> Result<(), MemoryError> {
        self.memory.write_word(address, value)
    }

    /// プロセッサの状態をダンプ
    pub fn dump_state(&self) -> String {
        let mut result = String::new();

        result.push_str("=== プロセッサ状態 ===\n");
        result.push_str(&format!("PC: 0x{:08X}\n", self.pc));
        // result.push_str(&format!("HI: 0x{:08X}\n", self.hi));
        // result.push_str(&format!("LO: 0x{:08X}\n", self.lo));
        result.push_str("\n=== レジスタ ===\n");

        for i in 0..REGISTER_COUNT {
            let reg_name = match i {
                0 => "$zero",
                1 => "$at",
                2 => "$v0",
                3 => "$v1",
                4 => "$a0",
                5 => "$a1",
                6 => "$a2",
                7 => "$a3",
                8 => "$t0",
                9 => "$t1",
                10 => "$t2",
                11 => "$t3",
                12 => "$t4",
                13 => "$t5",
                14 => "$t6",
                15 => "$t7",
                16 => "$s0",
                17 => "$s1",
                18 => "$s2",
                19 => "$s3",
                20 => "$s4",
                21 => "$s5",
                22 => "$s6",
                23 => "$s7",
                24 => "$t8",
                25 => "$t9",
                26 => "$k0",
                27 => "$k1",
                28 => "$gp",
                29 => "$sp",
                30 => "$fp",
                31 => "$ra",
                _ => "???",
            };

            result.push_str(&format!(
                "{}: 0x{:08X} ({})\n",
                reg_name, self.registers[i], self.registers[i] as i32
            ));
        }

        result.push_str("\n=== 浮動小数点レジスタ ===\n");
        for i in 0..REGISTER_COUNT {
            let reg_name = match i {
                0 => "$f0 ",
                1 => "$f1 ",
                2 => "$f2 ",
                3 => "$f3 ",
                4 => "$f4 ",
                5 => "$f5 ",
                6 => "$f6 ",
                7 => "$f7 ",
                8 => "$f8 ",
                9 => "$f9 ",
                10 => "$f10",
                11 => "$f11",
                12 => "$f12",
                13 => "$f13",
                14 => "$f14",
                15 => "$f15",
                16 => "$f16",
                17 => "$f17",
                18 => "$f18",
                19 => "$f19",
                20 => "$f20",
                21 => "$f21",
                22 => "$f22",
                23 => "$f23",
                24 => "$f24",
                25 => "$f25",
                26 => "$f26",
                27 => "$f27",
                28 => "$f28",
                29 => "$f29",
                30 => "$f30",
                31 => "$f31",
                _ => "???",
            };
            result.push_str(&format!(
                "{}: 0x{:08X} ({})\n",
                reg_name,
                self.f_registers[i].to_bits(),
                self.f_registers[i]
            ));
        }

        result.push_str(&format!("\n=== 統計情報 ===\n{}", self.stats));
        result.push_str(&format!(
            "\n=== キャッシュ統計 ===\n{}",
            self.cache.get_stats()
        ));

        result
    }

    /// 統計情報を取得
    pub fn get_stats(&self) -> &ProcessorStats {
        &self.stats
    }

    /// キャッシュ統計を取得
    pub fn get_cache_stats(&self) -> &CacheStats {
        self.cache.get_stats()
    }

    /// 統計情報をリセット
    #[allow(dead_code)]
    pub fn reset_stats(&mut self) {
        self.stats = ProcessorStats::default();
        self.reset_pipeline_timing_state();
        self.cache.reset_stats();
    }

    /// 文字列を出力（システムコール用）
    fn print_string(&self, address: MemoryAddress) -> Result<(), MemoryError> {
        let mut current_addr = address;
        let mut result = String::new();

        loop {
            let byte = self.memory.read_byte(current_addr)?;
            if byte == 0 {
                break; // null文字で終了
            }
            result.push(byte as char);
            current_addr += 1;
        }

        print!("{}", result);
        Ok(())
    }
}

/// プロセッサエラー
#[derive(Debug, Clone, PartialEq)]
pub enum ProcessorError {
    MemoryError(MemoryError),
    InvalidInstruction(Instruction),
    ProgramEnd,
}

impl From<MemoryError> for ProcessorError {
    fn from(err: MemoryError) -> Self {
        ProcessorError::MemoryError(err)
    }
}

impl fmt::Display for ProcessorError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            ProcessorError::MemoryError(e) => write!(f, "メモリエラー: {}", e),
            ProcessorError::InvalidInstruction(inst) => write!(f, "無効な命令: 0x{:08X}", inst),
            ProcessorError::ProgramEnd => write!(f, "プログラムが終了しました"),
        }
    }
}

impl std::error::Error for ProcessorError {}

impl fmt::Display for ProcessorStats {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "\n")?;
        write!(f, "実行命令数: {}\n", self.instructions_executed)?;
        write!(f, "分岐命令数: {}\n", self.branches_taken)?;
        write!(f, "ロード命令数: {}\n", self.loads_executed)?;
        write!(f, "ストア命令数: {}\n", self.stores_executed)?;
        write!(f, "合計サイクル数: {}\n", self.total_cycles)?;
        write!(
            f,
            "実行時間: {}s\n",
            (self.total_cycles as f64 / CLOCK_FREQ as f64) as f32
        )
    }
}
