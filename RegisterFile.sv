// RegisterFile.sv
module RegisterFile (
    input  logic        clk,         // クロック
    input  logic        rst,         // リセット信号
    input  logic [4:0]  ReadAddr1,   // 読み出しアドレス1 (5ビットで32本を指定)
    input  logic [4:0]  ReadAddr2,   // 読み出しアドレス2
    input  logic        RegWrite,    // 書き込み許可信号 (1の時だけ書き込む)
    input  logic [4:0]  WriteAddr,   // 書き込みアドレス
    input  logic [31:0] WriteData,   // 書き込みデータ
    output logic [31:0] ReadData1,   // 読み出しデータ1
    output logic [31:0] ReadData2    // 読み出しデータ2
);
    logic [31:0] registers[31:0]; // 32本の32ビットレジスタ本体
    
    // 同期書き込みロジック
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // --- リセット時の初期化 (MIPS標準メモリマップ準拠) ---
            for (int i = 0; i < 32; i++) begin
                if (i == 29) begin
                    // $sp (29): Stack Pointer
                    // ※実装する物理メモリが小さい場合は 0x00000400 などに適宜変更してください
                    registers[i] <= 32'h06FFFFFC; 
                end else if (i == 28) begin
                    // $gp (28): Global Pointer
                    // データセグメント (0x01000000) へのアクセスのため
                    registers[i] <= 32'h01008000;
                end else begin
                    // $0 を含む他のレジスタは 0
                    registers[i] <= 32'b0;
                end
            end
        end else begin
            // --- 通常書き込み ($0以外) ---
            if (RegWrite && WriteAddr != 5'b0) begin
                registers[WriteAddr] <= WriteData;
            end
        end
    end
    
    // =========================================================
    // 非同期読み出しロジック (内部フォワーディング追加版)
    // =========================================================
    // ReadAddrが0の時は常に0を出力。
    // それ以外で、もし「書き込み有効(RegWrite=1)」かつ「読み出し先と書き込み先が同じ」なら、
    // レジスタに保存される前の最新データ(WriteData)を即座にバイパスして出力する！
    
    assign ReadData1 = (ReadAddr1 == 5'b0) ? 32'b0 : 
                       (RegWrite && (ReadAddr1 == WriteAddr)) ? WriteData : 
                       registers[ReadAddr1];

    assign ReadData2 = (ReadAddr2 == 5'b0) ? 32'b0 : 
                       (RegWrite && (ReadAddr2 == WriteAddr)) ? WriteData : 
                       registers[ReadAddr2];

        // 非同期読み出しロジック

   // assign ReadData1 = (ReadAddr1 == 5'b0) ? 32'b0 : registers[ReadAddr1];

    //assign ReadData2 = (ReadAddr2 == 5'b0) ? 32'b0 : registers[ReadAddr2];

endmodule