//! MIPS命令セットの定義と実装

use std::fmt;

/// MIPSレジスタ番号（0-31）
pub type Register = u8;

/// 32ビットの命令
pub type Instruction = u32;

/// 整数データ
pub type Word = u32;

/// 浮動小数点数データ
pub type FWord = f32;

/// 16ビットの即値
pub type Immediate = u16;

/// 26ビットのアドレス
pub type Address = u32;

/// MIPS命令の種類
#[allow(dead_code)]
#[derive(Debug, Clone, PartialEq)]
pub enum InstructionType {
    // R形式命令
    Sll {
        rd: Register,
        rt: Register,
        shamt: u8,
    },
    Srl {
        rd: Register,
        rt: Register,
        shamt: u8,
    },
    Sra {
        rd: Register,
        rt: Register,
        shamt: u8,
    },
    Jr {
        rs: Register,
    },
    Jalr {
        rd: Register,
        rs: Register,
    },
    Add {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Sub {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    And {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Or {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Xor {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Nor {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Slt {
        rd: Register,
        rs: Register,
        rt: Register,
    },

    // I形式命令
    Beq {
        rs: Register,
        rt: Register,
        imm: Immediate,
    },
    Bne {
        rs: Register,
        rt: Register,
        imm: Immediate,
    },
    Addi {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },
    Subi {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },
    Slti {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },
    Sgti {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },
    Ori {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },
    Lui {
        rt: Register,
        imm: Immediate,
    },
    Lw {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },
    Sw {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },

    // J形式命令
    J {
        addr: Address,
    },
    Jal {
        addr: Address,
    },

    // FPU命令
    Fadd {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Fsub {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Fmul {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Fdiv {
        rd: Register,
        rs: Register,
        rt: Register,
    },
    Fsqrt {
        rd: Register,
        rs: Register,
    },
    Fabs {
        rd: Register,
        rs: Register,
    },
    Floor {
        rd: Register,
        rs: Register,
    },
    Flw {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },
    Fsw {
        rt: Register,
        rs: Register,
        imm: Immediate,
    },
    Feq {
        rs: Register,
        rt: Register,
    },
    Flt {
        rs: Register,
        rt: Register,
    },
    Fle {
        rs: Register,
        rt: Register,
    },
    Fbt {
        imm: Immediate,
    },
    Fbf {
        imm: Immediate,
    },
    Itof {
        rd: Register,
        rs: Register,
    },
    Ftoi {
        rd: Register,
        rs: Register,
    },
    Fmove {
        rd: Register,
        rs: Register,
    },
    Fneg {
        rd: Register,
        rs: Register,
    },

    // システムコール
    Syscall,

    // 無効な命令
    Invalid,
}

impl InstructionType {
    /// 32ビット命令から命令をデコードする関数
    pub fn decode(instruction: Instruction) -> Self {
        let opcode = (instruction >> 26) as u8;
        let rs = ((instruction >> 21) & 0x1F) as u8;
        let rt = ((instruction >> 16) & 0x1F) as u8;
        let rd = ((instruction >> 11) & 0x1F) as u8;
        let shamt = ((instruction >> 6) & 0x1F) as u8;
        let funct = (instruction & 0x3F) as u8;
        let imm = (instruction & 0xFFFF) as u16;
        let addr = instruction & 0x3FFFFFF;

        match opcode {
            0x00 => {
                // R形式命令
                match funct {
                    0x00 => InstructionType::Sll { rd, rt, shamt },
                    0x02 => InstructionType::Srl { rd, rt, shamt },
                    0x03 => InstructionType::Sra { rd, rt, shamt },
                    0x08 => InstructionType::Jr { rs },
                    0x09 => InstructionType::Jalr { rd, rs },
                    0x20 => InstructionType::Add { rd, rs, rt },
                    0x22 => InstructionType::Sub { rd, rs, rt },
                    0x24 => InstructionType::And { rd, rs, rt },
                    0x25 => InstructionType::Or { rd, rs, rt },
                    0x2A => InstructionType::Slt { rd, rs, rt },
                    0x0C => InstructionType::Syscall,
                    _ => InstructionType::Invalid,
                }
            }
            0x02 => InstructionType::J { addr },
            0x03 => InstructionType::Jal { addr },
            0x04 => InstructionType::Beq { rs, rt, imm },
            0x05 => InstructionType::Bne { rs, rt, imm },
            0x08 => InstructionType::Addi { rt, rs, imm },
            0x09 => InstructionType::Subi { rt, rs, imm },
            0x0A => InstructionType::Slti { rt, rs, imm },
            0x0B => InstructionType::Sgti { rt, rs, imm },
            0x0D => InstructionType::Ori { rt, rs, imm },
            0x0F => InstructionType::Lui { rt, imm },
            0x11 => {
                // FPU命令(ロード・ストア以外)
                let fmt = ((instruction >> 21) & 0x1F) as u8;
                let rt = ((instruction >> 16) & 0x1F) as u8;
                let rs = ((instruction >> 11) & 0x1F) as u8;
                let rd = ((instruction >> 6) & 0x1F) as u8;
                let imm = (instruction & 0xFFFF) as u16;
                match fmt {
                    0x10 => match funct {
                        0x00 => InstructionType::Fadd { rd, rs, rt },
                        0x01 => InstructionType::Fsub { rd, rs, rt },
                        0x02 => InstructionType::Fmul { rd, rs, rt },
                        0x03 => InstructionType::Fdiv { rd, rs, rt },
                        0x04 => InstructionType::Fsqrt { rd, rs },
                        0x05 => InstructionType::Fabs { rd, rs },
                        0x0F => InstructionType::Floor { rd, rs },
                        0x06 => InstructionType::Fmove { rd, rs },
                        0x07 => InstructionType::Fneg { rd, rs },
                        0x24 => InstructionType::Ftoi { rd, rs },
                        0x32 => InstructionType::Feq { rs, rt },
                        0x3C => InstructionType::Flt { rs, rt },
                        0x3E => InstructionType::Fle { rs, rt },
                        _ => InstructionType::Invalid,
                    },
                    0x08 => match rt {
                        0x01 => InstructionType::Fbt { imm },
                        0x00 => InstructionType::Fbf { imm },
                        _ => InstructionType::Invalid,
                    },
                    0x14 => InstructionType::Itof { rd, rs },
                    _ => InstructionType::Invalid,
                }
            }
            0x23 => InstructionType::Lw { rt, rs, imm },
            0x2B => InstructionType::Sw { rt, rs, imm },
            0x31 => InstructionType::Flw { rt, rs, imm },
            0x39 => InstructionType::Fsw { rt, rs, imm },
            _ => InstructionType::Invalid,
        }
    }
}

// 命令の詳細を表示
impl fmt::Display for InstructionType {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            InstructionType::Sll { rd, rt, shamt } => {
                write!(f, "sll ${}, ${}, {}", rd, rt, shamt)
            }
            InstructionType::Srl { rd, rt, shamt } => {
                write!(f, "srl ${}, ${}, {}", rd, rt, shamt)
            }
            InstructionType::Sra { rd, rt, shamt } => {
                write!(f, "sra ${}, ${}, {}", rd, rt, shamt)
            }
            InstructionType::Jr { rs } => {
                write!(f, "jr ${}", rs)
            }
            InstructionType::Jalr { rd, rs } => {
                write!(f, "jalr ${}, ${}", rd, rs)
            }
            InstructionType::Add { rd, rs, rt } => {
                write!(f, "add ${}, ${}, ${}", rd, rs, rt)
            }
            InstructionType::Sub { rd, rs, rt } => {
                write!(f, "sub ${}, ${}, ${}", rd, rs, rt)
            }
            InstructionType::And { rd, rs, rt } => {
                write!(f, "and ${}, ${}, ${}", rd, rs, rt)
            }
            InstructionType::Or { rd, rs, rt } => {
                write!(f, "or ${}, ${}, ${}", rd, rs, rt)
            }
            InstructionType::Xor { rd, rs, rt } => {
                write!(f, "xor ${}, ${}, ${}", rd, rs, rt)
            }
            InstructionType::Nor { rd, rs, rt } => {
                write!(f, "nor ${}, ${}, ${}", rd, rs, rt)
            }
            InstructionType::Slt { rd, rs, rt } => {
                write!(f, "slt ${}, ${}, ${}", rd, rs, rt)
            }
            InstructionType::Beq { rs, rt, imm } => {
                write!(f, "beq ${}, ${}, {}", rs, rt, *imm as i16)
            }
            InstructionType::Bne { rs, rt, imm } => {
                write!(f, "bne ${}, ${}, {}", rs, rt, *imm as i16)
            }
            InstructionType::Addi { rt, rs, imm } => {
                write!(f, "addi ${}, ${}, {}", rt, rs, *imm as i16)
            }
            InstructionType::Subi { rt, rs, imm } => {
                write!(f, "subi ${}, ${}, {}", rt, rs, *imm as i16)
            }
            InstructionType::Slti { rt, rs, imm } => {
                write!(f, "slti ${}, ${}, {}", rt, rs, *imm as i16)
            }
            InstructionType::Sgti { rt, rs, imm } => {
                write!(f, "sgti ${}, ${}, {}", rt, rs, *imm as i16)
            }
            InstructionType::Ori { rt, rs, imm } => {
                write!(f, "ori ${}, ${}, {}", rt, rs, imm)
            }
            InstructionType::Lui { rt, imm } => {
                write!(f, "lui ${}, {}", rt, imm)
            }
            InstructionType::Lw { rt, rs, imm } => {
                write!(f, "lw ${}, {}(${})", rt, *imm as i16, rs)
            }
            InstructionType::Sw { rt, rs, imm } => {
                write!(f, "sw ${}, {}(${})", rt, *imm as i16, rs)
            }
            InstructionType::J { addr } => {
                write!(f, "j 0x{:08X}", addr << 2)
            }
            InstructionType::Jal { addr } => {
                write!(f, "jal 0x{:08X}", addr << 2)
            }
            InstructionType::Fadd { rd, rs, rt } => {
                write!(f, "fadd $f{}, $f{}, $f{}", rd, rs, rt)
            }
            InstructionType::Fsub { rd, rs, rt } => {
                write!(f, "fsub $f{}, $f{}, $f{}", rd, rs, rt)
            }
            InstructionType::Fmul { rd, rs, rt } => {
                write!(f, "fmul $f{}, $f{}, $f{}", rd, rs, rt)
            }
            InstructionType::Fdiv { rd, rs, rt } => {
                write!(f, "fdiv $f{}, $f{}, $f{}", rd, rs, rt)
            }
            InstructionType::Flw { rt, rs, imm } => {
                write!(f, "flw $f{}, {}(${})", rt, *imm as i16, rs)
            }
            InstructionType::Fsw { rt, rs, imm } => {
                write!(f, "fsw $f{}, {}(${})", rt, *imm as i16, rs)
            }
            InstructionType::Feq { rs, rt } => {
                write!(f, "feq $f{}, $f{}", rs, rt)
            }
            InstructionType::Flt { rs, rt } => {
                write!(f, "flt $f{}, $f{}", rs, rt)
            }
            InstructionType::Fle { rs, rt } => {
                write!(f, "fle $f{}, $f{}", rs, rt)
            }
            InstructionType::Fbt { imm } => {
                write!(f, "fbt {}", *imm as i16)
            }
            InstructionType::Fbf { imm } => {
                write!(f, "fbf {}", *imm as i16)
            }
            InstructionType::Fmove { rd, rs } => {
                write!(f, "fmove $f{}, $f{}", rd, rs)
            }
            InstructionType::Fneg { rd, rs } => {
                write!(f, "fneg $f{}, $f{}", rd, rs)
            }
            InstructionType::Fsqrt { rd, rs } => {
                write!(f, "fsqrt $f{}, $f{}", rd, rs)
            }
            InstructionType::Fabs { rd, rs } => {
                write!(f, "fabs $f{}, $f{}", rd, rs)
            }
            InstructionType::Floor { rd, rs } => {
                write!(f, "floor $f{}, $f{}", rd, rs)
            }
            InstructionType::Itof { rd, rs } => {
                write!(f, "itof $f{}, ${}", rd, rs)
            }
            InstructionType::Ftoi { rd, rs } => {
                write!(f, "ftoi ${}, $f{}", rd, rs)
            }
            InstructionType::Syscall => {
                write!(f, "syscall")
            }
            InstructionType::Invalid => {
                write!(f, "invalid")
            }
        }
    }
}
