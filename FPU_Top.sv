// FPU_Top.sv
`default_nettype none

module FPU_Top (
    input  wire logic        clk,
    input  wire logic        rst_n,

    input  wire logic [31:0] instruction_ex, 
    input  wire logic [31:0] cpu_rdata1_ex,  
    input  wire logic [31:0] cpu_rdata2_ex,  
    
    input  wire logic        ext_we,        
    input  wire logic [4:0]  ext_waddr,      
    input  wire logic [31:0] ext_wdata,      

    output logic [31:0]      fpu_rdata_ex,   
    output logic [31:0]      fpu_wdata_ex,   
    output logic [31:0]      fpu_arith_result, 
    output logic             fpu_stall_req,  
    output logic             fpu_flag_out,
    input  wire logic        cpu_stalled_ex  
);

    wire [5:0] opcode = instruction_ex[31:26];
    wire [5:0] funct  = instruction_ex[5:0];
    wire [4:0] fmt    = instruction_ex[25:21];
    wire [4:0] ft     = instruction_ex[20:16];
    wire [4:0] fs     = instruction_ex[15:11];
    wire [4:0] fd     = instruction_ex[10:6];
    
    wire is_cop1   = (opcode == 6'h11);
    wire is_fmt_s  = is_cop1 && (fmt == 5'd16);
    wire is_fadd   = is_fmt_s && (funct == 6'h00);
    wire is_fsub   = is_fmt_s && (funct == 6'h01);
    wire is_fmul   = is_fmt_s && (funct == 6'h02);
    wire is_fdiv   = is_fmt_s && (funct == 6'h03);
    wire is_fsqrt  = is_fmt_s && (funct == 6'h04);
    wire is_fabs   = is_fmt_s && (funct == 6'h05);
    wire is_fmove  = is_fmt_s && (funct == 6'h06);
    wire is_fneg   = is_fmt_s && (funct == 6'h07);
    wire is_floor  = is_fmt_s && (funct == 6'h0F);
    wire is_ftoi   = is_fmt_s && (funct == 6'h24);
    
    wire is_c_eq   = is_fmt_s && (funct == 6'h32);
    wire is_c_lt   = is_fmt_s && (funct == 6'h3C);
    wire is_c_le   = is_fmt_s && (funct == 6'h3E);
    
    wire is_itof   = is_cop1 && (fmt == 5'd20) && (funct == 6'h20);

    logic [31:0] fpu_regs [31:0];
    logic        fpu_cond_flag; 
    logic [31:0] reg_rdata_s, reg_rdata_t;
    logic        internal_we;
    logic [4:0]  internal_waddr;
    logic [31:0] internal_wdata;

    logic [31:0] fpu_val_s, fpu_val_t;
    always_comb begin
        fpu_val_s = fpu_regs[fs];
        if (ext_we && (ext_waddr == fs)) fpu_val_s = ext_wdata;
        if (internal_we && (internal_waddr == fs)) fpu_val_s = internal_wdata;

        fpu_val_t = fpu_regs[ft];
        if (ext_we && (ext_waddr == ft)) fpu_val_t = ext_wdata;
        if (internal_we && (internal_waddr == ft)) fpu_val_t = internal_wdata;
    end

    always_comb begin
        reg_rdata_s = fpu_val_s;
        reg_rdata_t = fpu_val_t;
    end

    assign fpu_wdata_ex = fpu_val_t; 
    assign fpu_rdata_ex = fpu_val_s;

    always_ff @(posedge clk) begin
        if (ext_we && internal_we) begin
            if (ext_waddr == internal_waddr) begin
                fpu_regs[internal_waddr] <= internal_wdata;
            end else begin
                fpu_regs[ext_waddr] <= ext_wdata;
                fpu_regs[internal_waddr] <= internal_wdata;
            end
        end else if (ext_we) begin
            fpu_regs[ext_waddr] <= ext_wdata;
        end else if (internal_we) begin
            fpu_regs[internal_waddr] <= internal_wdata;
        end
    end
    
    assign fpu_flag_out = fpu_cond_flag;

    enum logic [1:0] {IDLE, BUSY, DONE} state; 
    wire start_arith = (state == IDLE) && (is_fadd | is_fsub | is_fmul | is_fdiv | is_fsqrt | is_ftoi | is_itof | is_fneg | is_fabs | is_floor | is_c_eq | is_c_lt | is_c_le | is_fmove);
    
    wire [31:0] op_a = is_itof ? cpu_rdata1_ex : reg_rdata_s;
    wire [31:0] op_b = is_fsub ? {~reg_rdata_t[31], reg_rdata_t[30:0]} : reg_rdata_t;

    // =========================================================
    // ★ 究極の防御シールド＋NaN伝播（完全版）
    // =========================================================
    wire fdiv_b_is_zero = (op_b[30:0] == 31'b0);
    wire [31:0] safe_fdiv_b = fdiv_b_is_zero ? 32'h3F800000 : op_b; 
    
    wire fsqrt_is_neg = op_a[31] && (op_a[30:0] != 31'b0);
    wire [31:0] safe_fsqrt_a = fsqrt_is_neg ? 32'b0 : op_a; 

    // 入力のどちらかがNaNなら、すべての計算結果をNaNで塗りつぶす！
    wire a_is_nan = (&op_a[30:23]) && (|op_a[22:0]);
    wire b_is_nan = (&op_b[30:23]) && (|op_b[22:0]);
    wire has_nan  = a_is_nan | b_is_nan;
    wire [31:0] NAN_VALUE = 32'h7FC00000;

    logic [31:0] res_add_raw, res_mul_raw, res_div_raw, res_sqrt_raw;
    logic        val_add, val_mul, val_div, val_sqrt, val_ftoi, val_itof;
    logic [31:0] res_ftoi, res_itof;

    fadd u_fadd (.clk(clk), .rst_n(rst_n), .input_a(op_a), .input_b(op_b), .input_valid(start_arith && (is_fadd || is_fsub)), .result(res_add_raw), .out_valid(val_add));
    fmul u_fmul (.clk(clk), .rst_n(rst_n), .input_a(op_a), .input_b(op_b), .input_valid(start_arith && is_fmul), .result(res_mul_raw), .out_valid(val_mul));
    fdiv u_fdiv (.clk(clk), .rst_n(rst_n), .input_a(op_a), .input_b(safe_fdiv_b), .input_valid(start_arith && is_fdiv), .result(res_div_raw), .out_valid(val_div));
    fsqrt u_fsqrt (.clk(clk), .rst_n(rst_n), .input_a(safe_fsqrt_a), .input_valid(start_arith && is_fsqrt), .result(res_sqrt_raw), .out_valid(val_sqrt));

    // 結果のすり替え (NaNの完全伝播)
    wire [31:0] res_add  = has_nan ? NAN_VALUE : res_add_raw;
    wire [31:0] res_mul  = has_nan ? NAN_VALUE : res_mul_raw;
    wire [31:0] res_div  = has_nan ? NAN_VALUE : (fdiv_b_is_zero ? {op_a[31] ^ op_b[31], 8'hFF, 23'b0} : res_div_raw);
    wire [31:0] res_sqrt = a_is_nan ? NAN_VALUE : (fsqrt_is_neg ? NAN_VALUE : res_sqrt_raw);
    // =========================================================

    ftoi u_ftoi (.clk(clk), .rst_n(rst_n), .in_f(op_a), .input_valid(start_arith && is_ftoi), .out_i(res_ftoi), .out_valid(val_ftoi));
    itof u_itof (.clk(clk), .rst_n(rst_n), .in_i(op_a), .input_valid(start_arith && is_itof), .out_f(res_itof), .out_valid(val_itof));

    logic [31:0] res_neg; logic val_neg;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin res_neg <= 0; val_neg <= 0; end
        else begin val_neg <= start_arith && is_fneg; res_neg <= {~op_a[31], op_a[30:0]}; end
    end

    logic [31:0] res_abs; logic val_abs;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin res_abs <= 0; val_abs <= 0; end
        else begin val_abs <= start_arith && is_fabs; res_abs <= {1'b0, op_a[30:0]}; end
    end

    logic [31:0] res_fmove; logic val_fmove;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin res_fmove <= 0; val_fmove <= 0; end
        else begin val_fmove <= start_arith && is_fmove; res_fmove <= op_a; end
    end

    logic [31:0] res_floor; logic val_floor;
    ffloor u_ffloor (.clk(clk), .rst_n(rst_n), .in_f(op_a), .input_valid(start_arith && is_floor), .out_f(res_floor), .out_valid(val_floor));

    logic val_cmp; logic cmp_result;
    wire a_zero = (op_a[30:0] == 0); wire b_zero = (op_b[30:0] == 0);
    wire ieee_eq = (a_zero && b_zero) || (op_a == op_b);
    
    logic ieee_le; logic ieee_lt;
    always_comb begin
        if (a_zero && b_zero) ieee_le = 1; else if (op_a[31] != op_b[31]) ieee_le = op_a[31]; else if (op_a[31]) ieee_le = (op_a >= op_b); else ieee_le = (op_a <= op_b);
        if (a_zero && b_zero) ieee_lt = 0; else if (op_a[31] != op_b[31]) ieee_lt = op_a[31]; else if (op_a[31]) ieee_lt = (op_a > op_b);  else ieee_lt = (op_a < op_b);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin val_cmp <= 0; cmp_result <= 0; end
        else begin
            val_cmp <= start_arith && (is_c_eq || is_c_le || is_c_lt);
            if (has_nan) begin
                cmp_result <= 1'b0; 
            end else if (is_c_eq) begin
                cmp_result <= ieee_eq;
            end else if (is_c_le) begin
                cmp_result <= ieee_le;
            end else if (is_c_lt) begin
                cmp_result <= ieee_lt;
            end
        end
    end

    wire any_valid = val_add | val_mul | val_div | val_sqrt | val_ftoi | val_itof | val_neg | val_abs | val_floor | val_cmp | val_fmove;
    logic [31:0] result_mux;
    always_comb begin
        if (val_add) result_mux = res_add; else if (val_mul) result_mux = res_mul; else if (val_div) result_mux = res_div;
        else if (val_sqrt) result_mux = res_sqrt; else if (val_ftoi) result_mux = res_ftoi; else if (val_itof) result_mux = res_itof;
        else if (val_neg) result_mux = res_neg; else if (val_abs) result_mux = res_abs; else if (val_floor) result_mux = res_floor;
        else if (val_fmove) result_mux = res_fmove;
        else result_mux = 32'b0;
    end

    assign fpu_arith_result = result_mux;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE; internal_we <= 0; internal_waddr <= 0; internal_wdata <= 0; fpu_cond_flag <= 0;
        end else begin
            internal_we <= 0; 
            case (state)
                IDLE: begin
                    if (start_arith) begin state <= BUSY; internal_waddr <= fd; end
                end
                BUSY: begin
                    if (any_valid) begin
                        if (val_cmp) begin
                            fpu_cond_flag <= cmp_result;
                        end else if (val_ftoi) begin
                            internal_we <= 0;
                        end else begin
                            internal_we <= 1;
                            internal_wdata <= result_mux;
                        end
                        
                        if (cpu_stalled_ex) state <= DONE;
                        else state <= IDLE;
                    end
                end
                DONE: begin
                    if (!cpu_stalled_ex) state <= IDLE;
                end
            endcase
        end
    end

    assign fpu_stall_req = (state == BUSY && !any_valid) || start_arith;
endmodule
`default_nettype wire