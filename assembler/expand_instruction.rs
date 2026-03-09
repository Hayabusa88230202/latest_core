use crate::parse_mips_line;
use crate::Instruction;
use std::collections::HashMap;
use std::io::{Error, ErrorKind};

pub fn expand_instruction(
    line: &str,
    symbol_table: &HashMap<String, u32>,
    use_symbol_table: bool,
) -> Result<Vec<String>, Error> {
    let mut expanded_lines: Vec<String> = Vec::new();
    let instruction: Instruction = parse_mips_line::parse_mips_line(line).map_err(|e| {
        let error_message = format!("Failed to parse MIPS line: '{}' (Detail: {:?})", line, e);
        Error::new(ErrorKind::InvalidInput, error_message)
    })?;

    match instruction.opecode.as_str() {
        "move" => {
            // move rt, rs  ->  addi rt, rs, 0
            let rt = &instruction.operands[0];
            let rs = &instruction.operands[1];
            let expanded_line = format!("addi {}, {}, 0", rt, rs);
            expanded_lines.push(expanded_line);
        }
        "li" => {
            let imm: u32;
            if instruction.operands[1].starts_with("0x") {
                let trimmed = &instruction.operands[1].strip_prefix("0x").ok_or_else(|| {
                    Error::new(ErrorKind::InvalidInput, "Immediate Prefix mismatch")
                })?;
                let value: u32 = u32::from_str_radix(trimmed, 16)
                    .map_err(|_| Error::new(ErrorKind::InvalidInput, "Invalid immediate value"))?;
                imm = value;
                // println!("{}",value);
            } else {
                imm = instruction.operands[1]
                    .parse::<i32>()
                    .map_err(|_| Error::new(ErrorKind::InvalidInput, "Invalid immediate value"))?
                    as u32;
            }
            // li rt, IMMED[31:0]  ->  lui rt, IMMED[31:16]; ori rt, rt, IMMED[15:0]
            let rt = &instruction.operands[0];
            let expanded_line1 = format!("lui {}, {}", rt, (imm >> 16 as u32));
            let expanded_line2 = format!("ori {}, {}, {}", rt, rt, (imm as u32) & 0xFFFF);
            expanded_lines.push(expanded_line1);
            expanded_lines.push(expanded_line2);
        }
        "blt" => {
            // blt rs, rt, label  ->  slt $at, rs, rt  \n  bne $at, $zero, label
            let rs = &instruction.operands[0];
            let rt = &instruction.operands[1];
            let label = &instruction.operands[2];
            let expanded_line1 = format!("slt $at, {}, {}", rs, rt);
            let expanded_line2 = format!("bne $at, $zero, {}", label);
            expanded_lines.push(expanded_line1);
            expanded_lines.push(expanded_line2);
        }
        "bgt" => {
            // bgt rs, rt, label  ->  slt $at, rt, rs  \n  bne $at, $zero, label
            let rs = &instruction.operands[0];
            let rt = &instruction.operands[1];
            let label = &instruction.operands[2];
            let expanded_line1 = format!("slt $at, {}, {}", rt, rs);
            let expanded_line2 = format!("bne $at, $zero, {}", label);
            expanded_lines.push(expanded_line1);
            expanded_lines.push(expanded_line2);
        }
        "bge" => {
            // bge rs, rt, label  ->  slt $at, rs, rt  \n  beq $at, $zero, label
            let rs = &instruction.operands[0];
            let rt = &instruction.operands[1];
            let label = &instruction.operands[2];
            let expanded_line1 = format!("slt $at, {}, {}", rs, rt);
            let expanded_line2 = format!("beq $at, $zero, {}", label);
            expanded_lines.push(expanded_line1);
            expanded_lines.push(expanded_line2);
        }
        "ble" => {
            // ble rs, rt, label  ->  slt $at, rt, rs  \n  beq $at, $zero, label
            let rs = &instruction.operands[0];
            let rt = &instruction.operands[1];
            let label = &instruction.operands[2];
            let expanded_line1 = format!("slt $at, {}, {}", rt, rs);
            let expanded_line2 = format!("beq $at, $zero, {}", label);
            expanded_lines.push(expanded_line1);
            expanded_lines.push(expanded_line2);
        }
        "la" => {
            // la $at, LabelAddr  ->  lui $at, LabelAddr[31:16]; ori $at,$at, LabelAddr[15:0]
            let rt = &instruction.operands[0];
            let mut address = 0;
            if use_symbol_table {
                address = match symbol_table.get(&instruction.operands[1]) {
                    Some(addr) => *addr,
                    None => return Err(Error::new(ErrorKind::InvalidInput, "Invalid symbol")),
                };
            }
            let expanded_line1 = format!("lui {}, {}", rt, address >> 16);
            let expanded_line2 = format!("ori {}, {}, {}", rt, rt, address & 0xFFFF);
            expanded_lines.push(expanded_line1);
            expanded_lines.push(expanded_line2);
        }
        _ => {
            expanded_lines.push(line.to_string());
        }
    }
    Ok(expanded_lines)
}
