use std::io::Error;
use crate::Directive;

pub fn parse_data_line(line: &str) -> Result<Directive, Error>{
    // コメントを削除
    let line = line.split('#').next().unwrap_or("").trim();
    let line = line.split('@').next().unwrap_or("").trim();
    // 空白で分割
    let parts: Vec<&str> = line.split_whitespace().collect();
    let opecode = parts[0];
    if parts.len() > 1 {
        // println!("{}", parts[0]);
        // println!("{}", parts[1]);
        let operand: u32 = parts[1].parse::<i32>().expect("Invalid integer format") as u32;
        return Ok(Directive { opecode: opecode.to_string(), operand: operand });
    } else {
        // println!("{}", parts[0]);
        return Ok(Directive { opecode: opecode.to_string(), operand: 0 });
    }
}

