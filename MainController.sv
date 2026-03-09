// MainController.sv
module MainController(
    input  logic [5:0] Opcode,       // 命令の上�?6ビッ�? (instruction[31:26])
    input  logic [5:0] Funct,        // instruction[5:0] JR/JALR判定用
    input  logic [4:0] Rs, // �?追�?: instruction[25:21] (fmt/rs)

    // --- 出力される制御信号 ---
    output logic [1:0] RegDst,       // 01: R-type(rdへ), 00: lw(rtへ), 10: $ra
    output logic       ALUSrc,       // 1: 即値, 0: レジスタ(ReadData2)
    output logic [1:0] MemToReg,     // 01: メモリから, 00: ALUから, 10: PC + 4
    output logic       RegWrite,     // 1: レジスタ書き込み許可
    output logic       MemRead,      // 1: �?ータメモリ読み出し許可
    output logic       MemWrite,     // 1: �?ータメモリ書き込み許可
    output logic       Beq,          // 1: �?岐命令(beq)
    output logic       Bne,          // 1: �?岐命令(bne)
    output logic       Jump,         // jump, jump & link
    output logic       ExtOp,        // �?追�?: 1=符号拡張(addi�?), 0=ゼロ拡張(ori�?)
    output logic [2:0] ALUOp,         // ALU制御�?置への�?示 (000:add, 001:sub, 010:R-type, ...)
    output logic       BranchFP      // �?追�?: FPU�?�? (bc1t/bc1f)
);

    // �?み合わせ回路で実�?
    always_comb begin
        // --- まず�?��?�信号�?0 (安�?�な値) に初期�? ---
        RegDst   = 2'b00;
        ALUSrc   = 1'b0;
        MemToReg = 2'b00;
        RegWrite = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        Beq      = 1'b0; 
        Bne      = 1'b0;
        Jump     = 1'b0;
        ExtOp    = 1'b1;
        ALUOp    = 3'b000; // �?フォルト�?��?�?(lw/sw/addi用)
        BranchFP = 1'b0; // �?追�?

        // Opcodeの値で処�?を�?�?
        case(Opcode)
            6'b000000: begin // R-type (add, sub, and, or, slt, jump reg, ...)
                case(Funct)
                    6'b001000: begin // JR (Op:00, Fn:08)
                        // 書き込みなし�?�PCはEXス�?ージで制御
                        RegWrite = 1'b0;
                        ALUOp    = 3'b010; // R-type扱�?
                    end

                    6'b001001: begin // JALR (Op:00, Fn:09)
                        RegDst   = 2'b01; // rd に書き込�?
                        RegWrite = 1'b1;
                        MemToReg = 2'b10; // PC + 4 を書き込�?
                        ALUOp    = 3'b010; // R-type扱�?
                    end

                    default: begin // add, sub, slt, etc.
                        RegDst   = 2'b01;
                        RegWrite = 1'b1;
                        ALUOp    = 3'b010; 
                    end
                endcase
            end
            
            6'b001000: begin // addi (�?追�?)
                ALUSrc   = 1'b1;  // ALUのB入力�?�即値
                RegWrite = 1'b1;  // 書き込みを行う
                RegDst   = 2'b00;  // 書き込み先�?� rt
                MemToReg = 2'b00; // ALUの結果を書き込�?
                ALUOp    = 3'b000; // ALUは「add」を実�?
            end

            6'b001001: begin // subi (�?追�?)
                ALUSrc   = 1'b1;  // ALUのB入力�?�即値
                RegWrite = 1'b1;  // 書き込みを行う
                RegDst   = 2'b00;  // 書き込み先�?� rt
                MemToReg = 2'b00; // ALUの結果を書き込�?
                ALUOp    = 3'b011; // ALUは「sub」を実�?
            end
            
            6'b001010: begin // slti (Opcode: 0x0A)
                ALUSrc   = 1'b1;  // ALUのB入力�?�即値
                RegWrite = 1'b1;  // 書き込みを行う
                RegDst   = 2'b00;  // 書き込み先�?� rt
                MemToReg = 2'b00; // ALUの結果を書き込�?
                ALUOp    = 3'b100; // ALUは「slt」を実�? (ALUControlへ新規定義)
            end

            6'b001011: begin // sgti (Opcode: 0x0B)
                ALUSrc   = 1'b1;  // ALUのB入力�?�即値
                RegWrite = 1'b1;  // 書き込みを行う
                RegDst   = 2'b00;  // 書き込み先�?� rt
                MemToReg = 2'b00; // ALUの結果を書き込�?
                ALUOp    = 3'b101; // ALUは「sgt」を実�? (ALUControlへ新規定義)
            end

            6'b001101: begin // ORI (Opcode 0x0D)
                ALUSrc   = 1'b1;
                RegWrite = 1'b1;
                RegDst   = 2'b00; // rt
                ExtOp    = 1'b0;  // �?ゼロ拡張
                ALUOp    = 3'b110; // ALUControlへ新規コー�?(OR)
            end

            6'b001111: begin // LUI (Opcode 0x0F)
                ALUSrc   = 1'b1;
                RegWrite = 1'b1;
                RegDst   = 2'b00; // rt
                ALUOp    = 3'b111; // ALUControlへ新規コー�?(LUI)
            end

            6'b100011: begin // lw (ロードワー�?)
                ALUSrc   = 1'b1;  // ALUのB入力�?�即値
                MemToReg = 2'b01;  // メモリから読んだ値をレジスタへ
                RegWrite = 1'b1;  // 書き込みを行う
                MemRead  = 1'b1;  // メモリを読�?
                ALUOp    = 3'b000; // ALUはアドレス計�?(�?�?)
                RegDst   = 2'b00; // 書き込み先�?� rt
            end

            6'b101011: begin // sw (ストアワー�?)
                ALUSrc   = 1'b1;  // ALUのB入力�?�即値
                MemWrite = 1'b1;  // メモリに書き込�?
                ALUOp    = 3'b000; // ALUはアドレス計�?(�?�?)
            end

            6'b000100: begin // beq (�?�?)
                Beq = 1'b1;  // �?岐す�? (PCのMUXで使�?)
                ALUOp  = 3'b001; // ALUは比�?(減�?)
                RegDst = 2'b00;
            end

            6'b000101: begin // bne (�?�?)
                Bne    = 1'b1;  // �?岐す�? (PCのMUXで使�?)
                ALUOp  = 3'b001; // ALUは比�?(減�?)
                RegDst  = 2'b00;
            end
            
            6'b000010: begin // jump
                Jump   = 1'b1;
            end

            6'b000011: begin // jump & link
                Jump     = 1'b1;
                RegWrite = 1'b1;  // $ra に書き込�?
                RegDst   = 2'b10; // 書き込み先�?� $ra (31)
                MemToReg = 2'b10; // PC + 4 を書き込�?
            end
            
            // �?ここに追�?: COP1 (FPU) 命令の判�?
           /* 6'b010001: begin 
                // Rs (instruction[25:21]) �? 8 (01000) な�? BC1 (Branch Coprocessor 1)
                if (Rs == 5'd08) begin
                    BranchFP = 1'b1;
                end */
            6'b010001: begin // COP1 (FPU) 命令の判定
                // Rs (instruction[25:21]) が 8 (01000) なら BC1
                if (Rs == 5'd08) begin
                    BranchFP = 1'b1;
                end 
                // Rs が 0 (00000) なら mfc1 (FPUから汎用レジスタへの書き戻し)
                else if (Rs == 5'd00) begin
                    RegWrite = 1'b1;  // 汎用レジスタに書き込む
                    RegDst   = 2'b00; // rt レジスタへ書き込む
                end
                // mtc1 や fadd などのFPU演算は汎用レジスタに書き込まないのでデフォルト(RegWrite=0)でOK
            end

                // そ�?�他�?�FPU命令(add.sなど)はCPU側では何もしな�?(NOP扱�?)のでBranchFPは0のまま
            6'b110001: begin // flw (Opcode 0x31)
                ALUSrc   = 1'b1;   // アドレス計算に即値を使用
                MemRead  = 1'b1;   // メモリから読み出す
                RegWrite = 1'b0;   // ★超重要: FPUに書くので汎用レジスタ(GPR)への書き込みは0！
                ALUOp    = 3'b000; // アドレス計算のための足し算
            end

            6'b111001: begin // fsw (Opcode 0x39)
                ALUSrc   = 1'b1;   // アドレス計算に即値を使用
                MemWrite = 1'b1;   // メモリに書き込む
                RegWrite = 1'b0;
                ALUOp    = 3'b000; // アドレス計算のための足し算
            end

            // default: begin
            //  (他�?�命令もここに追�?できます�?�addi, j など)
            // end
        endcase
    end


endmodule