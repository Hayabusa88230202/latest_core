# MIPSプロセッサシミュレータ

Rustで実装されたMIPS形式の機械語で書かれたプログラムを実行するプロセッサシミュレータです。

# ステップ実行モードで実行

```bash
RUST_LOG=debug cargo run --release -q -- --step ../assembler/output32.hex ./contest.sld
```

# 実行
```bash
cargo run --release -q -- ../assembler/output32.hex ./contest.sld
```
../assembler/output32.hexのファイル名は適宜変更する

## 実装命令

以下のスプレッドシートを参照
[7班ISA](https://docs.google.com/spreadsheets/d/1Fh1RrgWITBiWIzRu-9uR-0sdNd5owhdfcugUg5QE2_4/edit?gid=0#gid=0)