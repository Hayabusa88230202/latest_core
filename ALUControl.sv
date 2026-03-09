// ALUControl.sv
module ALUControl(
    input  logic [2:0] ALUOp,    // MainControllerからの指示
    input  logic [5:0] Funct,    // 命令の下位6ビット (instruction[5:0])
    output logic [3:0] ALUOut    // ALUへの最終的な4bit制御信号
);

    always_comb begin
        case(ALUOp)
            // lw (add) または sw (add), addi
            3'b000: ALUOut = 4'b0100; // ALUは「add」を実行

            // beq (sub)
            3'b001: ALUOut = 4'b0101; // ALUは「sub」を実行

            // R-type (Functフィールドを解読する)
            3'b010: begin
                case(Funct)
                    // MIPSのfunctコード -> あなたのALU.svの制御コード
                    6'b000000: ALUOut = 4'b0111; // sll
                    6'b100000: ALUOut = 4'b0100; // add
                    6'b100010: ALUOut = 4'b0101; // sub
                    6'b100100: ALUOut = 4'b0000; // and
                    6'b100101: ALUOut = 4'b0001; // or
                    6'b100110: ALUOut = 4'b0011; // xor
                    6'b100111: ALUOut = 4'b0010; // nor
                    6'b101010: ALUOut = 4'b0110; // slt
                    6'b000011: ALUOut = 4'b1101; // ★ sra 用のALU制御コードを追加
                    default:   ALUOut = 4'bxxxx; // 未定義のfunctはDon't Care
                endcase
            end
            
            // subi (sub)
            3'b011: ALUOut = 4'b0101; // ALUは「sub」を実行

            // slti (slt)
            3'b100: ALUOut = 4'b0110; // ALUは「slt」を実行

            // sgti (sgt) - 新規機能
            3'b101: ALUOut = 4'b1000; // ALUは「sgt」(新規コード)を実行
            
            3'b110: ALUOut = 4'b0001; // ORI -> OR

            3'b111: ALUOut = 4'b1001; // LUI -> LUI専用処理
            
            default: ALUOut = 4'bxxxx; // 未定義のALUOp
        endcase
    end

endmodule