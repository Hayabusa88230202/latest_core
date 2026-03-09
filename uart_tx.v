// uart_tx.v
`timescale 1ns / 1ps

module uart_tx #(
  parameter CLK_FREQ = 30_000_000,
  parameter CLOCKS_PER_BIT = 260 // 1 Mbps相当
)(
  input  wire       clk,
  input  wire       rst,        // アクティブロー
  input  wire [7:0] data_in,
  input  wire       tx_enable,    // ★レベル駆動（1なら送信開始）
  output reg        tx_out,
  output reg        tx_busy,
  output wire       tx_ready      // 次の送信が可能ならHigh
);

  localparam S_IDLE  = 3'd0;
  localparam S_START = 3'd1;
  localparam S_DATA  = 3'd2;
  localparam S_STOP  = 3'd3;

  reg [2:0] state;
  reg [2:0] bit_idx;
  reg [7:0] tx_data;
  reg [15:0] clk_cnt;

  assign tx_ready = (state == S_IDLE);

  always @(posedge clk) begin
    if (!rst) begin
      tx_out  <= 1'b1;
      tx_busy <= 1'b0;
      state   <= S_IDLE;
      bit_idx <= 3'd0;
      clk_cnt <= 16'd0;
      tx_data <= 8'd0;
    end else begin
      case (state)
        S_IDLE: begin
          tx_out  <= 1'b1;
          tx_busy <= 1'b0;
          if (tx_enable) begin // ★ 究極の修正: エッジ検出を削除！1なら即座に反応させる！
            tx_data <= data_in;
            tx_busy <= 1'b1;
            state   <= S_START;
            clk_cnt <= 0;
          end
        end

        S_START: begin
          tx_out <= 1'b0;  // Start bit
          if (clk_cnt < CLOCKS_PER_BIT-1)
            clk_cnt <= clk_cnt + 1;
          else begin
            clk_cnt <= 0;
            state   <= S_DATA;
            bit_idx <= 0;
          end
        end

        S_DATA: begin
          tx_out <= tx_data[bit_idx];
          if (clk_cnt < CLOCKS_PER_BIT-1)
            clk_cnt <= clk_cnt + 1;
          else begin
            clk_cnt <= 0;
            if (bit_idx < 7)
              bit_idx <= bit_idx + 1;
            else
              state <= S_STOP;
          end
        end

        S_STOP: begin
          tx_out <= 1'b1;  // Stop bit
          if (clk_cnt < CLOCKS_PER_BIT-1)
            clk_cnt <= clk_cnt + 1;
          else begin
            state   <= S_IDLE;
            tx_busy <= 1'b0;
          end
        end
      endcase
    end
  end
endmodule