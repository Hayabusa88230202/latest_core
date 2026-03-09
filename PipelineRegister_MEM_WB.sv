// PipelineRegister_MEM_WB.sv
module PipelineRegister_MEM_WB (
    input  logic        clk,
    input  logic        rst,
    input  logic        i_stall,

    // --- MEMステージからの制御信号入力 ---
    input  logic [1:0]  i_MemToReg,
    input  logic        i_RegWrite,
    
    // --- MEMステージからのデータ入力 ---
    input  logic [31:0] i_ALU_Result,
    input  logic [31:0] i_Mem_ReadData,
    input  logic [4:0]  i_Write_Addr,
    input  logic [31:0] i_PC_Plus_4,  // ★jal のために追加

    // --- WBステージへの制御信号出力 ---
    output logic [1:0]  o_MemToReg,
    output logic        o_RegWrite,

    // --- WBステージへのデータ出力 ---
    output logic [31:0] o_ALU_Result,
    output logic [31:0] o_Mem_ReadData,
    output logic [4:0]  o_Write_Addr,
    output logic [31:0] o_PC_Plus_4   // ★jal のために追加
);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            {o_MemToReg, o_RegWrite} <= '0;
            o_ALU_Result   <= 32'b0;
            o_Mem_ReadData <= 32'b0;
            o_Write_Addr   <= 5'b0;
            o_PC_Plus_4    <= 32'b0; // ★リセット処理を追加
        end else if (!i_stall) begin
            // 通常動作：MEMステージからの信号をWBステージに渡す
            o_MemToReg   <= i_MemToReg;
            o_RegWrite   <= i_RegWrite;
            
            o_ALU_Result   <= i_ALU_Result;
            o_Mem_ReadData <= i_Mem_ReadData;
            o_Write_Addr   <= i_Write_Addr;
            o_PC_Plus_4    <= i_PC_Plus_4; // ★データを渡す
        end
    end

endmodule