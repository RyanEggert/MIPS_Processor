vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work cpu.t.v
vsim -voptargs="+acc" test_cpu
add wave -position insertpoint  \
sim:/dut/clk \
sim:/dut/pcin \
sim:/dut/inst_addr \
sim:/dut/instr \
sim:/dut/decoded_opcode \
sim:/dut/decoded_funct \
sim:/dut/decoded_rs \
sim:/dut/decoded_rt \
sim:/dut/decoded_rd \
sim:/dut/decoded_shamt \
sim:/dut/decoded_imm16 \
sim:/dut/decoded_address \
sim:/dut/adder_pc_sum \
sim:/dut/mux0/din0 \
sim:/dut/mux0/din1 \
sim:/dut/mux0/mux_out \
sim:/dut/mux1/din0 \
sim:/dut/mux1/din1 \
sim:/dut/mux1/mux_out \
sim:/dut/regfile_comp/ReadRegister1 \
sim:/dut/regfile_comp/ReadRegister2
run 200
wave zoom full