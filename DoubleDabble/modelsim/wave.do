radix binary
add wave clk
add wave write


add wave -divider

add wave -radix unsigned test_data
add wave -radix unsigned test_digits

add wave -radix unsigned data
add wave -radix unsigned digits

add wave -divider

add wave -color "Magenta" done
add wave -unsigned -color "Magenta" dut/counter
add wave -color "Goldenrod" dut/data_buffer
add wave -color "Goldenrod" dut/shift_reg
add wave -color "Goldenrod" dut/add_reg

run -all;
wave zoom range 0ps 150ps