transcript off

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}

vlib rtl_work
vmap work rtl_work


vlog -sv -work work +incdir+../src +cover {../src/*.sv}
vlog -sv -work work +incdir+../src +cover {../test/*.sv}

vsim -t 1ps -L rtl_work -L work -voptargs="+acc" -coverage testbench

view structure
view signals

do wave.do

coverage report -html -output covhtmlreport -annotate -details -assert -directive -cvg -code bcefst -verbose -threshL 50 -threshH 90