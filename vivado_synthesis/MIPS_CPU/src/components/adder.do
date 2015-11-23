vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work adder.t.v
vsim -voptargs="+acc" test_adder

run -all