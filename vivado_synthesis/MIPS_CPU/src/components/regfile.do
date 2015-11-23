vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work regfile.t.v
vsim -voptargs="+acc" test_regfile
run -all