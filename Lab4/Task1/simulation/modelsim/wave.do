onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controller_testbench/CLOCK_PERIOD
add wave -noupdate /controller_testbench/clk
add wave -noupdate /controller_testbench/A_zero
add wave -noupdate /controller_testbench/A_0
add wave -noupdate /controller_testbench/s
add wave -noupdate /controller_testbench/reset
add wave -noupdate /controller_testbench/A
add wave -noupdate /controller_testbench/setA
add wave -noupdate /controller_testbench/resetResult
add wave -noupdate /controller_testbench/incrResult
add wave -noupdate /controller_testbench/shiftA
add wave -noupdate /controller_testbench/done
add wave -noupdate /controller_testbench/dut/clk
add wave -noupdate /controller_testbench/dut/s
add wave -noupdate /controller_testbench/dut/reset
add wave -noupdate /controller_testbench/dut/A_zero
add wave -noupdate /controller_testbench/dut/A_0
add wave -noupdate /controller_testbench/dut/A
add wave -noupdate /controller_testbench/dut/setA
add wave -noupdate /controller_testbench/dut/resetResult
add wave -noupdate /controller_testbench/dut/incrResult
add wave -noupdate /controller_testbench/dut/shiftA
add wave -noupdate /controller_testbench/dut/done
add wave -noupdate /controller_testbench/dut/ps
add wave -noupdate /controller_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1750 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 60
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
WaveRestoreZoom {0 ps} {3845 ps}
