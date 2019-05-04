transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task1 {D:/Padia/EE371 Labs/Lab4/Task1/controller.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task1 {D:/Padia/EE371 Labs/Lab4/Task1/datapath.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task1 {D:/Padia/EE371 Labs/Lab4/Task1/seg7.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task1 {D:/Padia/EE371 Labs/Lab4/Task1/clock_divider.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Task1 {D:/Padia/EE371 Labs/Lab4/Task1/DE1_SoC.sv}

