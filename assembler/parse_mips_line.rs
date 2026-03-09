use std::io::{Error, ErrorKind};
use crate::Instruction;

pub fn parse_mips_line(line: &str) -> Result<Instruction, Error>{
    // ラベルの場合はラベル用のinstructionをreturnする
    if let Some((_left, _)) = line.split_once(':') {
        return Ok(Instruction { opecode: "label".to_string(), operands: vec![] });
    };

    // コメントを削除
    let line = line.split('#').next().unwrap_or("").trim();
    let line = line.split('@').next().unwrap_or("").trim();

    // 空白とカンマとカッコで分割
    let parts: Vec<&str> = line.split(|c: char| c.is_whitespace() || c == ' ' || c == ',' || c == '(' || c == ')' || c == '\t').filter(|s| !s.is_empty()).collect();

    // コメントのみの場合は空のInstructionをreturnする
    if parts.len() == 0 {
        return Ok(Instruction { opecode: "".to_string(), operands: vec![] });
    };

    if parts.len() < 2 && parts[0] != "syscall" {
        return Err(Error::new(ErrorKind::InvalidInput, "Invalid MIPS line"));
    }

    // fsw $f2, $t8のような省略形に対応させる
    if parts.len() == 3 && (parts[0] == "sw" ||parts[0] == "lw" ||parts[0] == "fsw" || parts[0] == "flw") {
        // もし addr_reg がすでに "0($t8)" 形式でなければ 0() をつける
        if !line.contains('(') {
            return Ok(Instruction { opecode: parts[0].to_string(), operands: vec![ parts[1].to_string(), "0".to_string(), parts[2].to_string()]});
        }
    }
    let opecode = parts[0];
    let operands: Vec<String> = parts[1..].iter().map(|&s| s.to_string()).collect();
    Ok(Instruction { opecode: opecode.to_string(), operands: operands })
}