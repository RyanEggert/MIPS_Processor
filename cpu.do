vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work cpu.t.v
vsim -voptargs="+acc" test_cpu
add wave -position insertpoint  \
sim:/dut/clk \
sim:/dut/pcin \
sim:/dut/inst_addr \
sim:/dut/instr
run 100
wave zoom full