use std::io::{Error, ErrorKind};

pub fn transform_opecode(opecode: &str) -> Result<u32, Error> {
    match opecode {
        "add" | "sub" | "and" | "or" | "xor" | "nor" | "slt" | "sll" | "srl" | "sra" | "jr"
        | "jalr" | "syscall" => Ok(0x00),
        // | "mfhi"
        // | "mflo"
        // | "mult"
        // | "div"
        "j" => Ok(0x02),
        "jal" => Ok(0x03),
        "beq" => Ok(0x04),
        "bne" => Ok(0x05),
        "addi" => Ok(0x08),
        "subi" => Ok(0x09),
        "slti" => Ok(0x0A),
        "sgti" => Ok(0x0B),
        "andi" => Ok(0x0C),
        "ori" => Ok(0x0D),
        "lui" => Ok(0x0F),
        "fadd" | "fsub" | "fmul" | "fdiv" | "feq" | "flt" | "fle" | "fbt" | "fbf" | "fmove"
        | "fneg" | "fsqrt" | "fabs" | "floor" | "itof" | "ftoi" => Ok(0x11),
        "lw" => Ok(0x23),
        "sw" => Ok(0x2B),
        "flw" => Ok(0x31),
        "fsw" => Ok(0x39),
        _ => Err(Error::new(
            ErrorKind::InvalidInput,
            "Invalid opecode in transform_opecodes",
        )),
    }
}
