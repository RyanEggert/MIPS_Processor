vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work pc.t.v
vsim -voptargs="+acc" test_pc

add wave -position insertpoint  \
sim:/dut/clk \
sim:/dut/pcin \
sim:/dut/pcout \
sim:/dut/reset 

run 300
wave zoom full