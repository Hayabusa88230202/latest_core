`default_nettype wire

module top (
    // DDR2
    output wire [12:0] ddr2_addr,
    output wire [2:0] ddr2_ba,
    output wire ddr2_cas_n,
    output wire [0:0] ddr2_ck_n,
    output wire [0:0] ddr2_ck_p,
    output wire [0:0] ddr2_cke,
    output wire ddr2_ras_n,
    output wire ddr2_we_n,
    inout  wire [15:0] ddr2_dq,
    inout  wire [1:0] ddr2_dqs_n,
    inout  wire [1:0] ddr2_dqs_p,
    output wire [0:0] ddr2_cs_n,
    output wire [1:0] ddr2_dm,
    output wire [0:0] ddr2_odt,
    // others
    input logic clk,
    input logic rst,
    output logic [15:0] led,
    
    // UART信号
    input  wire uart_rx_i,
    output wire uart_tx_o 
);

    logic [31:0] input_data;   // CPU -> Cache/UART (Write Data)
    logic [31:0] input_addr;   // CPU -> Cache/UART (Address)

    logic [31:0] cache_rdata;     // Cacheから読み出されたデータ
    logic [31:0] cpu_read_data;   // 最終的にCPUに渡すデータ (MUX後)

    logic readtrigger;
    logic writetrigger;
    logic req_rdy;
    
    logic cpu_clk; 
    logic calib_done;
    logic [15:0] cpu_leds;

    logic [27:0] heartbeat;
    always_ff @(posedge cpu_clk) begin
        heartbeat <= heartbeat + 1;
    end

    // --- 究極のLEDデバッグ ---
    assign led[15] = cpu_leds[15]; // ストール判定 (1のはず)
    assign led[14:0] = cpu_leds[14:0]; // PCのインデックス (14bit) に戻す！

    // ----------------------------------------------------------------
    // アドレスデコード（MMIO）ロジック
    // ----------------------------------------------------------------
    logic  is_uart_addr;
    assign is_uart_addr = (input_addr == 32'hFFFF0000);

    logic uart_tx_busy;
    logic uart_tx_ready;
    // ★念のためのガード: メモリ準備前は書き込み信号も強制遮断
    logic uart_we;
    assign uart_we = writetrigger && is_uart_addr;

    logic cache_writetrigger;
    logic cache_readtrigger;
    assign cache_writetrigger = writetrigger && !is_uart_addr && calib_done;
    assign cache_readtrigger  = readtrigger  && !is_uart_addr && calib_done;

    logic cache_req_rdy;

    // ----------------------------------------------------------------
    // UART受信 (Read) ロジックの完全直結化
    // ----------------------------------------------------------------
    logic [7:0] rx_data_out;
    logic       rx_data_valid;
    wire        uart_rx_rd_en; // FIFOからUART_RXへの読み取り信号

    wire [31:0] fifo_cpu_data;
    wire        fifo_cpu_valid;

    // CPUがUARTアドレスを読もうとしている時だけ、UART_RXに「読み取り要求(rd_en)」を送る
    logic uart_re;
    assign uart_re = readtrigger && is_uart_addr && !cpu_fpu_stall;

    // DDR準備前(calib_done=0)にメモリアクセスしようとしたら、
    // キャッシュの返事を待たずに強制的にReady=0にしてCPUを安全に待機させる
    logic actual_cache_rdy;
    assign actual_cache_rdy = calib_done ? cache_req_rdy : 1'b0;

    // ================================================================
    // ★究極の解決策：UARTタイムアウト（オートEOF）回路
    // ================================================================
    logic [31:0] uart_timeout_cnt;
    always_ff @(posedge cpu_clk) begin
        if (!rst) begin
            uart_timeout_cnt <= 0;
        end else if (is_uart_addr && readtrigger && !fifo_cpu_valid) begin
            // UART受信待ちでデータが来ない間カウントアップ (3,000,000クロック = 0.1秒)
            // Pythonスクリプトの送信終了を確実に検知する
            if (uart_timeout_cnt < 32'd3_000_000) begin
                uart_timeout_cnt <= uart_timeout_cnt + 1;
            end
        end else begin
            uart_timeout_cnt <= 0;
        end
    end

    // 0.1秒待っても来なければ強制的に -1 (0xFFFFFFFF) を生成するフラグ
    wire force_minus_one = (uart_timeout_cnt >= 32'd3_000_000);

    // ★修正: Read時は、FIFOのデータがあるか、タイムアウトした時に Ready を返す
    assign req_rdy = is_uart_addr ? (writetrigger ? uart_tx_ready : (fifo_cpu_valid || force_minus_one)) 
                                  : actual_cache_rdy;

    // ★修正: タイムアウト時は強制的に -1 (0xFFFFFFFF) をCPUに渡す！
    assign cpu_read_data = is_uart_addr ? (force_minus_one ? 32'hFFFFFFFF : fifo_cpu_data) : cache_rdata;
    // ================================================================

    logic cpu_fpu_stall;

    // ----------------------------------------------------------------
    // モジュール接続
    // ----------------------------------------------------------------
    MIPS_CPU mips_core (
        .clk(cpu_clk),
        .rst(rst),
        .led(cpu_leds),
        .mem_ready(req_rdy),
        .mem_rdata(cpu_read_data),
        .mem_addr(input_addr),
        .mem_wdata(input_data),
        .mem_we(writetrigger),
        .mem_re(readtrigger),
        .stall_fpu_out(cpu_fpu_stall)
    );

    // --- UART TX モジュール ---
    uart_tx #(
        .CLK_FREQ(25_000_000),
        .CLOCKS_PER_BIT(217)
    ) uart_tx_inst (
        .clk(cpu_clk),
        .rst(rst),
        .data_in(input_data[7:0]),
        .tx_enable(uart_we),
        .tx_out(uart_tx_o),
        .tx_busy(uart_tx_busy),
        .tx_ready(uart_tx_ready)
    );

    // --- UART RX モジュール ---
    uart_rx #(
        .CLK_FREQ(25_000_000),
        .CLOCKS_PER_BIT(217)
    ) uart_rx_inst (
        .clk(cpu_clk),
        .rst(rst),
        .rx_in(uart_rx_i),
        .rd_en(uart_rx_rd_en),
        .data_out(rx_data_out),
        .data_valid(rx_data_valid)
    );

    // 32bit結合＆FIFOモジュール
    uart_word_fifo uart_fifo_inst (
        .clk(cpu_clk),
        .rst(rst),
        .uart_rx_data(rx_data_out),
        .uart_rx_valid(rx_data_valid),
        .uart_rx_rd_en(uart_rx_rd_en),
        
        .cpu_rd_en(uart_re),
        .cpu_read_data(fifo_cpu_data),
        .cpu_data_valid(fifo_cpu_valid)
    );

    cachecontroller cachecontroller_inst (
        .ddr2_addr(ddr2_addr),
        .ddr2_ba(ddr2_ba),
        .ddr2_cas_n(ddr2_cas_n),
        .ddr2_ck_n(ddr2_ck_n),
        .ddr2_ck_p(ddr2_ck_p),
        .ddr2_cke(ddr2_cke),
        .ddr2_ras_n(ddr2_ras_n),
        .ddr2_we_n(ddr2_we_n),
        .ddr2_dq(ddr2_dq),
        .ddr2_dqs_n(ddr2_dqs_n),
        .ddr2_dqs_p(ddr2_dqs_p),
        .ddr2_cs_n(ddr2_cs_n),
        .ddr2_dm(ddr2_dm),
        .ddr2_odt(ddr2_odt),
        
        .clk(clk),
        .reset_n(rst),
        
        .writetrigger(cache_writetrigger),
        .readtrigger(cache_readtrigger),
        .input_addr(input_addr),
        .input_data(input_data),
        .req_rdy(cache_req_rdy),
        .output_data(cache_rdata),
        
        .cpu_clk_out(cpu_clk), 
        .init_calib_complete_out(calib_done)
    );

endmodule