# ModelSim Script to Compile and Simulate Testbench

# Set the working library
vlib work
vmap work work

# Compile Design Files (Change file names accordingly)
vlog ../src/*.sv  ;# For Verilog
vlog ../test/*.sv  ;# For Verilog Testbench

# Load the Simulation
vsim -voptargs="+acc" testbench

vcd dumpports -file dump.evcd testbench/fifo/*

# Run Simulation
run -all