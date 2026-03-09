`default_nettype none

module itof (
    input  wire logic        clk,
    input  wire logic        rst_n,
    input  wire logic [31:0] in_i,
    input  wire logic        input_valid,
    output      logic [31:0] out_f,
    output      logic        out_valid
);

    // =========================================================
    // STAGE 1: 符号と絶対値の計算
    // =========================================================
    logic [31:0] s1_abs_i;
    logic        s1_sign;
    logic        s1_valid;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s1_abs_i <= 32'b0;
            s1_sign  <= 1'b0;
            s1_valid <= 1'b0;
        end else begin
            s1_valid <= input_valid;
            s1_sign  <= in_i[31];
            // 2の補数で絶対値を求める
            s1_abs_i <= in_i[31] ? (~in_i + 32'd1) : in_i;
        end
    end

    // =========================================================
    // STAGE 2: Leading Zero Count (LZC) の計算
    // =========================================================
    function automatic logic [4:0] lzc32(input logic [31:0] v);
        if (v[31]) return 5'd0;  if (v[30]) return 5'd1;  if (v[29]) return 5'd2;  if (v[28]) return 5'd3;
        if (v[27]) return 5'd4;  if (v[26]) return 5'd5;  if (v[25]) return 5'd6;  if (v[24]) return 5'd7;
        if (v[23]) return 5'd8;  if (v[22]) return 5'd9;  if (v[21]) return 5'd10; if (v[20]) return 5'd11;
        if (v[19]) return 5'd12; if (v[18]) return 5'd13; if (v[17]) return 5'd14; if (v[16]) return 5'd15;
        if (v[15]) return 5'd16; if (v[14]) return 5'd17; if (v[13]) return 5'd18; if (v[12]) return 5'd19;
        if (v[11]) return 5'd20; if (v[10]) return 5'd21; if (v[9])  return 5'd22; if (v[8])  return 5'd23;
        if (v[7])  return 5'd24; if (v[6])  return 5'd25; if (v[5])  return 5'd26; if (v[4])  return 5'd27;
        if (v[3])  return 5'd28; if (v[2])  return 5'd29; if (v[1])  return 5'd30; if (v[0])  return 5'd31;
        return 5'd31;
    endfunction

    logic [4:0]  s2_lzc;
    logic [31:0] s2_abs_i;
    logic        s2_sign;
    logic        s2_valid;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s2_lzc   <= 5'b0;
            s2_abs_i <= 32'b0;
            s2_sign  <= 1'b0;
            s2_valid <= 1'b0;
        end else begin
            s2_valid <= s1_valid;
            s2_sign  <= s1_sign;
            s2_abs_i <= s1_abs_i;
            s2_lzc   <= lzc32(s1_abs_i);
        end
    end

    // =========================================================
    // STAGE 3: シフト、丸め処理、出力の組み立て
    // =========================================================
    logic [7:0]  next_exp;
    logic [22:0] next_frac;
    logic [31:0] shifted_mant;
    logic        guard;
    logic        round;
    logic        sticky;
    logic        lsb;

    always_comb begin
        // ★ラッチ生成防止のための初期化
        next_exp     = 8'd0;
        next_frac    = 23'd0;
        shifted_mant = 32'd0;
        guard        = 1'b0;
        round        = 1'b0;
        sticky       = 1'b0;
        lsb          = 1'b0;

        if (s2_abs_i != 32'b0) begin
            logic [7:0] temp_exp;
            temp_exp = 8'd127 + (8'd31 - {3'b0, s2_lzc});
            shifted_mant = s2_abs_i << s2_lzc;
            
            guard  = shifted_mant[7];
            round  = shifted_mant[6];
            sticky = (shifted_mant[5:0] != 6'b0);
            lsb    = shifted_mant[8];

            // nearest round half to even
            if (guard && (round || sticky || lsb)) begin
                // 仮数部が桁あふれした場合は、自然と temp_exp 側にキャリーが足される
                {next_exp, next_frac} = {temp_exp, shifted_mant[30:8]} + 24'd1;
            end else begin
                next_exp  = temp_exp;
                next_frac = shifted_mant[30:8];
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_f     <= 32'b0;
            out_valid <= 1'b0;
        end else begin
            out_valid <= s2_valid;
            if (s2_abs_i == 32'b0) begin
                out_f <= 32'b0;
            end else begin
                out_f <= {s2_sign, next_exp, next_frac};
            end
        end
    end

endmodule

`default_nettype wire