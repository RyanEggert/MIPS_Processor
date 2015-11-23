vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work signextend.t.v
vsim -voptargs="+acc" test_signextend

add wave -position insertpoint  \
sim:/dut/in16 \
sim:/dut/out32 \

run -all
wave zoom full