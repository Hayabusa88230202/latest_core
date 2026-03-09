// ftoi.sv
`default_nettype none

module ftoi (
    input  wire logic        clk,
    input  wire logic        rst_n,
    input  wire logic [31:0] in_f,
    input  wire logic        input_valid,
    output      logic [31:0] out_i,
    output      logic        out_valid
);

    logic        s1_valid;
    logic        s1_sign;
    logic [31:0] s1_abs_int;
    logic        s1_ovf;

    logic [7:0]  exp;
    logic [22:0] frac;
    assign exp  = in_f[30:23];
    assign frac = in_f[22:0];

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            s1_valid   <= 1'b0;
            s1_sign    <= 1'b0;
            s1_abs_int <= 32'b0;
            s1_ovf     <= 1'b0;
        end else begin
            // ★修正: input_valid が 0 の時もちゃんと s1_valid を 0 に落とす
            s1_valid <= input_valid;
            
            if (input_valid) begin
                s1_sign  <= in_f[31];

                if (exp < 8'd127) begin
                    s1_abs_int <= 32'b0;
                    s1_ovf     <= 1'b0;
                end else if (exp >= 8'd158) begin
                    if (in_f[31] && exp == 8'd158 && frac == 23'd0) begin
                        s1_abs_int <= 32'h80000000;
                        s1_ovf     <= 1'b0;
                    end else begin
                        s1_abs_int <= 32'b0;
                        s1_ovf     <= 1'b1;
                    end
                end else if (exp >= 8'd150) begin
                    s1_abs_int <= {8'b0, 1'b1, frac} << (exp - 8'd150);
                    s1_ovf     <= 1'b0;
                end else begin
                    s1_abs_int <= {8'b0, 1'b1, frac} >> (8'd150 - exp);
                    s1_ovf     <= 1'b0;
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            out_i     <= 32'b0;
            out_valid <= 1'b0;
        end else begin
            out_valid <= s1_valid;
            if (s1_ovf) begin
                out_i <= s1_sign ? 32'h80000000 : 32'h7FFFFFFF; // overflow
            end else begin
                out_i <= s1_sign ? (~s1_abs_int + 1) : s1_abs_int; // sign
            end
        end
    end

endmodule
`default_nettype wire