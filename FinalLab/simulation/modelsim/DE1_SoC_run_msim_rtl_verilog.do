transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/clock_generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/audio_codec.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/audio_and_video_config.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/Altera_UP_SYNC_FIFO.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/Altera_UP_Slow_Clock_Generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/Altera_UP_I2C_AV_Auto_Initialize.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/Altera_UP_I2C.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/Altera_UP_Clock_Edge.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/Altera_UP_Audio_Out_Serializer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/Altera_UP_Audio_In_Deserializer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/Altera_UP_Audio_Bit_Counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/keyboard_press_driver.v}
vlog -vlog01compat -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/keyboard_inner_driver.v}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/vga.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/colors.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/seg7.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/score.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/batpos.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/ballpos.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/ballcollisions.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/soundstore.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/gamelogic.sv}
vlog -sv -work work +incdir+C:/Users/Student\ User/Desktop/Final\ Sound\ -\ Copy {C:/Users/Student User/Desktop/Final Sound - Copy/DE1_SoC.sv}

