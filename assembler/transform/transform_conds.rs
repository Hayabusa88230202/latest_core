use std::io::{Error, ErrorKind};

pub fn transform_cond(opecode: &str) -> Result<u32, Error> {
    match opecode {
        "fbt" => Ok(0x01),
        "fbf" => Ok(0x00),
        _ => {
            eprintln!("Error: Invalid cond {}", opecode);
            return Err(Error::new(ErrorKind::InvalidInput, "Invalid cond"));
        }
    }
}