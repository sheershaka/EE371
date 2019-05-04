transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Padia/labs/Lab2Task4 {D:/Padia/labs/Lab2Task4/ram32x4.v}
vlog -sv -work work +incdir+D:/Padia/labs/Lab2Task4 {D:/Padia/labs/Lab2Task4/seg7.sv}
vlog -sv -work work +incdir+D:/Padia/labs/Lab2Task4 {D:/Padia/labs/Lab2Task4/hex7.sv}
vlog -sv -work work +incdir+D:/Padia/labs/Lab2Task4 {D:/Padia/labs/Lab2Task4/DE1_SoC.sv}

