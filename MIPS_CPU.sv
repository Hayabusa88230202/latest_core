// MIPS_CPU.sv
`default_nettype wire

module MIPS_CPU (
    input  logic        clk,
    input  logic        rst, 
    output logic [15:0] led,
    input  logic        mem_ready,  
    input  logic [31:0] mem_rdata,  
    output logic [31:0] mem_addr,   
    output logic [31:0] mem_wdata,  
    output logic        mem_we,     
    output logic        mem_re,
    output logic        stall_fpu_out      
);

    (* mark_debug = "true" *) wire [31:0] pc_current;
    (* mark_debug = "true" *) wire [31:0] instruction_id;
    wire [31:0] pc_plus_4_if, pc_plus_4_id, instruction_fetched;

    wire stall_pc, stall_if_id, stall_id_ex, stall_ex_mem, stall_mem_wb;
    wire flush_if_id, flush_id_ex, load_use_stall, load_use_flush, branch_taken_ex;
    wire fpu_load_use_stall; 
    wire global_load_use_stall = load_use_stall || fpu_load_use_stall;
    wire global_load_use_flush = load_use_flush || fpu_load_use_stall;

    wire stall_fpu, fpu_flag_ex;
    wire [31:0] fpu_rdata_ex, fpu_wdata_ex;

    wire is_mem_access = MemRead_mem || MemWrite_mem;
    wire fetching_from_dram = (pc_current >= 32'h00040000);
    wire structural_hazard  = is_mem_access && fetching_from_dram;
    wire mem_busy = (mem_re || mem_we) && !mem_ready;
    
    // =========================================================
    // ★究極の修正: ジャンプと構造的ハザードの衝突を防ぐ「足止め」ロジック
    // =========================================================
    wire hold_branch = structural_hazard && branch_taken_ex;

    // ★追加: FPU以外の理由（DRAM待ちなど）によるEXステージのストール信号
    wire ex_stall_no_fpu = mem_busy || hold_branch;

    // stall_pc は元の安全なロジックに戻す
    assign stall_pc     = global_load_use_stall || mem_busy || stall_fpu || structural_hazard;
    
    // hold_branch が発動した時は、EXステージにジャンプ命令を「留めておく」
    assign stall_if_id  = global_load_use_stall || mem_busy || stall_fpu || hold_branch;
    //assign stall_id_ex  = mem_busy || stall_fpu || hold_branch;
    assign stall_id_ex  = ex_stall_no_fpu || stall_fpu; // ★修正
    assign stall_ex_mem = mem_busy || stall_fpu;
    assign stall_mem_wb = mem_busy || stall_fpu;

    assign stall_fpu_out = stall_fpu; 
   
    assign flush_if_id  = branch_taken_ex || (structural_hazard && !stall_if_id);
    
    // 足止め中は ID/EX をフラッシュ（消去）しないように保護する
    assign flush_id_ex  = (global_load_use_flush || branch_taken_ex) && !stall_ex_mem && !stall_fpu && !hold_branch;

    wire [31:0] pc_in = (is_jr_ex)       ? alu_input_a_ex :        
                        (Jump_ex)        ? jump_target_addr_ex :   
                        (branch_cond_ex) ? branch_target_addr_ex : 
                                           pc_plus_4_if;           

    ProgramCounter pc_unit (.clk(clk), .rst(rst), .i_stall(stall_pc), .PC_in(pc_in), .PC_out(pc_current));
    assign pc_plus_4_if = pc_current + 32'd4;
    wire [31:0] internal_rom_out;

    InstructionMemory_readmemh instr_mem (.clk(clk), .ReadAddress(pc_current), .Instruction(internal_rom_out), .write_address(data_addr), .write_data(data_wdata), .write_enable(((data_addr < 32'h00040000) && mem_we)));
    assign instruction_fetched = (pc_current < 32'h00040000) ? internal_rom_out : mem_rdata;

    PipelineRegister_IF_ID if_id_reg (.clk(clk), .rst(rst), .i_stall(stall_if_id), .i_flush(flush_if_id), .i_instruction(instruction_fetched), .i_pc_plus_4(pc_plus_4_if), .o_instruction(instruction_id), .o_pc_plus_4(pc_plus_4_id));

    // =========================================================
    // IDステージ (デコード)
    // =========================================================
    wire is_cop1_id = (instruction_id[31:26] == 6'h11);
    wire is_itof_id = is_cop1_id && (instruction_id[25:21] == 5'd20) && (instruction_id[5:0] == 6'h20);
    wire is_ftoi_id = is_cop1_id && (instruction_id[25:21] == 5'd16) && (instruction_id[5:0] == 6'h24);

    wire [1:0] RegDst_id, MemToReg_id; wire [2:0] ALUOp_id;
    wire ALUSrc_id, RegWrite_id, MemRead_id, MemWrite_id, BEQ_id, BNE_id, Jump_id, ExtOp_id, BranchFP_id;
    wire [31:0] read_data_1_id, read_data_2_id, sign_extended_imm_id;

    MainController main_controller_unit (.Opcode(instruction_id[31:26]), .Funct(instruction_id[5:0]), .Rs(instruction_id[25:21]), .RegDst(RegDst_id), .ALUSrc(ALUSrc_id), .MemToReg(MemToReg_id), .RegWrite(RegWrite_id), .MemRead(MemRead_id), .MemWrite(MemWrite_id), .Beq(BEQ_id), .Bne(BNE_id), .Jump(Jump_id), .ExtOp(ExtOp_id), .ALUOp(ALUOp_id), .BranchFP(BranchFP_id));
    assign sign_extended_imm_id = (ExtOp_id) ? {{16{instruction_id[15]}}, instruction_id[15:0]} : {16'b0, instruction_id[15:0]};

    wire [4:0] rs_addr_id = is_itof_id ? instruction_id[15:11] : instruction_id[25:21];
    wire actual_regwrite_id = RegWrite_id || is_ftoi_id;

    RegisterFile rf_unit (.clk(clk), .rst(rst), .ReadAddr1(rs_addr_id), .ReadAddr2(instruction_id[20:16]), .ReadData1(read_data_1_id), .ReadData2(read_data_2_id), .RegWrite(RegWrite_wb), .WriteAddr(Write_Addr_wb), .WriteData(write_data_wb));

    wire [1:0] RegDst_ex, MemToReg_ex; wire [2:0] ALUOp_ex;
    wire ALUSrc_ex, RegWrite_ex, MemRead_ex, MemWrite_ex, BEQ_ex, BNE_ex, Jump_ex, BranchFP_ex;
    wire [31:0] ReadData1_ex, ReadData2_ex, SignExtendedImm_ex, PC_Plus_4_ex;
    wire [25:0] JumpIndex_ex; wire [5:0] Funct_ex; wire [4:0] ShiftAmount_ex; wire [31:0] instruction_ex;
    
    (* mark_debug = "true" *) wire [4:0] rs_addr_ex, rt_addr_ex; wire [4:0] rd_addr_ex, write_addr_ex;

    PipelineRegister_ID_EX id_ex_reg (
        .clk(clk), .rst(rst), .i_stall(stall_id_ex), .i_flush(flush_id_ex),
        .i_RegDst(RegDst_id), .i_ALUSrc(ALUSrc_id), .i_MemToReg(MemToReg_id),
        .i_RegWrite(actual_regwrite_id), .i_MemRead(MemRead_id), .i_MemWrite(MemWrite_id),
        .i_BEQ(BEQ_id), .i_BNE(BNE_id), .i_Jump(Jump_id), .i_ALUOp(ALUOp_id), .i_BranchFP(BranchFP_id),
        .i_ReadData1(read_data_1_id), .i_ReadData2(read_data_2_id),
        .i_SignExtendedImm(sign_extended_imm_id), .i_PC_Plus_4(pc_plus_4_id),
        .i_JumpIndex(instruction_id[25:0]), .i_Funct(instruction_id[5:0]), .i_ShiftAmount(instruction_id[10:6]),
        .i_rs_addr(rs_addr_id), .i_rt_addr(instruction_id[20:16]), .i_rd_addr(instruction_id[15:11]), .i_instruction(instruction_id),

        .o_RegDst(RegDst_ex), .o_ALUSrc(ALUSrc_ex), .o_MemToReg(MemToReg_ex),
        .o_RegWrite(RegWrite_ex), .o_MemRead(MemRead_ex), .o_MemWrite(MemWrite_ex),
        .o_BEQ(BEQ_ex), .o_BNE(BNE_ex), .o_Jump(Jump_ex), .o_ALUOp(ALUOp_ex), .o_BranchFP(BranchFP_ex),
        .o_ReadData1(ReadData1_ex), .o_ReadData2(ReadData2_ex),
        .o_SignExtendedImm(SignExtendedImm_ex), .o_PC_Plus_4(PC_Plus_4_ex),
        .o_JumpIndex(JumpIndex_ex), .o_Funct(Funct_ex), .o_ShiftAmount(ShiftAmount_ex),
        .o_rs_addr(rs_addr_ex), .o_rt_addr(rt_addr_ex), .o_rd_addr(rd_addr_ex), .o_instruction(instruction_ex)
    );

    HazardDetectionUnit hazard_detection_unit (.i_MemRead_ex(MemRead_ex), .i_rt_addr_ex(rt_addr_ex), .i_rs_addr_id(rs_addr_id), .i_rt_addr_id(instruction_id[20:16]), .o_stall_pc_ifid(load_use_stall), .o_flush_idex(load_use_flush));

    wire [1:0] forward_a, forward_b;
    ForwardingUnit forwarding_unit (.i_rs_addr_ex(rs_addr_ex), .i_rt_addr_ex(rt_addr_ex), .i_RegWrite_mem(RegWrite_mem), .i_Write_Addr_mem(Write_Addr_mem), .i_RegWrite_wb(RegWrite_wb), .i_Write_Addr_wb(Write_Addr_wb), .o_ForwardA(forward_a), .o_ForwardB(forward_b));

    wire [31:0] alu_input_a_ex = (forward_a == 2'b00) ? ReadData1_ex : (forward_a == 2'b01) ? ALU_Result_mem : write_data_wb;
    wire [31:0] alu_input_b_mux_out = (forward_b == 2'b00) ? ReadData2_ex : (forward_b == 2'b01) ? ALU_Result_mem : write_data_wb;
    wire [31:0] alu_input_b_ex = (ALUSrc_ex) ? SignExtendedImm_ex : alu_input_b_mux_out;

    wire [3:0]  alu_control_ex; wire [31:0] alu_result_ex; wire zero_flag_ex;
    ALUControl alu_control_unit (.ALUOp(ALUOp_ex), .Funct(Funct_ex), .ALUOut(alu_control_ex));
    ALU alu_unit (.A(alu_input_a_ex), .B(alu_input_b_ex), .ShiftAmount(ShiftAmount_ex), .ALUControl(alu_control_ex), .Result(alu_result_ex), .Zero(zero_flag_ex));

    wire is_mtc1_ex = (instruction_ex[31:26] == 6'h11) && (instruction_ex[25:21] == 5'd04);
    wire is_flw_ex  = (instruction_ex[31:26] == 6'h31);
    wire [4:0] flw_addr_ex = instruction_ex[20:16];

    logic is_flw_mem, is_flw_wb; logic [4:0] flw_addr_mem, flw_addr_wb;
    always_ff @(posedge clk) begin
        if (!rst) begin is_flw_mem <= 1'b0; is_flw_wb <= 1'b0; flw_addr_mem <= 5'd0; flw_addr_wb <= 5'd0; end 
        else begin
            if (!stall_ex_mem) begin is_flw_mem <= is_flw_ex; flw_addr_mem <= flw_addr_ex; end
            if (!stall_mem_wb) begin is_flw_wb <= is_flw_mem; flw_addr_wb <= flw_addr_mem; end
        end
    end

    wire is_fsw_id   = (instruction_id[31:26] == 6'h39);
    wire is_fmt_s_id = is_cop1_id && (instruction_id[25:21] == 5'd16);
    wire is_mfc1_id  = is_cop1_id && (instruction_id[25:21] == 5'd00);

    wire id_reads_fpu_fs = is_fmt_s_id || is_mfc1_id; 
    wire id_reads_fpu_ft = is_fmt_s_id || is_fsw_id;  
    
    wire [4:0] id_fs_addr = instruction_id[15:11]; wire [4:0] id_ft_addr = instruction_id[20:16];
    wire fpu_hazard_ex = is_flw_ex && ((id_reads_fpu_fs && (flw_addr_ex == id_fs_addr)) || (id_reads_fpu_ft && (flw_addr_ex == id_ft_addr)));
    wire fpu_hazard_mem = is_flw_mem && ((id_reads_fpu_fs && (flw_addr_mem == id_fs_addr)) || (id_reads_fpu_ft && (flw_addr_mem == id_ft_addr)));
    assign fpu_load_use_stall = fpu_hazard_ex || fpu_hazard_mem;

    wire        fpu_ext_we    = is_mtc1_ex || is_flw_wb;
    wire [4:0]  fpu_ext_waddr = is_flw_wb ? flw_addr_wb : instruction_ex[15:11];
    wire [31:0] fpu_ext_wdata = is_flw_wb ? Mem_ReadData_wb : alu_input_b_mux_out;
    
    wire [31:0] fpu_arith_result;

    FPU_Top fpu_unit (
        .clk(clk), .rst_n(rst),
        .instruction_ex(instruction_ex),
        .cpu_rdata1_ex(alu_input_a_ex), 
        .cpu_rdata2_ex(ReadData2_ex),
        .ext_we(fpu_ext_we), .ext_waddr(fpu_ext_waddr), .ext_wdata(fpu_ext_wdata),
        .fpu_rdata_ex(fpu_rdata_ex), .fpu_wdata_ex(fpu_wdata_ex),
        .fpu_arith_result(fpu_arith_result), 
        .fpu_stall_req(stall_fpu), .fpu_flag_out(fpu_flag_ex),
        .cpu_stalled_ex(ex_stall_no_fpu) // ★これを追加してFPUに繋ぐ！
    );
    
    wire is_mfc1_ex = (instruction_ex[31:26] == 6'h11) && (instruction_ex[25:21] == 5'd00);
    wire is_ftoi_ex = (instruction_ex[31:26] == 6'h11) && (instruction_ex[25:21] == 5'd16) && (instruction_ex[5:0] == 6'h24);

    wire [31:0] final_ex_result = is_mfc1_ex ? fpu_rdata_ex : 
                                  is_ftoi_ex ? fpu_arith_result : 
                                  alu_result_ex;
    
    wire [31:0] branch_target_addr_ex = PC_Plus_4_ex + (SignExtendedImm_ex << 2);

    // 修正後（シミュレータと完全一致！）
    wire [31:0] jump_target_addr_ex = {PC_Plus_4_ex[31:28], JumpIndex_ex, 2'b00};

    wire is_bc1t = (instruction_ex[16] == 1'b1);
    wire is_bc1f = (instruction_ex[16] == 1'b0);
    wire fpu_branch_taken = BranchFP_ex && ( (is_bc1t && fpu_flag_ex) || (is_bc1f && !fpu_flag_ex) );
    wire branch_cond_ex = (BEQ_ex && zero_flag_ex) || (BNE_ex && !zero_flag_ex) || fpu_branch_taken;
    wire is_r_type_ex   = (ALUOp_ex == 3'b010);
    wire is_jr_ex       = is_r_type_ex && ( (Funct_ex == 6'b001000) || (Funct_ex == 6'b001001) );
    assign branch_taken_ex = branch_cond_ex || Jump_ex || is_jr_ex;

    wire [4:0] fd_addr_ex = instruction_ex[10:6];
    
    assign write_addr_ex = (is_ftoi_ex)         ? fd_addr_ex :
                           (RegDst_ex == 2'b10) ? 5'd31 :       
                           (RegDst_ex == 2'b01) ? rd_addr_ex :  
                                                  rt_addr_ex;   

    wire [1:0]  MemToReg_mem; wire MemRead_mem, MemWrite_mem;
    wire [31:0] ALU_Result_mem, ReadData2_mem, PC_Plus_4_mem;
    (* mark_debug = "true" *) wire        RegWrite_mem;
    (* mark_debug = "true" *) wire [4:0]  Write_Addr_mem;

    wire is_swc1_ex = (instruction_ex[31:26] == 6'h39);
    wire [31:0] store_data_ex = is_swc1_ex ? fpu_wdata_ex : alu_input_b_mux_out;
    
    PipelineRegister_EX_MEM ex_mem_reg (.clk(clk), .rst(rst), .i_stall(stall_ex_mem), .i_MemToReg(MemToReg_ex), .i_RegWrite(RegWrite_ex), .i_MemRead(MemRead_ex), .i_MemWrite(MemWrite_ex), .i_ALU_Result(final_ex_result), .i_ReadData2(store_data_ex), .i_Write_Addr(write_addr_ex), .i_PC_Plus_4(PC_Plus_4_ex), .o_MemToReg(MemToReg_mem), .o_RegWrite(RegWrite_mem), .o_MemRead(MemRead_mem), .o_MemWrite(MemWrite_mem), .o_ALU_Result(ALU_Result_mem), .o_ReadData2(ReadData2_mem), .o_Write_Addr(Write_Addr_mem), .o_PC_Plus_4(PC_Plus_4_mem));

    logic [31:0] data_addr, data_wdata; logic data_we, data_re;
    assign data_addr  = ALU_Result_mem; assign data_wdata = ReadData2_mem; assign data_we    = MemWrite_mem; assign data_re    = MemRead_mem;

    logic [31:0] inst_addr; logic inst_re;
    assign inst_addr = pc_current; assign inst_re   = (pc_current >= 32'h00040000) && rst;
    assign mem_addr = (is_mem_access) ? data_addr : (pc_current >= 32'h00040000) ? pc_current : 32'b0;
    assign mem_wdata = data_wdata;
    assign mem_we = data_we && ((data_addr >= 32'h00040000));
    assign mem_re = (data_re && (data_addr >= 32'h00040000)) || (!is_mem_access && (pc_current >= 32'h00040000));
    wire [31:0] mem_read_data_mem = mem_rdata;

    wire [1:0]  MemToReg_wb; wire [31:0] ALU_Result_wb, Mem_ReadData_wb, PC_Plus_4_wb;
    (* mark_debug = "true" *) wire        RegWrite_wb;
    (* mark_debug = "true" *) wire [4:0]  Write_Addr_wb;

    PipelineRegister_MEM_WB mem_wb_reg (.clk(clk), .rst(rst), .i_stall(stall_mem_wb), .i_MemToReg(MemToReg_mem), .i_RegWrite(RegWrite_mem), .i_ALU_Result(ALU_Result_mem), .i_Mem_ReadData(mem_read_data_mem), .i_Write_Addr(Write_Addr_mem), .i_PC_Plus_4(PC_Plus_4_mem), .o_MemToReg(MemToReg_wb), .o_RegWrite(RegWrite_wb), .o_ALU_Result(ALU_Result_wb), .o_Mem_ReadData(Mem_ReadData_wb), .o_Write_Addr(Write_Addr_wb), .o_PC_Plus_4(PC_Plus_4_wb));

    wire [31:0] write_data_wb;
    assign write_data_wb = (MemToReg_wb == 2'b10) ? PC_Plus_4_wb : (MemToReg_wb == 2'b01) ? Mem_ReadData_wb : ALU_Result_wb;   
    assign led[15]   = stall_pc; assign led[14:0] = pc_current[16:2]; 
endmodule