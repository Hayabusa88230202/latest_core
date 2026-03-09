// PipelineRegister_EX_MEM.sv
module PipelineRegister_EX_MEM (
    input  logic        clk,
    input  logic        rst,         // アクティブローリセット
    input  logic        i_stall,  // (ハザード対策で後ほど追加)

    // --- EXステージからの制御信号入力 ---
    input  logic [1:0]  i_MemToReg,  // (WBステージ用)
    input  logic        i_RegWrite,  // (WBステージ用)
    input  logic        i_MemRead,
    input  logic        i_MemWrite,
    
    // --- EXステージからのデータ入力 ---
    input  logic [31:0] i_ALU_Result,    // メモリアドレス or WBデータ
    input  logic [31:0] i_ReadData2,     // sw命令で書き込むデータ
    input  logic [4:0]  i_Write_Addr,    // 書き込み先レジスタ (WBステージ用)
    input  logic [31:0] i_PC_Plus_4,

    // --- MEMステージへの制御信号出力 ---
    output logic [1:0]  o_MemToReg,
    output logic        o_RegWrite,
    output logic        o_MemRead,
    output logic        o_MemWrite,

    // --- MEMステージへのデータ出力 ---
    output logic [31:0] o_ALU_Result,
    output logic [31:0] o_ReadData2,
    output logic [4:0]  o_Write_Addr,
    output logic [31:0] o_PC_Plus_4
);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // リセット時：すべての制御信号を0 (nop) にする
            {o_MemToReg, o_RegWrite, o_MemRead, o_MemWrite} <= '0;
            o_ALU_Result <= 32'b0;
            o_ReadData2  <= 32'b0;
            o_Write_Addr <= 5'b0;
            o_PC_Plus_4  <= 32'b0;
        end else if (!i_stall) begin // (i_stall がなければ)
            // 通常動作：EXステージからの信号をMEMステージに渡す
            o_MemToReg  <= i_MemToReg;
            o_RegWrite  <= i_RegWrite;
            o_MemRead   <= i_MemRead;
            o_MemWrite  <= i_MemWrite;

            o_ALU_Result <= i_ALU_Result;
            o_ReadData2  <= i_ReadData2;
            o_Write_Addr <= i_Write_Addr;
            o_PC_Plus_4  <= i_PC_Plus_4;
        end
    end

endmodule