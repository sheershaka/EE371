onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_PERIOD
add wave -noupdate /DE1_SoC_testbench/clk
add wave -noupdate /DE1_SoC_testbench/SW
add wave -noupdate /DE1_SoC_testbench/LEDR
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate /DE1_SoC_testbench/HEX1
add wave -noupdate /DE1_SoC_testbench/KEY
add wave -noupdate -divider {New Divider}
add wave -noupdate /DE1_SoC_testbench/dut/whichClock
add wave -noupdate /DE1_SoC_testbench/dut/CLOCK_50
add wave -noupdate /DE1_SoC_testbench/dut/KEY
add wave -noupdate /DE1_SoC_testbench/dut/SW
add wave -noupdate /DE1_SoC_testbench/dut/HEX0
add wave -noupdate /DE1_SoC_testbench/dut/HEX1
add wave -noupdate /DE1_SoC_testbench/dut/HEX2
add wave -noupdate /DE1_SoC_testbench/dut/HEX3
add wave -noupdate /DE1_SoC_testbench/dut/HEX4
add wave -noupdate /DE1_SoC_testbench/dut/HEX5
add wave -noupdate /DE1_SoC_testbench/dut/LEDR
add wave -noupdate /DE1_SoC_testbench/dut/A_zero
add wave -noupdate /DE1_SoC_testbench/dut/A_0
add wave -noupdate /DE1_SoC_testbench/dut/s
add wave -noupdate /DE1_SoC_testbench/dut/reset
add wave -noupdate /DE1_SoC_testbench/dut/setA
add wave -noupdate /DE1_SoC_testbench/dut/resetResult
add wave -noupdate /DE1_SoC_testbench/dut/incrResult
add wave -noupdate /DE1_SoC_testbench/dut/shiftA
add wave -noupdate /DE1_SoC_testbench/dut/done
add wave -noupdate /DE1_SoC_testbench/dut/A
add wave -noupdate /DE1_SoC_testbench/dut/count
add wave -noupdate /DE1_SoC_testbench/dut/clk
add wave -noupdate -divider {New Divider}
add wave -noupdate /DE1_SoC_testbench/dut/data/clk
add wave -noupdate /DE1_SoC_testbench/dut/data/setA
add wave -noupdate /DE1_SoC_testbench/dut/data/resetResult
add wave -noupdate /DE1_SoC_testbench/dut/data/incrResult
add wave -noupdate /DE1_SoC_testbench/dut/data/shiftA
add wave -noupdate /DE1_SoC_testbench/dut/data/A
add wave -noupdate /DE1_SoC_testbench/dut/data/count
add wave -noupdate /DE1_SoC_testbench/dut/data/A_zero
add wave -noupdate /DE1_SoC_testbench/dut/data/A_0
add wave -noupdate /DE1_SoC_testbench/dut/data/A_reg
add wave -noupdate /DE1_SoC_testbench/dut/data/counter
add wave -noupdate -divider {New Divider}
add wave -noupdate /DE1_SoC_testbench/dut/c/clk
add wave -noupdate /DE1_SoC_testbench/dut/c/s
add wave -noupdate /DE1_SoC_testbench/dut/c/reset
add wave -noupdate /DE1_SoC_testbench/dut/c/A_zero
add wave -noupdate /DE1_SoC_testbench/dut/c/A_0
add wave -noupdate /DE1_SoC_testbench/dut/c/A
add wave -noupdate /DE1_SoC_testbench/dut/c/setA
add wave -noupdate /DE1_SoC_testbench/dut/c/resetResult
add wave -noupdate /DE1_SoC_testbench/dut/c/incrResult
add wave -noupdate /DE1_SoC_testbench/dut/c/shiftA
add wave -noupdate /DE1_SoC_testbench/dut/c/done
add wave -noupdate /DE1_SoC_testbench/dut/c/ps
add wave -noupdate /DE1_SoC_testbench/dut/c/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
