vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work control.t.v
vsim -voptargs="+acc" test_control
run 3000