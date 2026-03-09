use std::io::{Error, ErrorKind};

pub fn transform_fmt(opecode: &str) -> Result<u32, Error> {
    match opecode {
        "fadd"
        | "fsub"
        | "fmul"
        | "fdiv"
        | "feq"
        | "flt"
        | "fle"
        | "fmove"
        | "fneg"
        | "fsqrt"
        | "fabs"
        | "floor"
        | "ftoi" => Ok(0x10),
        "fbt"
        | "fbf" => Ok(0x08),
        "itof" => Ok(0x14),
        _ => {
            eprintln!("Error: Invalid fmt {}", opecode);
            return Err(Error::new(ErrorKind::InvalidInput, "Invalid fmt"));
        }
    }
}