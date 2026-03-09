`default_nettype none
module fmul (
    input  wire logic        clk,
    input  wire logic        rst_n,
    input  wire logic [31:0] input_a,
    input  wire logic [31:0] input_b,
    input  wire logic        input_valid,
    output logic [31:0]      result,
    output logic             out_valid
);

    logic        s1_sign_a, s1_sign_b;
    logic [7:0]  s1_exp_a, s1_exp_b;
    logic [23:0] s1_mant_a, s1_mant_b; 
    
    logic        c1_sign_res;
    logic [9:0]  c1_exp_temp; 
    logic [47:0] c1_mant_prod; 
    logic        c1_is_zero_or_sub;

    always_comb begin
        s1_sign_a = input_a[31];
        s1_sign_b = input_b[31];
        s1_exp_a  = input_a[30:23];
        s1_exp_b  = input_b[30:23];
        
        s1_mant_a = (s1_exp_a == 0) ? {1'b0, input_a[22:0]} : {1'b1, input_a[22:0]};
        s1_mant_b = (s1_exp_b == 0) ? {1'b0, input_b[22:0]} : {1'b1, input_b[22:0]};
        
        c1_is_zero_or_sub = (s1_exp_a == 0) || (s1_exp_b == 0);
        c1_sign_res = s1_sign_a ^ s1_sign_b;

        c1_exp_temp = {2'b0, s1_exp_a} + {2'b0, s1_exp_b} - 10'd127;

        c1_mant_prod = s1_mant_a * s1_mant_b;
    end

    logic        s1_sign_reg;
    logic [9:0]  s1_exp_reg;
    logic [47:0] s1_prod_reg;
    logic        s1_valid_reg;
    logic        s1_zero_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s1_sign_reg  <= '0;
            s1_exp_reg   <= '0;
            s1_prod_reg  <= '0;
            s1_valid_reg <= '0;
            s1_zero_reg  <= '0;
        end else begin
            s1_sign_reg  <= c1_sign_res;
            s1_exp_reg   <= c1_exp_temp;
            s1_prod_reg  <= c1_mant_prod;
            s1_valid_reg <= input_valid;
            s1_zero_reg  <= c1_is_zero_or_sub;
        end
    end

    logic [9:0]  c2_exp_adjusted;
    logic        c2_sticky;
    logic [26:0] c2_mant_norm;

    always_comb begin
        if (s1_prod_reg[47]) begin
            c2_exp_adjusted = s1_exp_reg + 1;
            c2_mant_norm = s1_prod_reg[46:20]; 
            c2_sticky    = |s1_prod_reg[19:0];
        end else begin
            c2_exp_adjusted = s1_exp_reg;
            c2_mant_norm = s1_prod_reg[45:19];
            c2_sticky    = |s1_prod_reg[18:0];
        end
    end

    logic        s2_sign_reg;
    logic [9:0]  s2_exp_reg;
    logic [26:0] s2_mant_reg;
    logic        s2_sticky_reg;
    logic        s2_valid_reg;
    logic        s2_zero_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s2_sign_reg   <= '0;
            s2_exp_reg    <= '0;
            s2_mant_reg   <= '0;
            s2_sticky_reg <= '0;
            s2_valid_reg  <= '0;
            s2_zero_reg   <= '0;
        end else begin
            s2_sign_reg   <= s1_sign_reg;
            s2_exp_reg    <= c2_exp_adjusted;
            s2_mant_reg   <= c2_mant_norm;
            s2_sticky_reg <= c2_sticky;
            s2_valid_reg  <= s1_valid_reg;
            s2_zero_reg   <= s1_zero_reg;
        end
    end

    logic [31:0] c3_result_comb;

    always_comb begin
        logic        guard, round, sticky, lsb;
        logic        round_up;
        logic [22:0] frac_final;
        logic [9:0]  exp_checked; 
        
        guard  = s2_mant_reg[3];
        round  = s2_mant_reg[2];
        sticky = s2_sticky_reg | s2_mant_reg[1] | s2_mant_reg[0];
        lsb    = s2_mant_reg[4]; 

        round_up = guard & (round | sticky | lsb);

        if (round_up) begin
            frac_final = s2_mant_reg[26:4] + 1;
            if (frac_final == 0) begin 
                exp_checked = s2_exp_reg + 1;
            end else begin
                exp_checked = s2_exp_reg;
            end
        end else begin
            frac_final = s2_mant_reg[26:4];
            exp_checked = s2_exp_reg;
        end

        if (s2_zero_reg || exp_checked[9]) begin 
            c3_result_comb = {s2_sign_reg, 31'b0};
        end else if (exp_checked >= 255) begin 
            c3_result_comb = {s2_sign_reg, 8'hFF, 23'b0};
        end else begin
            c3_result_comb = {s2_sign_reg, exp_checked[7:0], frac_final};
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result    <= '0;
            out_valid <= '0;
        end else begin
            result    <= c3_result_comb;
            out_valid <= s2_valid_reg;
        end
    end

endmodule
`default_nettype wire