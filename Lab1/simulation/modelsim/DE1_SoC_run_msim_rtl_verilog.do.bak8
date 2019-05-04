transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/labs/Lab1 {D:/labs/Lab1/display.sv}
vlog -sv -work work +incdir+D:/labs/Lab1 {D:/labs/Lab1/FSM.sv}
vlog -sv -work work +incdir+D:/labs/Lab1 {D:/labs/Lab1/up_counter.sv}
vlog -sv -work work +incdir+D:/labs/Lab1 {D:/labs/Lab1/DE1_SoC.sv}

