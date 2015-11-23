vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work instructiondecode.t.v
vsim -voptargs="+acc" test_instructiondecode

run 500
