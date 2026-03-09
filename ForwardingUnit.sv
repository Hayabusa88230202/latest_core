`default_nettype wire

// ForwardingUnit.sv
module ForwardingUnit (
    input  logic [4:0]  i_rs_addr_ex,
    input  logic [4:0]  i_rt_addr_ex,
    input  logic        i_RegWrite_mem,
    input  logic [4:0]  i_Write_Addr_mem,
    input  logic        i_RegWrite_wb,
    input  logic [4:0]  i_Write_Addr_wb,
    output logic [1:0]  o_ForwardA,
    output logic [1:0]  o_ForwardB
);

    // --- ForwardA (ALUの入力A / rs) のロジック ---
    always_comb begin
        // 1. MEMステージからのフォワードを最優先
        if (i_RegWrite_mem && (i_Write_Addr_mem != 5'b0) && 
            (i_Write_Addr_mem == i_rs_addr_ex)) 
        begin
            o_ForwardA = 2'b01; // MEMステージの結果をフォワード
        
        // 2. 次にWBステージからのフォワードをチェック
        end else if (i_RegWrite_wb && (i_Write_Addr_wb != 5'b0) && 
                     (i_Write_Addr_wb == i_rs_addr_ex)) 
        begin
            o_ForwardA = 2'b10; // WBステージの結果をフォワード
        
        // 3. ハザードなし
        end else begin
            o_ForwardA = 2'b00; // フォワードなし
        end
    end

    // --- ForwardB (ALUの入力B / rt) のロジック ---
    // ★修正★: o_ForwardA とは「別の」always_comb ブロックで定義する
    always_comb begin
        // 1. MEMステージからのフォワードを最優先
        if (i_RegWrite_mem && (i_Write_Addr_mem != 5'b0) && 
            (i_Write_Addr_mem == i_rt_addr_ex)) 
        begin
            o_ForwardB = 2'b01;
        
        // 2. 次にWBステージからのフォワードをチェック
        end else if (i_RegWrite_wb && (i_Write_Addr_wb != 5'b0) && 
                     (i_Write_Addr_wb == i_rt_addr_ex)) 
        begin
            o_ForwardB = 2'b10;
        
        // 3. ハザードなし
        end else begin
            o_ForwardB = 2'b00;
        end
    end

endmodule