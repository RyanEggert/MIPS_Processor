vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work shifter.t.v
vsim -voptargs="+acc" test_shifter

add wave -position insertpoint  \
sim:/dut1/in \
sim:/dut1/out \
sim:/dut2/in \
sim:/dut2/out 

run -all
wave zoom full