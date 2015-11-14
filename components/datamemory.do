vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work datamemory.t.v
vsim -voptargs="+acc" test_datamemory
add wave -position insertpoint  \
sim:/dut/clk \
sim:/dut/data_in \
sim:/dut/address \
sim:/dut/write_en \
sim:/dut/memory \
sim:/dut/read_en \
sim:/dut/data_out \
sim:/dutpassed


run 400
wave zoom full