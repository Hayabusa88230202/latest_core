// PipelineRegister_IF_ID.sv
module PipelineRegister_IF_ID (
    input  logic        clk,
    input  logic        rst,         // アクティブローリセット
    input  logic        i_stall,     // 1: パイプラインを停止 (PCとIF/IDの更新を止める)
    input  logic        i_flush,     // 1: このレジスタの内容をクリア(nop)する (分岐ハザード用)

    // IFステージからの入力
    input  logic [31:0] i_instruction,
    input  logic [31:0] i_pc_plus_4,

    // IDステージへの出力
    output logic [31:0] o_instruction,
    output logic [31:0] o_pc_plus_4
);

    always @(posedge clk or negedge rst) begin
        if (!rst || i_flush) begin
            // リセット時、または分岐ハザードでフラッシュする時
            o_instruction <= 32'h00000000; 
            o_pc_plus_4   <= 32'h00000000;
        end else if (!i_stall) begin
            // パイプラインがストールしていない時だけ、次の値に進める
            o_instruction <= i_instruction;
            o_pc_plus_4   <= i_pc_plus_4;
        end
        // ストール時 (else) は、現在の値を保持し続ける
    end

endmodule