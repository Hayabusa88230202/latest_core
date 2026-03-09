`default_nettype wire

module uart_word_fifo (
    input  wire        clk,
    input  wire        rst,
    
    // UART_RXモジュールとの接続
    input  wire [7:0]  uart_rx_data,
    input  wire        uart_rx_valid,
    output reg         uart_rx_rd_en,
    
    // CPU(top.sv)との接続
    input  wire        cpu_rd_en,     // CPUからの読み取り要求
    output wire [31:0] cpu_read_data, // CPUへ渡す32bitデータ
    output wire        cpu_data_valid // 1ならデータ準備OK（0ならCPUをストールさせる）
);

    // ===================================================
    // 1. 1バイト×4回を32ビットにパッキングする回路
    // ===================================================
    reg [31:0] assembled_word;
    reg [1:0]  byte_count;
    reg        word_push; // FIFOへの書き込み要求
    reg [31:0] word_to_push;

    always @(posedge clk) begin
        if (!rst) begin
            byte_count <= 2'd0;
            uart_rx_rd_en <= 1'b0;
            word_push <= 1'b0;
            assembled_word <= 32'd0;
        end else begin
            word_push <= 1'b0; // デフォルトは0
            uart_rx_rd_en <= 1'b0;
            
            // UARTからデータが来ていて、かつ今読み取り要求を出していない場合
            if (uart_rx_valid && !uart_rx_rd_en) begin
                uart_rx_rd_en <= 1'b1; // UART_RXのフラグを下ろす
                
                // ★エンディアンの設定 (リトルエンディアン想定: 先に来たバイトが下位)
                if (byte_count == 2'd0) assembled_word[7:0]   <= uart_rx_data;
                if (byte_count == 2'd1) assembled_word[15:8]  <= uart_rx_data;
                if (byte_count == 2'd2) assembled_word[23:16] <= uart_rx_data;
                if (byte_count == 2'd3) begin
                    assembled_word[31:24] <= uart_rx_data;
                    word_to_push <= {uart_rx_data, assembled_word[23:0]};
                    word_push <= 1'b1; // 4バイト揃ったらFIFOへPush！
                end
                
                byte_count <= byte_count + 1;
            end
        end
    end

    // ===================================================
    // 2. 32ビット幅 × 1024段の FIFOバッファ (BRAMに推論されます)
    // ===================================================
    reg [31:0] fifo_mem [0:1023];
    reg [9:0]  wr_ptr;
    reg [9:0]  rd_ptr;
    reg [10:0] fifo_count; // FIFO内のデータ数

    always @(posedge clk) begin
        if (!rst) begin
            wr_ptr <= 10'd0;
            rd_ptr <= 10'd0;
            fifo_count <= 11'd0;
        end else begin
            case ({word_push, cpu_rd_en && cpu_data_valid})
                2'b10: begin // Pushのみ
                    fifo_mem[wr_ptr] <= word_to_push;
                    wr_ptr <= wr_ptr + 1;
                    fifo_count <= fifo_count + 1;
                end
                2'b01: begin // Pop(CPU読み取り)のみ
                    rd_ptr <= rd_ptr + 1;
                    fifo_count <= fifo_count - 1;
                end
                2'b11: begin // 同時
                    fifo_mem[wr_ptr] <= word_to_push;
                    wr_ptr <= wr_ptr + 1;
                    rd_ptr <= rd_ptr + 1;
                    // fifo_count は増減なし
                end
            endcase
        end
    end

    // FIFOが空でなければデータ有効（CPUに待機を解除させる）
    assign cpu_data_valid = (fifo_count != 0);
    assign cpu_read_data  = fifo_mem[rd_ptr];

endmodule