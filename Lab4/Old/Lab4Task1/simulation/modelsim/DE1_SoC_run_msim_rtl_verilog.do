transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Lab2Task12 {D:/Padia/EE371 Labs/Lab4/Lab2Task12/seg7.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Lab2Task12 {D:/Padia/EE371 Labs/Lab4/Lab2Task12/bitcount.sv}
vlog -sv -work work +incdir+D:/Padia/EE371\ Labs/Lab4/Lab2Task12 {D:/Padia/EE371 Labs/Lab4/Lab2Task12/DE1_SoC.sv}

