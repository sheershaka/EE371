transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Padia/labs/Lab2 {D:/Padia/labs/Lab2/ram32x4.v}
vlog -sv -work work +incdir+D:/Padia/labs/Lab2 {D:/Padia/labs/Lab2/task1.sv}

