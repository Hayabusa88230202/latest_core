use std::collections::HashMap;
use std::io::Error;

// ラベルのアドレスをテーブルに格納する
pub fn make_symbol_table(
    symbol_table: &mut HashMap<String, u32>,
    line: &str,
    address: u32,
    insert_mode: bool,
) -> Result<bool, Error> {
    match line.split_once(':') {
        Some((left, _)) => {
            if insert_mode {
                symbol_table.insert(String::from(left.trim()), address);
            }
            return Ok(true);
        }
        None => return Ok(false),
    };
}
