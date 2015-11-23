vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work alu.t.v
vsim -voptargs="+acc" test_alu
run -all