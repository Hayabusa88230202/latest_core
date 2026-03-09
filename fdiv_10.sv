`default_nettype none

module fdiv (
    input  wire logic        clk,
    input  wire logic        rst_n,
    input  wire logic [31:0] input_a,
    input  wire logic [31:0] input_b,
    input  wire logic        input_valid,
    output logic [31:0]      result,
    output logic             out_valid   
);

    // =========================================================
    // 1. シミュレータ規定の厳密な例外ビットパターン
    // =========================================================
    localparam [31:0] FP_INF      = 32'b0_11111111_00000000000000000000000;
    localparam [31:0] FP_NAN      = 32'b0_11111111_10000000000000000000000;
    localparam [31:0] FP_ZERO     = 32'b0_00000000_00000000000000000000000;
    localparam [31:0] FP_NON_NORM = 32'b0_00000000_11111111111110000000000;

    // =========================================================
    // 2. 入力の展開と FTZ (Flush To Zero) 判定
    // =========================================================
    wire s_a = input_a[31];
    wire [7:0] e_a = input_a[30:23];
    wire [23:0] m_a = (|e_a) ? {1'b1, input_a[22:0]} : {1'b0, input_a[22:0]};

    wire s_b = input_b[31];
    wire [7:0] e_b = input_b[30:23];
    wire [23:0] m_b = (|e_b) ? {1'b1, input_b[22:0]} : {1'b0, input_b[22:0]};

    wire [7:0] calc_e_a = (|e_a) ? e_a : 8'd1;
    wire [7:0] calc_e_b = (|e_b) ? e_b : 8'd1;

    // ★例外条件の判定 (入力の非正規化数 e==0 は 0 として扱う)
    wire a_is_zero = (e_a == 8'b0); 
    wire b_is_zero = (e_b == 8'b0); 
    wire a_is_nan = (&e_a) && (input_a[22:0] != 0);
    wire b_is_nan = (&e_b) && (input_b[22:0] != 0);
    wire a_is_inf = (&e_a) && (input_a[22:0] == 0);
    wire b_is_inf = (&e_b) && (input_b[22:0] == 0);

    // ★出力されるべき真の例外状態
    wire is_nan  = a_is_nan || b_is_nan || (a_is_zero && b_is_zero) || (a_is_inf && b_is_inf);
    wire is_inf  = a_is_inf || b_is_zero;
    wire is_zero = a_is_zero || b_is_inf;

    // =========================================================
    // 3. テイラー展開用 LUT (Look Up Table)
    // =========================================================
    (* ram_style = "block" *) reg [47:0] lut [0:4095]; 
    initial begin
        $readmemh("taylor_lut.mem", lut);
    end

    // =========================================================
    // 4. STAGE 1: 指数計算とLUT読み出し
    // =========================================================
    reg st1_valid, st1_sign, st1_nan, st1_true_inf, st1_true_zero;
    reg [24:0] st1_adjusted_a;
    reg [10:0] st1_m_b_10_0;
    reg [47:0] st1_y0_dy;
    reg [48:0] st1_bias;

    reg [7:0] st1_exp_C, st1_exp_N, st1_exp_S;
    reg st1_ovf_C, st1_ovf_N, st1_ovf_S;
    reg st1_udf_C, st1_udf_N, st1_udf_S;

    wire shift_pred = (m_a >= m_b);
    wire [24:0] adjusted_a = shift_pred ? {1'b0, m_a} : {m_a, 1'b0};

    wire signed [10:0] raw_exp = {3'b0, calc_e_a} - {3'b0, calc_e_b} + 11'sd127;
    wire signed [10:0] base_exp = shift_pred ? raw_exp : raw_exp - 11'sd1;
    
    wire signed [10:0] exp_C = base_exp + 11'sd1; 
    wire signed [10:0] exp_N = base_exp;          
    wire signed [10:0] exp_S = base_exp - 11'sd1; 

    // ★オーバーフローとアンダーフローの分離判定
    wire ovf_C = (exp_C >= 11'sd255); wire udf_C = (exp_C <= 11'sd0);
    wire ovf_N = (exp_N >= 11'sd255); wire udf_N = (exp_N <= 11'sd0);
    wire ovf_S = (exp_S >= 11'sd255); wire udf_S = (exp_S <= 11'sd0);

    always @(posedge clk) begin
        st1_y0_dy <= lut[m_b[22:11]]; 
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            st1_valid <= 1'b0; st1_sign <= 1'b0; 
            st1_nan <= 1'b0; st1_true_inf <= 1'b0; st1_true_zero <= 1'b0;
            st1_adjusted_a <= 25'b0; st1_m_b_10_0 <= 11'b0;
            st1_bias <= 49'b0;
            
            st1_exp_C <= 8'b0; st1_exp_N <= 8'b0; st1_exp_S <= 8'b0;
            st1_ovf_C <= 1'b0; st1_ovf_N <= 1'b0; st1_ovf_S <= 1'b0;
            st1_udf_C <= 1'b0; st1_udf_N <= 1'b0; st1_udf_S <= 1'b0;
        end else begin
            st1_valid <= input_valid;
            st1_sign <= s_a ^ s_b;
            
            // 例外フラグの伝搬
            st1_nan       <= is_nan;
            st1_true_inf  <= is_inf && !is_nan;
            st1_true_zero <= is_zero && !is_nan;

            st1_adjusted_a <= adjusted_a;
            st1_m_b_10_0 <= m_b[10:0];
            st1_bias <= (m_b[22:0] == 23'b0) ? 49'h0 : 49'h0_0000_017F_FFFF;

            st1_exp_C <= exp_C[7:0];
            st1_exp_N <= exp_N[7:0];
            st1_exp_S <= exp_S[7:0];

            st1_ovf_C <= ovf_C; st1_ovf_N <= ovf_N; st1_ovf_S <= ovf_S;
            st1_udf_C <= udf_C; st1_udf_N <= udf_N; st1_udf_S <= udf_S;
        end
    end

    // =========================================================
    // 5. STAGE 2: 乗算とテイラー展開の補正
    // =========================================================
    reg st2_valid, st2_sign, st2_nan, st2_true_inf, st2_true_zero;
    reg [24:0] st2_adjusted_a;
    reg [23:0] st2_x1;
    reg [48:0] st2_bias;

    reg [7:0] st2_exp_C, st2_exp_N, st2_exp_S;
    reg st2_ovf_C, st2_ovf_N, st2_ovf_S;
    reg st2_udf_C, st2_udf_N, st2_udf_S;

    wire [47:0] stage2_C = {1'b0, st1_y0_dy[47:24], 23'b0}; 
    wire [34:0] mult2    = st1_y0_dy[23:0] * st1_m_b_10_0; 
    wire [47:0] stage2_P = stage2_C - mult2;               
    wire [23:0] x1_taylor = stage2_P[46:23];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            st2_valid <= 1'b0;
            st2_sign <= 1'b0; st2_nan <= 1'b0; st2_true_inf <= 1'b0; st2_true_zero <= 1'b0; 
            st2_adjusted_a <= 25'b0; st2_x1 <= 24'b0; st2_bias <= 49'b0;
            
            st2_exp_C <= 8'b0; st2_exp_N <= 8'b0; st2_exp_S <= 8'b0;
            st2_ovf_C <= 1'b0; st2_ovf_N <= 1'b0; st2_ovf_S <= 1'b0;
            st2_udf_C <= 1'b0; st2_udf_N <= 1'b0; st2_udf_S <= 1'b0;
        end else begin
            st2_valid <= st1_valid;
            st2_sign <= st1_sign; 
            st2_nan <= st1_nan; 
            st2_true_inf <= st1_true_inf;
            st2_true_zero <= st1_true_zero;

            st2_adjusted_a <= st1_adjusted_a;
            st2_x1 <= x1_taylor;
            st2_bias <= st1_bias;
            
            st2_exp_C <= st1_exp_C; st2_exp_N <= st1_exp_N; st2_exp_S <= st1_exp_S;
            st2_ovf_C <= st1_ovf_C; st2_ovf_N <= st1_ovf_N; st2_ovf_S <= st1_ovf_S;
            st2_udf_C <= st1_udf_C; st2_udf_N <= st1_udf_N; st2_udf_S <= st1_udf_S;
        end
    end

    // =========================================================
    // 6. STAGE 3 (COMB & OUT): 最終結合と例外判定出力
    // =========================================================
    wire [41:0] mult3_lo = st2_adjusted_a * st2_x1[16:0];  
    wire [31:0] mult3_hi = st2_adjusted_a * st2_x1[23:17]; 
    
    wire [48:0] q_final  = {mult3_hi, 17'b0} + mult3_lo + st2_bias;

    wire carry = q_final[47]; 
    wire norm  = q_final[46]; 

    wire [22:0] final_fraction = carry ? q_final[46:24] :
                                 norm  ? q_final[45:23] :
                                         q_final[44:22];

    wire [7:0] final_exp = carry ? st2_exp_C :
                           norm  ? st2_exp_N :
                                   st2_exp_S;

    wire out_ovf = carry ? st2_ovf_C : (norm ? st2_ovf_N : st2_ovf_S);
    wire out_udf = carry ? st2_udf_C : (norm ? st2_udf_N : st2_udf_S);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result <= 32'b0;
            out_valid <= 1'b0;
        end else begin
            out_valid <= st2_valid;
            if (st2_valid) begin
                // ★シミュレータの挙動に完全に一致させる優先順位
                if (st2_nan) begin
                    result <= FP_NAN;
                end else if (st2_true_inf || out_ovf) begin
                    result <= {st2_sign, FP_INF[30:0]};
                end else if (st2_true_zero) begin
                    result <= {st2_sign, FP_ZERO[30:0]};
                end else if (out_udf) begin
                    result <= {st2_sign, FP_NON_NORM[30:0]};
                end else begin
                    result <= {st2_sign, final_exp, final_fraction};
                end
            end
        end
    end

endmodule
`default_nettype wire