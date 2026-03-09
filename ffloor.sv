// ffloor.sv
`default_nettype none
module ffloor (
    input  wire logic        clk,
    input  wire logic        rst_n,
    input  wire logic [31:0] in_f,
    input  wire logic        input_valid,
    output logic [31:0]      out_f,
    output logic             out_valid
);
    logic sign;
    logic [7:0] exp;
    logic [22:0] frac;
    logic [31:0] out_comb;
    
    always_comb begin
        sign = in_f[31];
        exp  = in_f[30:23];
        frac = in_f[22:0];
        
        if (exp == 8'hFF || (exp == 8'h00 && frac == 23'd0)) begin
            // NaN, Inf, 0 の場合はそのまま出力
            out_comb = in_f;
        end else if (exp < 8'd127) begin
            // |x| < 1.0 の場合
            if (sign == 1'b0) out_comb = 32'h00000000; // 正なら 0.0
            else              out_comb = 32'hBF800000; // 負なら -1.0
        end else if (exp >= 8'd150) begin
            // 既に整数（小数部がない）場合はそのまま
            out_comb = in_f;
        end else begin
            // 小数部を切り捨てる処理
            logic [4:0] shift_amt = 5'd23 - (exp - 8'd127);
            logic [22:0] mask = (23'h7FFFFF << shift_amt);
            logic [22:0] frac_trunc = frac & mask;
            
            if (sign == 1'b1 && (frac & ~mask) != 0) begin
                // 負の数で、切り捨てられた端数がある場合は -1 する（絶対値を大きくする）
                logic [23:0] frac_added = {1'b1, frac_trunc} + (24'd1 << shift_amt);
                if (frac_added[23] == 0) out_comb = {sign, exp + 1'b1, frac_added[22:0]};
                else                     out_comb = {sign, exp, frac_added[22:0]};
            end else begin
                out_comb = {sign, exp, frac_trunc};
            end
        end
    end
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_f <= 0;
            out_valid <= 0;
        end else begin
            out_f <= out_comb;
            out_valid <= input_valid;
        end
    end
endmodule
`default_nettype wire