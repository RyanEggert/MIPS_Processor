vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work cpu.t.v
vsim -voptargs="+acc" test_cpu
run -all