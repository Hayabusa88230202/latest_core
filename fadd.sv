`default_nettype none

module fadd (
    input  wire logic        clk,
    input  wire logic        rst_n,
    input  wire logic [31:0] input_a,
    input  wire logic [31:0] input_b,
    input  wire logic        input_valid,
    output logic [31:0]      result,
    output logic             out_valid   
);

    logic [31:0] c1_large, c1_small;
    logic [7:0]  c1_diff;
    logic [26:0] c1_mant_large, c1_mant_small;
    logic [26:0] c1_mant_small_shifted;
    logic        c1_sticky;
    logic        c1_effective_op;
    logic        c1_sign_res;
    logic [7:0]  c1_exp_res;

    always_comb begin
        if (input_a[30:0] < input_b[30:0]) begin 
            c1_large = input_b;
            c1_small = input_a;
        end else begin
            c1_large = input_a;
            c1_small = input_b;
        end
        
        c1_mant_large = (c1_large[30:23] == 0) ? {1'b0, c1_large[22:0], 3'b0} : {1'b1, c1_large[22:0], 3'b0};
        c1_mant_small = (c1_small[30:23] == 0) ? {1'b0, c1_small[22:0], 3'b0} : {1'b1, c1_small[22:0], 3'b0};
        c1_diff       = c1_large[30:23] - c1_small[30:23]; 

        begin
            logic [26:0] temp_shifted;
            if (c1_diff >= 8'd27) begin 
                temp_shifted = 27'b0;
                c1_sticky    = |c1_mant_small; 
            end else begin
                temp_shifted = c1_mant_small >> c1_diff;
                c1_sticky    = |(c1_mant_small & ~(~27'b0 << c1_diff));
            end
            c1_mant_small_shifted = {temp_shifted[26:1], temp_shifted[0] | c1_sticky};
        end

        c1_effective_op = c1_large[31] ^ c1_small[31];
        c1_sign_res     = c1_large[31];
        c1_exp_res      = c1_large[30:23];
    end

    logic [26:0] s1_mant_large_reg;
    logic [26:0] s1_mant_small_shifted_reg;
    logic        s1_effective_op_reg;
    logic        s1_sign_res_reg;
    logic [7:0]  s1_exp_res_reg;
    logic        s1_valid_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s1_mant_large_reg         <= '0;
            s1_mant_small_shifted_reg <= '0;
            s1_effective_op_reg       <= '0;
            s1_sign_res_reg           <= '0;
            s1_exp_res_reg            <= '0;
            s1_valid_reg              <= '0;
        end else begin
            s1_mant_large_reg         <= c1_mant_large;
            s1_mant_small_shifted_reg <= c1_mant_small_shifted;
            s1_effective_op_reg       <= c1_effective_op;
            s1_sign_res_reg           <= c1_sign_res;
            s1_exp_res_reg            <= c1_exp_res;
            s1_valid_reg              <= input_valid;
        end
    end

    logic [27:0] c2_mant_res;
    logic [4:0]  c2_zlc;
    logic [27:0] c2_mant_shifted_1;
    logic [7:0]  c2_exp_adjusted;
    logic [2:0]  c2_shift_remain;

    function automatic logic [4:0] count_leading_zeros(input logic [27:0] val);
        integer i;
        for (i = 26; i >= 0; i--) begin
            if (val[i]) return 5'(26 - i);
        end
        return 5'd27;
    endfunction

    always_comb begin
        if (s1_effective_op_reg) begin
            c2_mant_res = {1'b0, s1_mant_large_reg} - {1'b0, s1_mant_small_shifted_reg};
        end else begin
            c2_mant_res = {1'b0, s1_mant_large_reg} + {1'b0, s1_mant_small_shifted_reg};
        end

        c2_zlc = count_leading_zeros(c2_mant_res);

        if (c2_mant_res == 28'b0) begin
            c2_exp_adjusted   = 8'd0;
            c2_mant_shifted_1 = 28'd0;
            c2_shift_remain   = 3'd0;
        end else if (c2_mant_res[27]) begin
            c2_mant_shifted_1 = (c2_mant_res >> 1) | {27'b0, c2_mant_res[0]};
            c2_shift_remain   = 3'd0;
            c2_exp_adjusted   = s1_exp_res_reg + 8'd1;
        end else begin
            if (s1_exp_res_reg < {3'b0, c2_zlc}) begin
                c2_exp_adjusted = 8'd0;
            end else begin
                c2_exp_adjusted = s1_exp_res_reg - {3'b0, c2_zlc};
            end
            c2_mant_shifted_1 = c2_mant_res << c2_zlc[1:0];
            c2_shift_remain   = c2_zlc[4:2];
        end
    end

    logic [27:0] s2_mant_reg;
    logic [2:0]  s2_shift_remain_reg;
    logic [7:0]  s2_exp_reg;
    logic        s2_sign_reg;
    logic        s2_valid_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s2_mant_reg         <= '0;
            s2_shift_remain_reg <= '0;
            s2_exp_reg          <= '0;
            s2_sign_reg         <= '0;
            s2_valid_reg        <= '0;
        end else begin
            s2_mant_reg         <= c2_mant_shifted_1;
            s2_shift_remain_reg <= c2_shift_remain;
            s2_exp_reg          <= c2_exp_adjusted;
            s2_sign_reg         <= s1_sign_res_reg;
            s2_valid_reg        <= s1_valid_reg;
        end
    end

    logic [31:0] c3_result_comb;
    logic [27:0] mant_final_shifted;
    logic [22:0] frac_final;
    logic [7:0]  exp_final;
    logic        round_up;
    logic        guard, round, sticky, lsb;
    logic [23:0] frac_rounded;

    always_comb begin
        mant_final_shifted = s2_mant_reg << {s2_shift_remain_reg, 2'b00};

        guard  = mant_final_shifted[2];
        round  = mant_final_shifted[1];
        sticky = mant_final_shifted[0];
        lsb    = mant_final_shifted[3];

        // nearest round half to even
        round_up = guard & (round | sticky | lsb);

        if (s2_exp_reg == 8'd0) begin
            frac_final = 23'd0;
            exp_final  = 8'd0;
        end else begin
            if (round_up) begin
                frac_rounded = {1'b0, mant_final_shifted[25:3]} + 24'd1;
                
                if (frac_rounded[23]) begin
                    frac_final = 23'd0;
                    exp_final  = s2_exp_reg + 8'd1;
                end else begin
                    frac_final = frac_rounded[22:0];
                    exp_final  = s2_exp_reg;
                end
            end else begin
                frac_final = mant_final_shifted[25:3];
                exp_final  = s2_exp_reg;
            end
        end

        c3_result_comb = {s2_sign_reg, exp_final, frac_final};
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result    <= 32'b0; 
            out_valid <= 1'b0;
        end else begin
            result    <= c3_result_comb;
            out_valid <= s2_valid_reg; 
        end
    end

endmodule
`default_nettype wire