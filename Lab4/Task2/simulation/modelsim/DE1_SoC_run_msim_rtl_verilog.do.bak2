transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task2 {D:/Padia/EE371 Labs/Lab4/Task2/ram32x8.v}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task2 {D:/Padia/EE371 Labs/Lab4/Task2/seg7.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task2 {D:/Padia/EE371 Labs/Lab4/Task2/clock_divider.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task2 {D:/Padia/EE371 Labs/Lab4/Task2/controller.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task2 {D:/Padia/EE371 Labs/Lab4/Task2/datapath.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task2 {D:/Padia/EE371 Labs/Lab4/Task2/DE1_SoC.sv}

