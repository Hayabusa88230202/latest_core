// dram_controller.sv
module dram_controller (
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
    input logic sys_clk,
    slave_fifo.slave fifo,
    input logic sys_rst_i,

    output logic calib_done,
    output logic ui_rst_out // ★追加: MIGの安全なリセット信号を外に出す
);
    // MIG Signals
    logic [26:0] app_addr;
    logic [2:0] app_cmd;
    logic app_en;
    logic app_rdy;
    logic [127:0] app_wdf_data;
    logic app_wdf_end;
    logic [15:0] app_wdf_mask;
    logic app_wdf_wren;
    logic app_wdf_rdy;
    logic [127:0] app_rd_data;
    logic app_rd_data_end;
    logic app_rd_data_valid;
    logic app_sr_req;
    logic app_ref_req;  
    logic app_zq_req;
    logic app_sr_active;  
    logic app_ref_ack;
    logic app_zq_ack;     
    logic init_calib_complete;
    logic ui_clk;
    logic ui_clk_sync_rst;  
    logic sys_clk_i;
    logic sys_rst;

    logic [26:0]  internal_addr;
    logic [127:0] internal_data;
    logic         internal_cmd; 

    mig_7series_0 mig (
        .ddr2_addr(ddr2_addr), .ddr2_ba(ddr2_ba), .ddr2_cas_n(ddr2_cas_n),
        .ddr2_ck_n(ddr2_ck_n), .ddr2_ck_p(ddr2_ck_p), .ddr2_cke(ddr2_cke),
        .ddr2_ras_n(ddr2_ras_n), .ddr2_we_n(ddr2_we_n), .ddr2_dq(ddr2_dq),
        .ddr2_dqs_n(ddr2_dqs_n), .ddr2_dqs_p(ddr2_dqs_p), .ddr2_cs_n(ddr2_cs_n),
        .ddr2_dm(ddr2_dm), .ddr2_odt(ddr2_odt),
        .app_addr(app_addr), .app_cmd(app_cmd), .app_en(app_en), .app_rdy(app_rdy),
        .app_wdf_data(app_wdf_data), .app_wdf_end(app_wdf_end), .app_wdf_mask(app_wdf_mask),
        .app_wdf_wren(app_wdf_wren), .app_wdf_rdy(app_wdf_rdy), .app_rd_data(app_rd_data),
        .app_rd_data_end(app_rd_data_end), .app_rd_data_valid(app_rd_data_valid),
        .app_sr_req(app_sr_req), .app_ref_req(app_ref_req), .app_zq_req(app_zq_req),
        .app_sr_active(app_sr_active), .app_ref_ack(app_ref_ack), .app_zq_ack(app_zq_ack),
        .init_calib_complete(init_calib_complete),
        .ui_clk(ui_clk), .ui_clk_sync_rst(ui_clk_sync_rst), .sys_clk_i(sys_clk_i), .sys_rst(sys_rst_i)
    );

    // ★追加: ui_clk_sync_rst をそのまま出力に繋ぐ
    assign ui_rst_out = ui_clk_sync_rst;

    assign app_sr_req  = 1'b0;  
    assign app_ref_req = 1'b0;
    assign app_zq_req  = 1'b0;  

    assign sys_clk_i = sys_clk;
    assign fifo.clk = ui_clk;
    assign fifo.rsp.data = app_rd_data;
    
    // ★修正3: MIGの初期化完了後のみ、Valid信号を受け付け、初期化中のゴミデータを無視する
    //assign fifo.rsp_en = app_rd_data_valid && init_calib_complete;

    // ★修正: === 1'b1 を使い、X(不定値)が来たら強制的に 0 にしてFIFOを守る
    assign fifo.rsp_en  = (init_calib_complete === 1'b1) ? app_rd_data_valid : 1'b0;
    assign fifo.req_rdy = (init_calib_complete === 1'b1) ? ((state == IDLE) && fifo.req_en) : 1'b0;

    enum logic [1:0] {
        IDLE,
        SEND_CMD_AND_DATA,
        SEND_CMD,
        SEND_DATA
    } state = IDLE;

    // ★修正4: MIGプロトコル違反を避けるため、app_wdf_end は app_wdf_wren と完全に同期させる
    assign app_wdf_end = app_wdf_wren;
    
    assign app_wdf_mask = '0;
    
    assign app_addr = internal_addr;
    assign app_cmd = {2'b00, internal_cmd};
    assign app_wdf_data = internal_data;

    // init_calib_completeが立つまでMIGへコマンドを出さない
   // assign fifo.req_rdy = (state == IDLE) && fifo.req_en && init_calib_complete;
   
    always_ff @ (posedge ui_clk) begin
        if (fifo.req_rdy) begin 
            internal_addr <= fifo.req.addr[26:0];
            internal_data <= fifo.req.data;
            internal_cmd  <= fifo.req.cmd;
        end

        if (state == IDLE) begin
            if (fifo.req_en && init_calib_complete) begin 
                state <= SEND_CMD_AND_DATA;
            end
        end else if (state == SEND_CMD_AND_DATA) begin
            if (internal_cmd) begin  // Read (1)
                if (app_rdy) begin
                    state <= IDLE;
                end
            end else begin  // Write (0)
                if (app_rdy && app_wdf_rdy) begin
                    state <= IDLE;
                end else if (app_rdy) begin 
                    state <= SEND_DATA;
                end else if (app_wdf_rdy) begin 
                    state <= SEND_CMD;
                end
            end
        end else if (state == SEND_CMD) begin 
            if (app_rdy) begin
                state <= IDLE;
            end
        end else if (state == SEND_DATA) begin
            if (app_wdf_rdy) begin
                state <= IDLE;
            end
        end
    end

    assign app_en = (state == SEND_CMD_AND_DATA) || (state == SEND_CMD);
    assign app_wdf_wren = ((state == SEND_CMD_AND_DATA) && !internal_cmd) || (state == SEND_DATA);
    
    assign calib_done = init_calib_complete;
endmodule