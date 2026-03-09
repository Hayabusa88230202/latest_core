// cachecontroller.sv
module cachecontroller (
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
    input logic        clk,
    input logic        reset_n,

    input logic        writetrigger,  // Write
    input logic        readtrigger, // Read
    input logic [31:0] input_addr,
    input logic [31:0] input_data,
    output logic       req_rdy,
    output logic [31:0] output_data,
    output logic        cpu_clk_out,

    output logic       init_calib_complete_out
);
    // clock
    logic cpu_clk;
    logic mig_clk;

    clk_wiz_0 clk_gen (
        .clk_in1(clk),
        .clk_out1(mig_clk),
        .clk_out2(cpu_clk)
    );

    assign cpu_clk_out = cpu_clk; 

    // interfaces
    master_fifo master_fifo ();
    slave_fifo slave_fifo ();

    // ★追加: MIGから出てくる安全なリセット信号を受け取るワイヤー
    //wire mig_safe_rst;

    // ★★★ 究極の修正: 極性をActive Lowに反転(NOT)させる！ ★★★
    //wire mig_safe_rst_n = ~mig_safe_rst;

    // --- 修正後 ---
    wire mig_fifo_rst; // ただのワイヤーを1本用意する

    // master
    cache cache_inst (
        .fifo(master_fifo),
        .clk(cpu_clk),
        .input_data(input_data),
        .input_addr(input_addr),
        .readtrigger(readtrigger),
        .writetrigger(writetrigger),
        .reset_n(reset_n),
        .req_rdy(req_rdy),
        .output_data(output_data)
    );

    // fifo
    dram_buf dram_buf (
        .master(master_fifo),
        .slave(slave_fifo),
        //.rst(reset_n)
        // ★修正: reset_n ではなく、MIGの安全なリセット信号を使う！
        .rst(mig_fifo_rst)
    );

    // slave
    dram_controller dram_controller (
        // DDR2
        .*,
        // others
        .sys_clk(mig_clk),
        .fifo(slave_fifo),
        .sys_rst_i(reset_n),

        .calib_done(init_calib_complete_out),
        .ui_rst_out(mig_fifo_rst) // ★追加: MIGから安全なリセット信号を受け取る
    );

endmodule