use std::collections::HashMap;
use std::fs::File;
use std::io::{BufRead, BufReader, BufWriter, Error, ErrorKind, Write};
mod expand_instruction;
mod parse_data_line;
mod parse_mips_line;
mod symbol_table;
mod transform;

pub const PROGRAM_START: u32 = 0x00040000;

const INPUT_FILE: &str = "input32.s";
const OUTPUT_FILE: &str = "output32.hex";

pub struct Instruction {
    opecode: String,
    operands: Vec<String>,
}

pub struct Directive {
    opecode: String,
    operand: u32,
}

#[derive(PartialEq)]
enum Mode {
    Data,
    Text,
}

fn main() -> Result<(), Error> {
    let mut symbol_table = HashMap::new();
    let mut inst_address = PROGRAM_START;
    let mut instructions: Vec<Instruction> = Vec::new();
    let mut data_address;
    let mut directives: Vec<Directive> = Vec::new();
    let mut mode: Mode = Mode::Data;

    // data領域をしまうメモリ上のスタートアドレス計算
    let input1 = File::open(INPUT_FILE)?;
    let buffered1 = BufReader::new(input1);
    for line in buffered1.lines() {
        let row_line = line.map_err(|e| Error::new(ErrorKind::Other, e))?;
        if row_line.trim() == ".data" {
            mode = Mode::Data;
            continue;
        } else if row_line.trim() == ".text" {
            mode = Mode::Text;
            continue;
        }
        if mode == Mode::Text {
            let expanded_lines =
                expand_instruction::expand_instruction(&row_line, &symbol_table, false)?;
            for expanded_line in &expanded_lines {
                let is_symbol: bool = symbol_table::make_symbol_table(
                    &mut symbol_table,
                    &expanded_line,
                    inst_address,
                    false,
                )?;
                if is_symbol {
                    continue;
                }
                let parsed_inst: Instruction = parse_mips_line::parse_mips_line(&expanded_line)?;
                // println!("{}", parsed_inst.opecode);
                if parsed_inst.opecode == "" {
                    continue;
                } else if parsed_inst.opecode == ".globl" {
                    // start_label = parsed_inst.operands[0].clone();
                    continue;
                } else if parsed_inst.opecode == ".align" {
                    while inst_address % 2_u32.pow(parsed_inst.operands[0].parse::<u32>().unwrap())
                        != 0
                    {
                        inst_address += 1;
                    }
                    continue;
                }
                inst_address += 4;
                // println!("inst_address: {}: {}", inst_address, expanded_line);
            }
        }
    }

    // 先ほど計算したdata領域のメモリ上でのスタートアドレスを用いて、data領域のシンボルテーブルを作成する
    data_address = inst_address;
    let input2 = File::open(INPUT_FILE)?;
    let buffered2 = BufReader::new(input2);
    for line in buffered2.lines() {
        let row_line = line.map_err(|e| Error::new(ErrorKind::Other, e))?;
        if row_line.trim() == ".data" {
            mode = Mode::Data;
            continue;
        } else if row_line.trim() == ".text" {
            mode = Mode::Text;
            continue;
        }
        if mode == Mode::Data {
            let is_symbol: bool =
                symbol_table::make_symbol_table(&mut symbol_table, &row_line, data_address, true)?;
            if is_symbol {
                continue;
            }
            let parsed_directive: Directive = parse_data_line::parse_data_line(&row_line)?;
            if parsed_directive.opecode == "" {
                continue;
            } else if parsed_directive.opecode == ".literal8" {
                continue;
            } else if parsed_directive.opecode == ".align" {
                while data_address % 2_u32.pow(parsed_directive.operand as u32) != 0 {
                    data_address += 1;
                }
                continue;
            }
            directives.push(parsed_directive);
            data_address += 4;
            // println!("data_number{}: {}", data_number, row_line);
        }
        if mode == Mode::Text {
            break;
        }
    }

    // text領域のシンボルテーブル構築
    inst_address = PROGRAM_START;
    // inst_address = PROGRAM_START + 4;
    let input3 = File::open(INPUT_FILE)?;
    let buffered3 = BufReader::new(input3);
    for line in buffered3.lines() {
        let row_line = line.map_err(|e| Error::new(ErrorKind::Other, e))?;
        if row_line.trim() == ".data" {
            mode = Mode::Data;
            continue;
        } else if row_line.trim() == ".text" {
            mode = Mode::Text;
            continue;
        }
        if mode == Mode::Text {
            let expanded_lines =
                expand_instruction::expand_instruction(&row_line, &symbol_table, true)?;
            for expanded_line in &expanded_lines {
                let is_symbol: bool = symbol_table::make_symbol_table(
                    &mut symbol_table,
                    &expanded_line,
                    inst_address,
                    true,
                )?;
                if is_symbol {
                    continue;
                }
                let parsed_inst: Instruction = parse_mips_line::parse_mips_line(&expanded_line)?;
                // println!("{}", parsed_inst.opecode);
                if parsed_inst.opecode == "" {
                    continue;
                } else if parsed_inst.opecode == ".globl" {
                    // start_label = parsed_inst.operands[0].clone();
                    continue;
                } else if parsed_inst.opecode == ".align" {
                    while inst_address % 2_u32.pow(parsed_inst.operands[0].parse::<u32>().unwrap())
                        != 0
                    {
                        inst_address += 1;
                    }
                    continue;
                }
                instructions.push(parsed_inst);
                inst_address += 4;
                // println!("inst_address: {}: {}", inst_address, expanded_line);
            }
        }
    }

    let file = File::create(OUTPUT_FILE)?;
    let mut writer = BufWriter::new(file);

    for (inst_number, instruction) in instructions.iter().enumerate() {
        let decoded_instruction: String = format!(
            "{:032b}",
            transform::transform_instructions::transform_instruction(
                &instruction,
                &symbol_table,
                inst_number as u32
            )?
        );
        // println!("decoded_instruction: {:?}", decoded_instruction);
        writer.write_all(decoded_instruction.as_bytes())?;
        writer.write_all(b"\n")?;
    }

    for directive in directives {
        let s: String = format!("{:032b}\n", directive.operand);
        writer.write_all(s.as_bytes())?;
    }
    writer.flush()?;
    Ok(())
}
