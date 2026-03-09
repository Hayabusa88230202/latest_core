// ALU.sv
module ALU (
    input  logic [31:0] A,          // 入力1
    input  logic [31:0] B,          // 入力2
    input  logic [4:0]  ShiftAmount, // シフト量
    input  logic [3:0]  ALUControl, // 4ビットの制御信号
    output logic [31:0] Result,     // 演算結果
    output logic        Zero        // 演算結果が0なら1になるフラグ
);
    always_comb begin 
        case (ALUControl)
            4'b0000: Result = A & B; // and
            4'b0001: Result = A | B; // or
            4'b0010: Result = ~(A | B); // nor
            4'b0011: Result = A ^ B; // xor
            4'b0100: Result = A + B; // add
            4'b0101: Result = A - B; // sub
            4'b0110: Result = (signed'(A) < signed'(B)) ? 32'd1 : 32'd0;
            4'b0111: Result = B << ShiftAmount; // sll
            4'b1000: Result = (signed'(A) > signed'(B)) ? 32'd1 : 32'd0; // sgt (Set Greater Than) : A > B なら 1
            // 即値の下位16bitを上位に持っていき、下位を0埋め
            4'b1001: Result = {B[15:0], 16'b0};
            4'b1101: Result = $signed(B) >>> ShiftAmount;
            default: Result = 32'b0;
        endcase
    end

    assign Zero = (Result == 32'b0) ? 1'b1 : 1'b0;
endmodule