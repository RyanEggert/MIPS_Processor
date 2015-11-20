vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work cpu.t.v
vsim -voptargs="+acc" test_cpu
add wave -position insertpoint -radix decimal \
sim:/dut/clk \
sim:/dut/PCUpdate \
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
sim:/dut/mux0/mux_ctl \
sim:/dut/mux0/mux_out \
sim:/dut/mux1/din0 \
sim:/dut/mux1/din1 \
sim:/dut/mux1/mux_ctl \
sim:/dut/mux1/mux_out \
sim:/dut/mux2/din0 \
sim:/dut/mux2/din1 \
sim:/dut/mux2/mux_ctl \
sim:/dut/mux2/mux_out \
sim:/dut/regfile_comp/ReadRegister1 \
sim:/dut/regfile_comp/ReadRegister2 \
sim:/dut/ALUOp\
sim:/dut/ALUCtrlOut\
sim:/dut/ALUCtrl/alu_ctl\
sim:/dut/alu_cpu/alu_ctl \
sim:/dut/alu_cpu/a \
sim:/dut/alu_cpu/b \
sim:/dut/alu_cpu/alu_res \
sim:/dut/alu_cpu/zero \
sim:/dut/ALUSrc \
sim:/dut/decoded_rs \
sim:/dut/ReadData1 \
sim:/dut/decoded_rt \
sim:/dut/ReadData2 \
sim:/dut/RegWrite \
sim:/dut/SelectedWriteRegister2 \
sim:/dut/SelectedWriteData \
sim:/test_cpu/dut/mux3/din0 \
sim:/test_cpu/dut/mux3/din1 \
sim:/test_cpu/dut/mux3/mux_ctl \
sim:/test_cpu/dut/mux3/mux_out \
sim:/test_cpu/dut/mux4/din0 \
sim:/test_cpu/dut/mux4/din1 \
sim:/test_cpu/dut/mux4/mux_ctl \
sim:/test_cpu/dut/mux4/mux_out   \
sim:/test_cpu/dut/imm_signextend/out32 \
sim:/test_cpu/dut/mux5/din0 \
sim:/test_cpu/dut/mux5/din1 \
sim:/test_cpu/dut/mux5/mux_ctl \
sim:/test_cpu/dut/mux5/mux_out  \
sim:/test_cpu/dut/mux6/din0 \
sim:/test_cpu/dut/mux6/din1 \
sim:/test_cpu/dut/mux6/mux_ctl \
sim:/test_cpu/dut/mux6/mux_out  \
sim:/test_cpu/dut/mux7/din0 \
sim:/test_cpu/dut/mux7/din1 \
sim:/test_cpu/dut/mux7/mux_ctl \
sim:/test_cpu/dut/mux7/mux_out  \
sim:/test_cpu/dut/instruction_memory/address  \
sim:/test_cpu/dut/instruction_memory/shiftedadd  \
sim:/test_cpu/dut/instruction_memory/mem

run -all
wave zoom full