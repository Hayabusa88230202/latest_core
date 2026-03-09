// uart_rx.v
`timescale 1ns / 1ps

module uart_rx #(
  parameter CLK_FREQ = 30_000_000,
  parameter CLOCKS_PER_BIT = 260
)(
  input  wire       clk,
  input  wire       rst,
  input  wire       rx_in,
  input  wire       rd_en,      // ★追加: CPUからの読み取り要求 (mem_re をつなぐ)
  output wire [7:0] data_out,
  output wire       data_valid  // ★変更: データがある間ずっとHighになる
);

  localparam S_IDLE  = 3'd0;
  localparam S_START = 3'd1;
  localparam S_DATA  = 3'd2;
  localparam S_STOP  = 3'd3;

  reg [2:0]  state;
  reg [2:0]  bit_idx;
  reg [15:0] clk_cnt;
  reg [7:0]  rx_shift;

  // ★追加: 1バイトの待合室（FIFO）
  reg [7:0] holding_reg;
  reg       has_data;

  assign data_out   = holding_reg;
  assign data_valid = has_data;

  always @(posedge clk) begin
    if (!rst) begin
      state    <= S_IDLE;
      clk_cnt  <= 0;
      bit_idx  <= 0;
      rx_shift <= 8'd0;
      has_data <= 1'b0;
      holding_reg <= 8'd0;
    end else begin
      // CPUがデータを読み取ったらフラグを下ろす
      if (rd_en && has_data) begin
        has_data <= 1'b0;
      end

      case (state)
        S_IDLE: begin
          if (!rx_in) begin
            state   <= S_START;
            clk_cnt <= 0;
          end
        end

        S_START: begin
          if (clk_cnt == (CLOCKS_PER_BIT/2)) begin
            if (!rx_in) begin
              clk_cnt <= 0;
              bit_idx <= 0;
              state   <= S_DATA;
            end else begin
              state <= S_IDLE;
            end
          end else begin
            clk_cnt <= clk_cnt + 1;
          end
        end

        S_DATA: begin
          if (clk_cnt < CLOCKS_PER_BIT-1) begin
            clk_cnt <= clk_cnt + 1;
          end else begin
            clk_cnt <= 0;
            rx_shift[bit_idx] <= rx_in;
            if (bit_idx < 7)
              bit_idx <= bit_idx + 1;
            else
              state <= S_STOP;
          end
        end

        S_STOP: begin
          if (clk_cnt < (CLOCKS_PER_BIT - 1)) begin
            clk_cnt <= clk_cnt + 1;
          end else begin
            state <= S_IDLE; // S_DONEを廃止して直接IDLEへ
            clk_cnt <= 0;
            // 受信完了！待合室にデータを入れる
            holding_reg <= rx_shift;
            has_data    <= 1'b1;
          end
        end
      endcase
    end
  end
endmodule