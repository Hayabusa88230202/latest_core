// ProgramCounter.sv
module ProgramCounter (
    input logic clk,
    input logic rst,
    input logic i_stall, // PCの更新を停止 
    input logic[31:0] PC_in, // 次にセットすべきPCの値
    output logic[31:0] PC_out // 現在のPCの値
);

    // 標準的なMIPSのText Segment開始アドレス
    localparam INIT_PC = 32'h00000000;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            PC_out <= INIT_PC; 
        end else if (!i_stall) begin
            PC_out <= PC_in;
        end
    end
endmodule