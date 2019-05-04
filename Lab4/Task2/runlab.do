# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DE1_SoC.sv"
vlog "./victory.sv"
vlog "./centerLight.sv"
vlog "./normalLight.sv"
vlog "./tugOfWar.sv"
vlog "./DFF_2.sv"
vlog "./scoreDisplay.sv"
vlog "./lfsr.sv"
vlog "./comparator.sv"
vlog "./parking.sv"
vlog "./counter.sv"
vlog "./seg7.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
