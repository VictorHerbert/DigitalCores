TOP_LEVEL = BarrelShift
RTL = rtl/barrel_shift.sv
TESTBENCH = testbench/testbench.sv
SRCS = $(RTL) $(TESTBENCH)
ENGINE = iverilog


ifeq ($(ENGINE), iverilog)
compilation: icarus
simulation: run_icarus
wave: wave_icarus
else ifeq ($(ENGINE), verilator)
compilation: verilate
simulation: run_verilator
wave: wave_verilator
endif

	
icarus: build/compiled_executable.vvp

build/iverilog/compiled_executable.vvp: $(SRCS)
	@mkdir -p build/iverilog
	@echo "Compiling with Iverilog...\n"
	@iverilog -g2012 -o build/iverilog/compiled_executable.vvp $(SRCS)

run_icarus: build/iverilog/compiled_executable.vvp	
	@echo "Executing Iverilog simulation...\n"
	@cd build/iverilog && vvp compiled_executable.vvp

wave_icarus: build/iverilog/waveform.vcd
	@gtkwave build/iverilog/waveform.vcd

verilate: build/verilator/obj_dir/Vbarrel_shift

build/verilator/obj_dir/Vbarrel_shift: $(RTL) $(TESTBENCH)
	@echo "Compiling with Verilator...\n"
	@verilator --binary --trace -j 0 -Wno-WIDTHTRUNC -Wno-WIDTHEXPAND -Wno-ALWCOMBORDER $(RTL) $(TESTBENCH)
	@mkdir -p build/verilator
	@mv obj_dir build/verilator

run_verilator: verilator
	@echo "Executing Verilatorsimulation...\n"
	@./build/verilator/obj_dir/Vbarrel_shift


clean:
	rm -rf build