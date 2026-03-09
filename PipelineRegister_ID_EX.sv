// PipelineRegister_ID_EX.sv
module PipelineRegister_ID_EX (
    input  logic        clk,
    input  logic        rst,         // アクティブローリセット
    input  logic        i_stall,     // 1: パイプラインを停止 (EXステージを空転させる)
    input  logic        i_flush,     // 1: このレジスタの内容をクリア(nop)する

    // --- IDステージからの制御信号入力 ---
    input  logic [1:0]  i_RegDst,
    input  logic        i_ALUSrc,
    input  logic [1:0]  i_MemToReg,
    input  logic        i_RegWrite,
    input  logic        i_MemRead,
    input  logic        i_MemWrite,
    input  logic        i_BEQ,
    input  logic        i_BNE,
    input  logic        i_Jump,
    input  logic [2:0]  i_ALUOp,
    input  logic        i_BranchFP, // ★追加: 入力
    
    // --- IDステージからのデータ入力 ---
    input  logic [31:0] i_ReadData1,
    input  logic [31:0] i_ReadData2,
    input  logic [31:0] i_SignExtendedImm,
    input  logic [31:0] i_PC_Plus_4,
    input  logic [25:0] i_JumpIndex,

    input  logic [5:0]  i_Funct,         // (ALUControl用)
    input  logic [4:0]  i_ShiftAmount,   // (sll用)
    input  logic [4:0]  i_rs_addr,
    input  logic [4:0]  i_rt_addr,       // (WBとフォワーディング用)
    input  logic [4:0]  i_rd_addr,       // (WBとフォワーディング用)

    // --- EXステージへの制御信号出力 ---
    output logic [1:0]  o_RegDst,
    output logic        o_ALUSrc,
    output logic [1:0]  o_MemToReg,
    output logic        o_RegWrite,
    output logic        o_MemRead,
    output logic        o_MemWrite,
    output logic        o_BEQ,
    output logic        o_BNE,
    output logic        o_Jump,
    output logic [2:0]  o_ALUOp,
    output logic        o_BranchFP, // ★追加: 出力

    // --- EXステージへのデータ出力 ---
    output logic [31:0] o_ReadData1,
    output logic [31:0] o_ReadData2,
    output logic [31:0] o_SignExtendedImm,
    output logic [31:0] o_PC_Plus_4,
    output logic [25:0] o_JumpIndex,
    output logic [5:0]  o_Funct,
    output logic [4:0]  o_ShiftAmount,
    output logic [4:0]  o_rs_addr,
    output logic [4:0]  o_rt_addr,
    output logic [4:0]  o_rd_addr,

    input  logic [31:0] i_instruction,
    output logic [31:0] o_instruction
);

    always @(posedge clk or negedge rst) begin
        if (!rst || i_flush) begin
            // リセット時：すべての制御信号を0 (nop) にする
            {o_RegDst, o_ALUSrc, o_MemToReg, o_RegWrite, o_MemRead, o_MemWrite, 
             o_BEQ, o_BNE, o_Jump, o_ALUOp} <= '0;
            
            o_ReadData1 <= 32'b0;
            o_ReadData2 <= 32'b0;
            o_SignExtendedImm <= 32'b0;
            o_PC_Plus_4 <= 32'b0;
            o_JumpIndex <= 26'b0;
            o_Funct <= 6'b0;
            o_ShiftAmount <= 5'b0;
            o_rs_addr <= 5'b0;
            o_rt_addr <= 5'b0;
            o_rd_addr <= 5'b0;  
            o_instruction <= 32'b0;   
            o_BranchFP <= 1'b0;
             
        end else if (!i_stall) begin // ストールしていない時だけ更新
            // 通常動作：IDステージからの信号をEXステージに渡す
            o_RegDst   <= i_RegDst;
            o_ALUSrc   <= i_ALUSrc;
            o_MemToReg <= i_MemToReg;
            o_RegWrite <= i_RegWrite;
            o_MemRead  <= i_MemRead;
            o_MemWrite <= i_MemWrite;
            o_BEQ      <= i_BEQ;
            o_BNE      <= i_BNE;
            o_Jump     <= i_Jump;
            o_ALUOp    <= i_ALUOp;
            o_BranchFP <= i_BranchFP;
                
            o_ReadData1       <= i_ReadData1;
            o_ReadData2       <= i_ReadData2;
            o_SignExtendedImm <= i_SignExtendedImm;
            o_PC_Plus_4       <= i_PC_Plus_4;
            o_JumpIndex       <= i_JumpIndex;
            o_Funct           <= i_Funct;
            o_ShiftAmount     <= i_ShiftAmount;
            o_rs_addr         <= i_rs_addr;
            o_rt_addr         <= i_rt_addr;
            o_rd_addr         <= i_rd_addr;
            o_instruction     <= i_instruction;
        end
        // else (i_stallが1の時) は、何もしない（＝現在の値を保持する）
    end

endmodule