vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work muxes.t.v
vsim -voptargs="+acc" test_muxes

add wave -position insertpoint  \
sim:/mux_32/din0 \
sim:/mux_32/din1 \
sim:/mux_32/mux_ctl \
sim:/mux_32/mux_out \
sim:/mux_5/din0 \
sim:/mux_5/din1 \
sim:/mux_5/mux_ctl \
sim:/mux_5/mux_out

run -all
wave zoom full