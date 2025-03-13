radix unsigned
config wave -signalnamewidth 1


add wave -divider "Clock & Reset"

add wave clk
add wave reset

add wave -divider "Write"

add wave full
add wave write_request
add wave -radix hexadecimal data_in

add wave -divider "Read"

add wave empty
add wave read_request
add wave -radix hexadecimal data_out

add wave -divider "Internals"

#add wave -divider "Memory"
#add wave /fifo/memory/*

run -all;
wave zoom range 0ps 500ps