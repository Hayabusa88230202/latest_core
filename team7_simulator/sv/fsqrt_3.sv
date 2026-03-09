`default_nettype none

module fsqrt (
    input wire logic clk,
    input wire logic rst_n,
    input wire logic [31:0] input_a,
    input wire logic input_valid,
    output logic [31:0] result,
    output logic out_valid
);

(* ram_style = "block" *) reg [23:0] lut [0:1023];
(* ram_style = "block" *) reg [23:0] lut_sq [0:1023];

initial begin
  $readmemh("fsqrt_table.hex", lut);
  for (int i = 0; i < 1024; i++) begin
    lut_sq[i] = (48'(lut[i]) * lut[i]) >> 24;
  end
end

logic [2:0] valid_reg;
logic [2:0] is_zero_reg;
logic [2:0] is_abnormal_reg;

logic in_is_zero;
logic in_is_abnormal;

logic is_zero_final;
logic is_abnormal_final;

assign is_zero_final = is_zero_reg[1];
assign is_abnormal_final = is_abnormal_reg[1];
assign out_valid = valid_reg[2];

assign in_is_zero = (e_1 == 8'b0) && (m_1 == 23'b0);
assign in_is_abnormal = (e_1 == 8'b11111111);

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    valid_reg <= 3'b000;
    is_abnormal_reg <= 3'b000;
    is_zero_reg <= 3'b000;
  end else begin
    valid_reg <= {valid_reg[1:0], input_valid};
    is_abnormal_reg <= {is_abnormal_reg[1:0], in_is_abnormal};
    is_zero_reg <= {is_zero_reg[1:0], in_is_zero}; 
  end
end

logic s_1;
logic [7:0] e_1;
logic [22:0] m_1;

logic [7:0] exp_out;
logic sign_out;

logic [23:0] a_fixed;
logic [23:0] x_0;
logic [23:0] x0_x0;
logic [23:0] x_1;
logic [9:0] lut_addr;
assign lut_addr = {e_1[0], m_1[22:14]};

assign {s_1, e_1, m_1} = input_a; 

logic signed [8:0] e_wo_bias;
assign e_wo_bias = $signed({1'b0, e_1}) - 9'sd127;

always_ff @(posedge clk) begin
  x_0 <= lut[lut_addr];
  x0_x0 <= lut_sq[lut_addr];
end

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    exp_out <= 8'b0;
    sign_out <= 1'b0;
    a_fixed <= 24'b0;
  end else begin
    exp_out <= (e_wo_bias >>> 1) + 8'd127;
    sign_out <= s_1;
    if (e_1[0]) begin
      a_fixed <= {2'b01, m_1[22:1]};
    end else begin
      a_fixed <= {1'b1, m_1};
    end
  end
end


logic [23:0] double_x1;
logic [23:0] a_x0_x0;
logic [23:0] a_x0;

always_comb begin
  a_x0_x0 = (48'(a_fixed) * x0_x0) >> 24;
  a_x0 = (48'(a_fixed) * x_0) >> 24;
end

logic [23:0] a_x0_reg;
logic signed [17:0] delta_reg; 
logic [7:0] exp_reg;
logic [7:0] exp_reg_plus;
logic [7:0] exp_reg_minus;
logic sign_reg;

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    delta_reg <= 18'sb0;
    a_x0_reg <= 24'b0;
    exp_reg <= 8'b0;
    exp_reg_plus <= 8'b0;
    exp_reg_minus <= 8'b0;
    sign_reg <= 1'b0;
  end else begin
    logic [23:0] delta_24 = 24'h400000 - a_x0_x0;
    delta_reg <= delta_24[17:0]; 

    a_x0_reg <= a_x0;
    exp_reg <= exp_out;
    exp_reg_plus <= exp_out + 8'd1;
    exp_reg_minus <= exp_out - 8'd1;
    sign_reg <= sign_out;
  end
end


logic signed [24:0] a_x0_signed;
logic signed [42:0] delta_mult;
logic [47:0] P_out;
logic [23:0] result_inner;
logic [7:0] exp_final;
logic [22:0] mant_final;

always_comb begin
  a_x0_signed = {1'b0, a_x0_reg};
  delta_mult = a_x0_signed * delta_reg;
  P_out = {1'b0, a_x0_reg, 1'b0, 1'b1, 21'b0} + 48'($signed(delta_mult));
  result_inner = P_out[45:22];

  if (result_inner[23]) begin
    exp_final = exp_reg;
    mant_final = result_inner[22:0];
  end else begin
    exp_final = exp_reg_minus;
    mant_final = {result_inner[21:0], 1'b0};
  end       
end

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    result <= 32'b0;
  end else begin
    if (is_zero_final) begin
      result <= {sign_reg, 8'b0, 23'b0}; 
    end else if (is_abnormal_final) begin
      result <= {sign_reg, 8'hFF, 23'b0}; 
    end else begin
      result <= {sign_reg, exp_final, mant_final};
    end
  end
end
endmodule

