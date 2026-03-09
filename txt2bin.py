import sys
import struct

def convert_txt_to_bin(input_file, output_file):
    with open(input_file, 'r') as f_in, open(output_file, 'wb') as f_out:
        for line in f_in:
            line = line.strip()
            if not line:
                continue
            
            # 文字列が 0 と 1 だけで構成されている場合 (2進数)
            if all(c in '01' for c in line) and len(line) == 32:
                val = int(line, 2)
            # 16進数表記 (例: 08100018) の場合
            else:
                val = int(line, 16)
            
            # server.py とブートローダの仕様 (リトルエンディアン) に合わせてパッキング
            f_out.write(struct.pack('<I', val))

    print(f"Success! Converted: {input_file} -> {output_file}")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python txt2bin.py <input.txt> <output.bin>")
        sys.exit(1)
    convert_txt_to_bin(sys.argv[1], sys.argv[2])