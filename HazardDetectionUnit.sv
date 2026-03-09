// HazardDetectionUnit.sv
// 目的: ロード・ユース・ハザード (lw の直後にその結果を使う命令) を検出する
module HazardDetectionUnit (
    // --- EXステージの情報 (ID/EXレジスタの出力) ---
    input  logic        i_MemRead_ex,    // EXステージの命令は 'lw' か？
    input  logic [4:0]  i_rt_addr_ex,    // 'lw' の書き込み先 (rt) は？

    // --- IDステージの情報 (現在の命令) ---
    input  logic [4:0]  i_rs_addr_id,    // IDステージの読み出し元1 (rs)
    input  logic [4:0]  i_rt_addr_id,    // IDステージの読み出し元2 (rt)

    // --- ストール制御信号の出力 ---
    output logic        o_stall_pc_ifid, // 1: PCとIF/IDレジスタを停止
    output logic        o_flush_idex     // 1: ID/EXレジスタにバブル(nop)を挿入
);
    
    // ハザード検出ロジック
    // 「もし、EXステージの命令が'lw'(MemRead)であり、
    //   かつ、その書き込み先(rt)が、IDステージの読み出し元(rsまたはrt)と
    //   一致するなら」
    wire hazard_detected = i_MemRead_ex &&
                           (i_rt_addr_ex != 5'b0) &&
                           ( (i_rt_addr_ex == i_rs_addr_id) || 
                             (i_rt_addr_ex == i_rt_addr_id) );
                             
    // 検出したら、ストール信号をアサート(1)する
    assign o_stall_pc_ifid = hazard_detected;
    assign o_flush_idex    = hazard_detected;

endmodule