vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work all.t.v
vsim -voptargs="+acc" runalltests

run 30000