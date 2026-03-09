// InstructionMemory.sv (LUTRAM対応版)
`timescale 1ns / 1ps

module InstructionMemory_readmemh (
    input  logic        clk,
    input  logic [31:0] ReadAddress,
    output logic [31:0] Instruction,
    
    // ★追加: 書き込み用ポート
    input  logic        write_enable,
    input  logic [31:0] write_address,
    input  logic [31:0] write_data
);
    // メモリサイズ定数 (256ワード)
    localparam MEM_DEPTH = 256;

    // ★追加: VivadoにLUTRAM(分散RAM)として推論させるための明示的属性
    (* ram_style = "distributed" *)
    logic [31:0] mem[MEM_DEPTH-1:0];

    initial begin
        $readmemh("C:/Users/hayab/CPU_EXPERIMENT/CPU_CORE_SINGLE_PIPELINE_cashe/program.hex", mem);
    end

    // ----------------------------------------------------------------
    // ★追加: 書き込みロジック (同期)
    // ----------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (write_enable) begin
            // ReadAddressと同様に、下位ビット [9:2] をインデックスとして使用
            mem[write_address[9:2]] <= write_data;
        end
    end

    // ----------------------------------------------------------------
    // 読み出しロジック (非同期)
    // ----------------------------------------------------------------
    // アドレスの下位ビット [9:2] を使用
    // 0x00400000 (MIPS Text) -> 0x00 (Physical) にマッピングされる
    // ※ assignによる非同期読み出しを維持することで、BRAMではなくLUTRAMに推論されます
    assign Instruction = mem[ReadAddress[9:2]];

endmodule
