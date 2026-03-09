# MIPS_CPU.xdc
# -----------------------------------------------------------------
# 1. クロック信号 (20MHz = 50ns 周期)
# -----------------------------------------------------------------
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
# ★修正★: 周期を 10.00 ns (100MHz) に変更し、タイミング違反を解消
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# -----------------------------------------------------------------
# 2. リセット信号 (CPU_RESETボタン - アクティブロー)
# -----------------------------------------------------------------
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports rst]

# -----------------------------------------------------------------
# 3. LED (16個すべてを定義)
# -----------------------------------------------------------------
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {led[3]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {led[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {led[5]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {led[6]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {led[7]}]
# ★追加★: led[8] から led[15] までのピンを定義し、浮遊状態を防ぐ
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {led[8]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {led[9]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {led[10]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {led[11]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {led[12]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {led[13]}]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {led[14]}]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {led[15]}]

## USB UART Interface
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {uart_rx_i}]; # Rx
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports {uart_tx_o}]; # Tx
set_false_path -from  [get_ports {uart_rx_i}]; # Rx
set_false_path -to  [get_ports {uart_tx_o}]; # Tx