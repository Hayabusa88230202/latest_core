mod cache;
mod instructions;
mod memory;
mod processor;

mod fpu_hw;

use std::fs;
use std::fs::File;
use std::io::{self, BufRead, BufReader, BufWriter, Write};
use std::path::Path;

use instructions::{Instruction, InstructionType};
use memory::MemoryAddress;
use processor::{Processor, ProcessorError};

use env_logger;

/// シミュレータの設定
//　ここで定義してdefault()で呼び出せるようにすることで、設定の変更が容易になり、拡張性が上がる
#[derive(Debug, Clone)]
pub struct SimulatorConfig {
    /// メモリサイズ（バイト）
    pub memory_size: usize,
    /// テキスト領域の開始アドレス
    pub text_start: MemoryAddress,
    // 入力データの開始アドレス
    pub input_start: MemoryAddress,
    /// 出力データの開始アドレス
    pub output_start: MemoryAddress,
    /// ステップ実行モード
    pub step_mode: bool,
}

impl Default for SimulatorConfig {
    fn default() -> Self {
        Self {
            memory_size: 1024 * 1024 * 128, // 128MB
            text_start: 0x00040000,
            input_start: 0x07000000,
            output_start: 0x07FFFFEC,
            step_mode: false,
        }
    }
}

/// MIPSシミュレータ
#[derive(Debug)]
pub struct MipsSimulator {
    processor: Processor,
    config: SimulatorConfig,
}

impl MipsSimulator {
    /// 新しいシミュレータを作成
    pub fn new(config: SimulatorConfig) -> Self {
        let processor = Processor::with_memory_size(config.memory_size);
        Self { processor, config }
    }
    /// デフォルト設定でシミュレータを作成
    pub fn new_default() -> Self {
        Self::new(SimulatorConfig::default())
    }
    /// プログラムをファイルから読み込む
    pub fn load_program_from_file<P: AsRef<Path>>(
        &mut self,
        path: P,
    ) -> Result<(), SimulatorError> {
        let file = File::open(path)
            .map_err(|e| SimulatorError::FileError(format!("ファイルを開けません: {}", e)))?;
        let reader = BufReader::new(file);
        let mut texts = Vec::new();

        for (line_num, line) in reader.lines().enumerate() {
            let line = line.map_err(|e| {
                SimulatorError::FileError(format!(
                    "inputfileの {} 行目を読み込めませんでした: {}",
                    line_num + 1,
                    e
                ))
            })?;
            let line = line.trim();
            // 空行またはコメントをスキップ
            if line.is_empty() || line.starts_with('#') {
                continue;
            };
            // 16進数部分のみを抽出（コメントの前まで）
            // if letで条件が成立した場合のみcomment_posが宣言され、そのスコープはif文内のみである
            let hex_part = if let Some(comment_pos) = line.find('#') {
                line[..comment_pos].trim()
            } else {
                line
            };
            // まだ文字列なので16進数に変換
            let binary = u32::from_str_radix(hex_part, 2).map_err(|e| {
                SimulatorError::ParseError(format!(
                    "inputfileの {} 行目: 文字列から16進数への変換に失敗しました: '{}': {}",
                    line_num + 1,
                    hex_part,
                    e
                ))
            })?;
            texts.push(binary);
        }
        self.load_text(&texts)?;
        return Ok(());
    }
    pub fn load_input_from_file<P: AsRef<Path>>(&mut self, path: P) -> Result<(), SimulatorError> {
        let mut input_data = Vec::new();
        let content = fs::read_to_string(path).expect("Failed to read input");

        for token in content.split_whitespace() {
            if let Ok(i) = token.parse::<i32>() {
                input_data.push(i as u32);
            } else if let Ok(f) = token.parse::<f32>() {
                input_data.push(f.to_bits());
            }
        }
        self.load_input(&input_data)?;
        return Ok(());
    }
    /// テキスト領域をメモリにロード
    pub fn load_text(&mut self, text: &[Instruction]) -> Result<(), SimulatorError> {
        self.processor
            .load_program(text, self.config.text_start)
            .map_err(|e| SimulatorError::MemoryError(e))?;
        Ok(())
    }
    /// 入力ファイルをメモリにロード
    pub fn load_input(&mut self, input: &[u32]) -> Result<(), SimulatorError> {
        self.processor
            .load_program(input, self.config.input_start)
            .map_err(|e| SimulatorError::MemoryError(e))?;
        Ok(())
    }
    pub fn output_result(&mut self) -> Result<Vec<u32>, SimulatorError> {
        let op: u32 = self.processor.output_front;
        let mut output_data = Vec::new();
        let mut p = self.config.output_start;
        while p > op {
            output_data.push(
                self.processor
                    .read_memory(p)
                    .map_err(SimulatorError::MemoryError)?,
            );
            p = p - 4;
        }
        Ok(output_data)
    }
    /// シミュレータを実行
    pub fn run(&mut self) -> Result<(), SimulatorError> {
        if self.config.step_mode {
            self.run_step_mode()?
        } else {
            self.processor
                .run()
                .map_err(|e| SimulatorError::ProcessorError(e))?;
        }
        Ok(())
    }
    /// ステップ実行モードで実行
    fn run_step_mode(&mut self) -> Result<(), SimulatorError> {
        let mut step_count = 0;
        loop {
            println!("\n=== ステップ {} ===", step_count);
            println!("PC: 0x{:08X}", self.processor.get_pc());

            // 現在の命令を表示
            let instruction = self
                .processor
                .fetch_instruction()
                .map_err(|e| SimulatorError::MemoryError(e))?;
            let instruction_type = InstructionType::decode(instruction);
            println!("命令: 0x{:08X} ({})", instruction, instruction_type);

            // ユーザー入力を待つ
            print!("実行しますか？ (Enter: 実行, 'q': 終了, 's': 状態表示): ");
            io::stdout().flush().unwrap();

            let mut input = String::new();
            // 標準入力から一行読み込み、inputに格納。.unwrap() は、読み込み中にエラーが発生した場合にプログラムを停止させる
            io::stdin().read_line(&mut input).unwrap();
            let input = input.trim();

            match input {
                "q" => break,
                "s" => {
                    println!("{}", self.processor.dump_state());
                    continue;
                }
                _ => {
                    // 命令を実行
                    match self.processor.step() {
                        Ok(branch_taken) => {
                            if branch_taken {
                                println!("分岐発生!");
                            }
                            println!("{}", self.processor.dump_registers());
                            println!("{}", self.processor.dump_f_registers());
                        }
                        Err(e) => {
                            println!("エラー: {}", e);
                            println!("{}", self.processor.dump_registers());
                            println!("{}", self.processor.dump_f_registers());
                            break;
                        }
                    }
                }
            }
            step_count += 1;
        }
        Ok(())
    }

    /// プロセッサの状態を取得
    pub fn get_processor_state(&self) -> String {
        self.processor.dump_state()
    }

    /// 統計情報を取得
    pub fn get_stats(&self) -> &processor::ProcessorStats {
        self.processor.get_stats()
    }

    /// キャッシュ統計を取得
    pub fn get_cache_stats(&self) -> &cache::CacheStats {
        self.processor.get_cache_stats()
    }

    /// 設定を取得
    pub fn get_config(&self) -> &SimulatorConfig {
        &self.config
    }

    /// 設定を更新
    pub fn set_config(&mut self, config: SimulatorConfig) {
        self.config = config;
    }
}

/// シミュレータエラー
//std::fmt::Display	{}	最終ユーザー向け。エラーの「ユーザーフレンドリーな簡潔な説明」を提供します。
//std::fmt::Debug	{:?}	開発者向け。デバッグ用の「構造的な詳細情報」を提供します。
#[derive(Debug, Clone)]
pub enum SimulatorError {
    FileError(String),
    ParseError(String),
    MemoryError(memory::MemoryError),
    ProcessorError(ProcessorError),
}

impl std::fmt::Display for SimulatorError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            SimulatorError::FileError(msg) => write!(f, "ファイルエラー: {}", msg),
            SimulatorError::ParseError(msg) => write!(f, "解析エラー: {}", msg),
            SimulatorError::MemoryError(e) => write!(f, "メモリエラー: {}", e),
            SimulatorError::ProcessorError(e) => write!(f, "プロセッサエラー: {}", e),
        }
    }
}

//Display トレイト（エラーをユーザーフレンドリーに表示する）の実装が既にあるため、std::error::Error トレイトの実装は形式的なものになっている
impl std::error::Error for SimulatorError {}

/// コマンドライン引数を解析
fn parse_args(
    args: &[String],
) -> Result<(SimulatorConfig, Option<String>, Option<String>), String> {
    let mut config = SimulatorConfig::default();
    let mut i = 1; // オプションなどの指定はargs[1]以降に入る
    let mut program_file = None;
    let mut input_file = None;

    while i < args.len() {
        match args[i].as_str() {
            "--memory-size" | "-m" => {
                if i + 1 >= args.len() {
                    return Err("--memory-size には値が必要です".to_string());
                }
                config.memory_size = args[i + 1]
                    .parse()
                    .map_err(|_| "無効なメモリサイズです".to_string())?;
                i += 2;
            }
            "--step" | "-s" => {
                config.step_mode = true;
                i += 1;
            }
            "--help" | "-h" => {
                print_usage();
                std::process::exit(0);
            }
            arg => {
                // オプションでない場合はプログラムファイルとして扱う
                if arg.starts_with('-') {
                    return Err(format!("このオプションは定義されていません: {}", arg));
                }
                if program_file.is_none() {
                    program_file = Some(arg.to_string());
                } else if input_file.is_none() {
                    input_file = Some(arg.to_string());
                } else {
                    return Err(format!("引数が多すぎます: {}", arg));
                }
                i += 1;
            }
        }
    }
    Ok((config, program_file, input_file))
}

/// 使用方法を表示
fn print_usage() {
    println!("MIPSプロセッサシミュレータ");
    println!();
    println!(
        "使用方法: {} [オプション] <プログラムファイル> <入力ファイル>",
        std::env::args()
            .next()
            .unwrap_or("mips_simulator".to_string())
    );
    println!();
    println!("オプション:");
    println!("  -m, --memory-size <サイズ>  メモリサイズを指定（バイト単位）");
    println!("  -s, --step                  ステップ実行モードで実行");
    println!("  -h, --help                  このヘルプを表示");
    println!();
    println!("例:");
    println!(
        "  {} fibonacci.hex",
        std::env::args()
            .next()
            .unwrap_or("mips_simulator".to_string())
    );
    println!(
        "  {} -d -s cat.hex contest.sld",
        std::env::args()
            .next()
            .unwrap_or("mips_simulator".to_string())
    );
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    env_logger::init();

    let args: Vec<String> = std::env::args().collect();

    let (config, program_file, input_file) = match parse_args(&args) {
        Ok((config, program_file, input_file)) => (config, program_file, input_file),
        Err(e) => {
            eprintln!("エラー: コマンドライン引数の解析に失敗しました: {}", e);
            print_usage();
            std::process::exit(1);
        }
    };

    let program_file = match program_file {
        Some(file) => file,
        None => {
            eprintln!("エラー: プログラムファイルがコマンドライン引数で指定されていません");
            print_usage();
            std::process::exit(1);
        }
    };

    let mut simulator = MipsSimulator::new(config);

    fpu_hw::init();

    // プログラムを読み込み
    match simulator.load_program_from_file(&program_file) {
        Ok(()) => {
            println!("プログラム '{}' を読み込みました", program_file);
        }
        Err(e) => {
            eprintln!("エラー: プログラムの読み込みに失敗しました: {}", e);
            std::process::exit(1);
        }
    }

    let _ = match input_file {
        Some(file) => {
            // 入力ファイルを読み込み
            match simulator.load_input_from_file(&file) {
                Ok(()) => {
                    println!("入力ファイル '{}' を読み込みました", file);
                }
                Err(e) => {
                    eprintln!("エラー: 入力ファイルの読み込みに失敗しました: {}", e);
                    std::process::exit(1);
                }
            }
        }
        None => {
            println!("入力ファイルなし");
        }
    };

    // シミュレータを実行
    match simulator.run() {
        Ok(()) => {
            println!("{}", simulator.get_processor_state());
            println!("=== 計算結果 ===\n");
            println!("{}\n", simulator.processor.get_register(8)); // 結果表示
        }
        Err(e) => {
            eprintln!("エラー: シミュレーション中にエラーが発生しました: {}", e);
            std::process::exit(1);
        }
    }

    let _ = simulator
        .processor
        .cache
        .flush(&mut simulator.processor.memory)
        .map_err(|e| {
            println!("キャッシュのライトバックに失敗, エラー={}", e);
            SimulatorError::MemoryError(e);
        });

    let results = simulator.output_result()?;
    // println!("{}", results.len());
    if results.is_empty() {
        return Ok(());
    }
    let file_path = "output.ppm";
    let file = File::create(file_path)?;
    let mut writer = BufWriter::new(file);
    for val in results {
        match val {
            48..=57 => {
                let c = val as u8 as char;
                write!(writer, "{}", c)?;
            }
            80 => write!(writer, "P")?,
            32 => write!(writer, " ")?,
            10 => writeln!(writer)?,
            _ => continue,
        }
    }
    println!("{} に保存しました", file_path);
    Ok(())
}
