use crate::transform::transform_conds;
use crate::transform::transform_fmts;
use crate::transform::transform_functs;
use crate::transform::transform_opecodes;
use crate::transform::transform_operands;
use crate::Instruction;
use crate::PROGRAM_START;
use std::collections::HashMap;
use std::io::{Error, ErrorKind};

const REGS: [&str; 32] = [
    "$zero", "$at", "$v0", "$v1", "$a0", "$a1", "$a2", "$a3", "$t0", "$t1", "$t2", "$t3", "$t4",
    "$t5", "$t6", "$t7", "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7", "$t8", "$t9",
    "$k0", "$k1", "$gp", "$sp", "$fp", "$ra",
];

const FREGS: [&str; 32] = [
    "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8", "$f9", "$f10", "$f11", "$f12",
    "$f13", "$f14", "$f15", "$f16", "$f17", "$f18", "$f19", "$f20", "$f21", "$f22", "$f23", "$f24",
    "$f25", "$f26", "$f27", "$f28", "$f29", "$f30", "$f31",
];

pub fn transform_instruction(
    instruction: &Instruction,
    symbol_table: &HashMap<String, u32>,
    address: u32,
) -> Result<u32, Error> {
    let decoded_instruction: u32;
    let transformed_opecode: u32 = transform_opecodes::transform_opecode(&instruction.opecode)?;
    // println!("transformed_opecode: {}", transformed_opecode);

    match transformed_opecode {
        0x00 => {
            let transformed_funct: u32 = transform_functs::transform_funct(&instruction.opecode)?;
            match transformed_funct {
                0x0C => {
                    // システムコール
                    decoded_instruction = transformed_funct;
                }
                0x00 | 0x02 | 0x03 => {
                    // sll, srl, sra 命令
                    if FREGS.contains(&instruction.operands[0].as_str())
                        || FREGS.contains(&instruction.operands[1].as_str())
                        || FREGS.contains(&instruction.operands[2].as_str())
                    {
                        return Err(Error::new(
                            ErrorKind::InvalidInput,
                            "Non-FPU instruction contains float register",
                        ));
                    }
                    let transformed_rd: u32 = transform_operands::transform_operand(
                        &instruction.operands[0],
                        &symbol_table,
                    )?;
                    let transformed_rt: u32 = transform_operands::transform_operand(
                        &instruction.operands[1],
                        &symbol_table,
                    )?;
                    let transformed_shamt: u32 = transform_operands::transform_operand(
                        &instruction.operands[2],
                        &symbol_table,
                    )?;
                    let transformed_rs: u32 = 0;
                    decoded_instruction = transformed_opecode << 26
                        | transformed_rs << 21
                        | transformed_rt << 16
                        | transformed_rd << 11
                        | transformed_shamt << 6
                        | transformed_funct;
                }
                0x08 => {
                    // jr 命令
                    if FREGS.contains(&instruction.operands[0].as_str()) {
                        return Err(Error::new(
                            ErrorKind::InvalidInput,
                            "Non-FPU instruction contains float register",
                        ));
                    }
                    let transformed_rd: u32 = 0;
                    let transformed_rs: u32 = transform_operands::transform_operand(
                        &instruction.operands[0],
                        &symbol_table,
                    )?;
                    let transformed_rt: u32 = 0;
                    let transformed_shamt: u32 = 0;
                    decoded_instruction = transformed_opecode << 26
                        | transformed_rs << 21
                        | transformed_rt << 16
                        | transformed_rd << 11
                        | transformed_shamt << 6
                        | transformed_funct;
                }
                0x09 => {
                    // jalr 命令
                    if FREGS.contains(&instruction.operands[0].as_str())
                        || FREGS.contains(&instruction.operands[1].as_str())
                    {
                        return Err(Error::new(
                            ErrorKind::InvalidInput,
                            "Non-FPU instruction contains float register",
                        ));
                    }
                    let transformed_rd: u32 = transform_operands::transform_operand(
                        &instruction.operands[0],
                        &symbol_table,
                    )?;
                    let transformed_rs: u32 = transform_operands::transform_operand(
                        &instruction.operands[1],
                        &symbol_table,
                    )?;
                    let transformed_rt: u32 = 0;
                    let transformed_shamt: u32 = 0;
                    decoded_instruction = transformed_opecode << 26
                        | transformed_rs << 21
                        | transformed_rt << 16
                        | transformed_rd << 11
                        | transformed_shamt << 6
                        | transformed_funct;
                }
                0x20 | 0x22 | 0x24 | 0x25 | 0x26 | 0x27 | 0x2A => {
                    // add, sub, and, or, xor, nor, slt 命令
                    if FREGS.contains(&instruction.operands[0].as_str())
                        || FREGS.contains(&instruction.operands[1].as_str())
                        || FREGS.contains(&instruction.operands[2].as_str())
                    {
                        return Err(Error::new(
                            ErrorKind::InvalidInput,
                            "Non-FPU instruction contains float register",
                        ));
                    }
                    let transformed_rd: u32 = transform_operands::transform_operand(
                        &instruction.operands[0],
                        &symbol_table,
                    )?;
                    let transformed_rs: u32 = transform_operands::transform_operand(
                        &instruction.operands[1],
                        &symbol_table,
                    )?;
                    let transformed_rt: u32 = transform_operands::transform_operand(
                        &instruction.operands[2],
                        &symbol_table,
                    )?;
                    let transformed_shamt: u32 = 0;
                    decoded_instruction = transformed_opecode << 26
                        | transformed_rs << 21
                        | transformed_rt << 16
                        | transformed_rd << 11
                        | transformed_shamt << 6
                        | transformed_funct;
                }
                _ => {
                    return Err(Error::new(ErrorKind::InvalidInput, "Invalid funct"));
                }
            }
        }
        0x02 | 0x03 => {
            // J形式命令
            let transformed_addr: u32 =
                transform_operands::transform_operand(&instruction.operands[0], &symbol_table)?;
            decoded_instruction =
                transformed_opecode << 26 | transformed_addr + (PROGRAM_START >> 2);
        }
        0x04 | 0x05 => {
            // I形式命令(条件分岐)
            if FREGS.contains(&instruction.operands[0].as_str())
                || FREGS.contains(&instruction.operands[1].as_str())
                || FREGS.contains(&instruction.operands[2].as_str())
            {
                return Err(Error::new(
                    ErrorKind::InvalidInput,
                    "Non-FPU instruction contains float register",
                ));
            }
            let transformed_rs: u32 =
                transform_operands::transform_operand(&instruction.operands[0], &symbol_table)?;
            let transformed_rt: u32 =
                transform_operands::transform_operand(&instruction.operands[1], &symbol_table)?;
            let transformed_imm: i32 =
                (transform_operands::transform_operand(&instruction.operands[2], &symbol_table)?
                    as i32
                    - address as i32
                    - 1) as i32; // 最後の定数は要調整
            decoded_instruction = transformed_opecode << 26
                | transformed_rs << 21
                | transformed_rt << 16
                | (transformed_imm as u32 & 0x0000FFFF);
        }
        0x08 | 0x09 | 0x0A | 0x0B | 0x0C | 0x0D => {
            // I形式命令(即値演算)
            if FREGS.contains(&instruction.operands[0].as_str())
                || FREGS.contains(&instruction.operands[1].as_str())
                || FREGS.contains(&instruction.operands[2].as_str())
            {
                return Err(Error::new(
                    ErrorKind::InvalidInput,
                    "Non-FPU instruction contains float register",
                ));
            }
            let transformed_rt: u32 =
                transform_operands::transform_operand(&instruction.operands[0], &symbol_table)?;
            let transformed_rs: u32 =
                transform_operands::transform_operand(&instruction.operands[1], &symbol_table)?;
            let transformed_imm: i32 =
                transform_operands::transform_operand(&instruction.operands[2], &symbol_table)?
                    as i32;
            decoded_instruction = transformed_opecode << 26
                | transformed_rs << 21
                | transformed_rt << 16
                | (transformed_imm as u32 & 0x0000FFFF);
        }
        0x0F => {
            // I形式命令(lui)
            if FREGS.contains(&instruction.operands[0].as_str())
                || FREGS.contains(&instruction.operands[1].as_str())
            {
                return Err(Error::new(
                    ErrorKind::InvalidInput,
                    "Non-FPU instruction contains float register",
                ));
            }
            let transformed_rt: u32 =
                transform_operands::transform_operand(&instruction.operands[0], &symbol_table)?;
            let transformed_imm: i32 =
                transform_operands::transform_operand(&instruction.operands[1], &symbol_table)?
                    as i32;
            let transformed_rs: u32 = 0;
            decoded_instruction = transformed_opecode << 26
                | transformed_rs << 21
                | transformed_rt << 16
                | (transformed_imm as u32 & 0x0000FFFF);
        }
        0x11 => {
            // FPU命令（flw,fsw以外）
            let transformed_fmt: u32 = transform_fmts::transform_fmt(&instruction.opecode)?;
            match transformed_fmt {
                0x10 => {
                    let transformed_funct: u32 =
                        transform_functs::transform_funct(&instruction.opecode)?;
                    match transformed_funct {
                        // fp四則演算
                        0x00 | 0x01 | 0x02 | 0x03 => {
                            if REGS.contains(&instruction.operands[0].as_str())
                                || REGS.contains(&instruction.operands[1].as_str())
                                || REGS.contains(&instruction.operands[2].as_str())
                            {
                                return Err(Error::new(
                                    ErrorKind::InvalidInput,
                                    "FPU instruction contains int register",
                                ));
                            }
                            let transformed_rd: u32 = transform_operands::transform_operand(
                                &instruction.operands[0],
                                &symbol_table,
                            )?;
                            let transformed_rs: u32 = transform_operands::transform_operand(
                                &instruction.operands[1],
                                &symbol_table,
                            )?;
                            let transformed_rt: u32 = transform_operands::transform_operand(
                                &instruction.operands[2],
                                &symbol_table,
                            )?;
                            decoded_instruction = transformed_opecode << 26
                                | 0b10000 << 21
                                | transformed_rt << 16
                                | transformed_rs << 11
                                | transformed_rd << 6
                                | transformed_funct;
                        }
                        // fsqrt,fabs,floor
                        0x04 | 0x05 | 0x0F => {
                            if REGS.contains(&instruction.operands[0].as_str())
                                || REGS.contains(&instruction.operands[1].as_str())
                            {
                                return Err(Error::new(
                                    ErrorKind::InvalidInput,
                                    "FPU instruction contains int register",
                                ));
                            }
                            let transformed_rd: u32 = transform_operands::transform_operand(
                                &instruction.operands[0],
                                &symbol_table,
                            )?;
                            let transformed_rs: u32 = transform_operands::transform_operand(
                                &instruction.operands[1],
                                &symbol_table,
                            )?;
                            decoded_instruction = transformed_opecode << 26
                                | 0b10000 << 21
                                | transformed_rs << 11
                                | transformed_rd << 6
                                | transformed_funct;
                        }
                        // fmove
                        0x06 => {
                            if REGS.contains(&instruction.operands[0].as_str())
                                || REGS.contains(&instruction.operands[1].as_str())
                            {
                                return Err(Error::new(
                                    ErrorKind::InvalidInput,
                                    "FPU instruction contains int register",
                                ));
                            }
                            let transformed_rd: u32 = transform_operands::transform_operand(
                                &instruction.operands[0],
                                &symbol_table,
                            )?;
                            let transformed_rs: u32 = transform_operands::transform_operand(
                                &instruction.operands[1],
                                &symbol_table,
                            )?;
                            decoded_instruction = transformed_opecode << 26
                                | 0b10000 << 21
                                | transformed_rs << 11
                                | transformed_rd << 6
                                | transformed_funct;
                        }
                        // fneg
                        0x07 => {
                            if REGS.contains(&instruction.operands[0].as_str())
                                || REGS.contains(&instruction.operands[1].as_str())
                            {
                                return Err(Error::new(
                                    ErrorKind::InvalidInput,
                                    "FPU instruction contains int register",
                                ));
                            }
                            let transformed_rd: u32 = transform_operands::transform_operand(
                                &instruction.operands[0],
                                &symbol_table,
                            )?;
                            let transformed_rs: u32 = transform_operands::transform_operand(
                                &instruction.operands[1],
                                &symbol_table,
                            )?;
                            decoded_instruction = transformed_opecode << 26
                                | 0b10000 << 21
                                | transformed_rs << 11
                                | transformed_rd << 6
                                | transformed_funct;
                        }
                        // ftoi
                        0x24 => {
                            if FREGS.contains(&instruction.operands[0].as_str())
                                || REGS.contains(&instruction.operands[1].as_str())
                            {
                                return Err(Error::new(ErrorKind::InvalidInput, "FPU instruction contains int register or non-FPU instruction contains float register"));
                            }
                            let transformed_rd: u32 = transform_operands::transform_operand(
                                &instruction.operands[0],
                                &symbol_table,
                            )?;
                            let transformed_rs: u32 = transform_operands::transform_operand(
                                &instruction.operands[1],
                                &symbol_table,
                            )?;
                            decoded_instruction = transformed_opecode << 26
                                | transformed_fmt << 21
                                | transformed_rs << 11
                                | transformed_rd << 6
                                | transformed_funct;
                        }
                        // feq,flt,fle
                        0x32 | 0x3C | 0x3E => {
                            if REGS.contains(&instruction.operands[0].as_str())
                                || REGS.contains(&instruction.operands[1].as_str())
                            {
                                return Err(Error::new(
                                    ErrorKind::InvalidInput,
                                    "FPU instruction contains int register",
                                ));
                            }
                            let transformed_rs: u32 = transform_operands::transform_operand(
                                &instruction.operands[0],
                                &symbol_table,
                            )?;
                            let transformed_rt: u32 = transform_operands::transform_operand(
                                &instruction.operands[1],
                                &symbol_table,
                            )?;
                            decoded_instruction = transformed_opecode << 26
                                | 0b10000 << 21
                                | transformed_rt << 16
                                | transformed_rs << 11
                                | transformed_funct;
                        }
                        _ => {
                            return Err(Error::new(ErrorKind::InvalidInput, "Invalid funct"));
                        }
                    }
                }
                // fbt,fbf
                0x08 => {
                    let transformed_cond: u32 =
                        transform_conds::transform_cond(&instruction.opecode)?;
                    let transformed_imm: i32 = (transform_operands::transform_operand(
                        &instruction.operands[0],
                        &symbol_table,
                    )? as i32
                        - address as i32
                        - 1) as i32;
                    decoded_instruction = transformed_opecode << 26
                        | transformed_fmt << 21
                        | transformed_cond << 16
                        | (transformed_imm as u32 & 0x0000FFFF);
                }
                // itof
                0x14 => {
                    if REGS.contains(&instruction.operands[0].as_str())
                        || FREGS.contains(&instruction.operands[1].as_str())
                    {
                        return Err(Error::new(ErrorKind::InvalidInput, "FPU instruction contains int register or non-FPU instruction contains float register"));
                    }
                    let transformed_rd: u32 = transform_operands::transform_operand(
                        &instruction.operands[0],
                        &symbol_table,
                    )?;
                    let transformed_rs: u32 = transform_operands::transform_operand(
                        &instruction.operands[1],
                        &symbol_table,
                    )?;
                    decoded_instruction = transformed_opecode << 26
                        | transformed_fmt << 21
                        | transformed_rs << 11
                        | transformed_rd << 6
                        | 0b100000;
                }
                _ => {
                    return Err(Error::new(ErrorKind::InvalidInput, "Invalid fmt"));
                }
            }
        }
        0x23 | 0x2B => {
            // I形式命令(ロード・ストア)
            if FREGS.contains(&instruction.operands[0].as_str())
                || FREGS.contains(&instruction.operands[1].as_str())
                || FREGS.contains(&instruction.operands[2].as_str())
            {
                return Err(Error::new(
                    ErrorKind::InvalidInput,
                    "Non-FPU instruction contains float register",
                ));
            }
            let transformed_rt: u32 =
                transform_operands::transform_operand(&instruction.operands[0], &symbol_table)?;
            let transformed_imm: i32 =
                transform_operands::transform_operand(&instruction.operands[1], &symbol_table)?
                    as i32;
            let transformed_rs: u32 =
                transform_operands::transform_operand(&instruction.operands[2], &symbol_table)?;
            decoded_instruction = transformed_opecode << 26
                | transformed_rs << 21
                | transformed_rt << 16
                | (transformed_imm as u32 & 0x0000FFFF);
        }
        0x31 => {
            // flw命令
            if REGS.contains(&instruction.operands[0].as_str())
                || FREGS.contains(&instruction.operands[2].as_str())
            {
                return Err(Error::new(ErrorKind::InvalidInput, "FPU instruction contains int register or non-FPU instruction contains float register"));
            }
            let transformed_rt: u32 =
                transform_operands::transform_operand(&instruction.operands[0], &symbol_table)?;
            let transformed_imm: i32 =
                transform_operands::transform_operand(&instruction.operands[1], &symbol_table)?
                    as i32;
            let transformed_rs: u32 =
                transform_operands::transform_operand(&instruction.operands[2], &symbol_table)?;
            decoded_instruction = transformed_opecode << 26
                | transformed_rs << 21
                | transformed_rt << 16
                | (transformed_imm as u32 & 0x0000FFFF);
        }
        0x39 => {
            // fsw命令
            if REGS.contains(&instruction.operands[0].as_str())
                || FREGS.contains(&instruction.operands[2].as_str())
            {
                return Err(Error::new(ErrorKind::InvalidInput, "FPU instruction contains int register or non-FPU instruction contains float register"));
            }
            let transformed_rt: u32 =
                transform_operands::transform_operand(&instruction.operands[0], &symbol_table)?;
            let transformed_imm: i32 =
                transform_operands::transform_operand(&instruction.operands[1], &symbol_table)?
                    as i32;
            let transformed_rs: u32 =
                transform_operands::transform_operand(&instruction.operands[2], &symbol_table)?;
            decoded_instruction = transformed_opecode << 26
                | transformed_rs << 21
                | transformed_rt << 16
                | (transformed_imm as u32 & 0x0000FFFF);
        }
        _ => {
            return Err(Error::new(
                ErrorKind::InvalidInput,
                "Invalid opecode in transform_instructions",
            ));
        }
    }
    Ok(decoded_instruction)
}
