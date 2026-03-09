use std::env;
use std::process::Command;

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();
    let sv_dir = "sv";

    // SVファイルやラッパーC++が変更された時だけ再ビルドを走らせる設定
    println!("cargo:rerun-if-changed={}", sv_dir);
    println!("cargo:rerun-if-changed=cpp/wrapper.cpp");

    // (ファイル名, SystemVerilog内のトップモジュール名)
    let modules = [
        ("fadd.sv", "fadd"),
        ("fmul.sv", "fmul"),
        ("fdiv.sv", "fdiv"),
        ("fsqrt_3.sv", "fsqrt_3"),
        ("itof.sv", "itof"),
        ("ftoi.sv", "ftoi"),
    ];

    // 1. VerilatorでC++変換＆静的ライブラリ(.a)の自動ビルド
    for (filename, mod_name) in &modules {
        let sv_file = format!("{}/{}", sv_dir, filename);
        let status = Command::new("verilator")
            .arg("--cc")
            .arg(&sv_file)
            .arg("-Wno-LATCH")
            .arg("-Wno-WIDTHEXPAND")
            .arg("-Wno-WIDTH")
            .arg("-Wno-IMPLICITSTATIC")
            .arg("--build") // C++のコンパイルまで全部やってくれる
            .arg("--Mdir")
            .arg(&out_dir)
            .status()
            .expect("Verilatorの実行に失敗しました。インストールされていますか？");

        assert!(status.success(), "{} のビルドに失敗しました", filename);

        let original_a = format!("{}/V{}__ALL.a", out_dir, mod_name);
        let lib_a = format!("{}/libV{}__ALL.a", out_dir, mod_name);
        std::fs::copy(&original_a, &lib_a).expect("ライブラリのコピーに失敗しました");

        // Verilatorが生成した静的ライブラリ (例: Vfmul__ALL.a) をRustにリンク
        println!("cargo:rustc-link-search=native={}", out_dir);
        println!("cargo:rustc-link-lib=static=V{}__ALL", mod_name);
    }

    // Ubuntuの場合: "/usr/share/verilator/include"
    // macOS(Homebrew)の場合: "/opt/homebrew/share/verilator/include"
    let verilator_include = "/opt/homebrew/Cellar/verilator/5.042/share/verilator/include";

    // 2. ラッパーC++コードを cc クレートでコンパイル
    cc::Build::new()
        .cpp(true)
        .file("cpp/wrapper.cpp")
        .file(format!("{}/verilated.cpp", verilator_include))
        .file(format!("{}/verilated_threads.cpp", verilator_include))
        .include(&out_dir) // 生成された Vfmul.h などの場所
        .include(verilator_include) // verilated.h の場所
        .include(format!("{}/vltstd", verilator_include))
        .compile("fpu_wrapper"); // libfpu_wrapper.a として出力

    // 3. C++の標準ライブラリをリンク
    // Linuxなら "stdc++"、macOSなら "c++" に変更する必要がある
    println!("cargo:rustc-link-lib=c++");
}
