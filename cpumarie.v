`include "components/alu.v"
`include "components/adder.v"
`include "components/control.v"
`include "components/datamemory.v"
`include "components/instructiondecode.v"
`include "components/muxes.v"
`include "components/pc.v"
`include "components/regfile.v"
`include "components/shifter.v"
`include "components/signextend.v"


module cpu();

//pc out	+ others
    reg clk;
    reg reset;
    wire [31:0] pcin, inst_addr, instr, imm32, shifted_imm32, mux_1_1;
    wire [27:0] shifter_pc_out;

//instruction out 
    wire[5:0] decoded_opcode, decoded_funct;
    wire[4:0] decoded_rs, decoded_rt, decoded_rd, decoded_shamt;
    wire[15:0] decoded_imm16;
    wire[25:0] decoded_address;

//adder out
    wire[31:0]   b;
    wire[31:0]  sum;
    assign b = 32'd4;

//regfile out
    wire[31:0] ReadData1, ReadData2;

//mux5
    wire[31:0] mux5out;

//alu
    wire[31:0] ALUres;
    wire zero;

//datamemory
    wire[31:0] DataMemOut;

//mux6
    wire[31:0] mux6out;

//ALUCtrl
    wire[3:0] ALUCtrlOut;

    pc pc_comp (
        .clk(clk),
        .reset(reset),
        .pcin(pcin),
        .pcout(inst_addr)
        );

    memory instruction_memory (
        .clk(clk),
        .address(inst_addr),
        .data_out(instr)
        );

    instructiondecode instructiondecode_comp (
        .opcode(decoded_opcode),
        .funct(decoded_funct),
        .rs(decoded_rs),
        .rt(decoded_rt),
        .rd(decoded_rd),
        .shamt(decoded_shamt),
        .imm16(decoded_imm16),
        .address(decoded_address),
        .clk(clk),
        .instr(instr)
        );

    adder adder_pc (
        .sum(adder_pc_sum),
        .a(instr),
        .b(b)
        );

    adder adder_alures (
        .sum(mux_1_1),
        .a(adder_pc_sum),
        .b(shifted_imm32)
        );

    shift2 #(.width_in(26), .width_out(28)) shifter_pc  (
        .out(shifter_pc_out),
        .in(decoded_address)
        );

    shift2 #(.width_in(32), .width_out(32)) shifter_imm  (
        .out(shifted_imm32),
        .in(imm32)
        );

    signextend imm_signextend (
        .out32(imm32),
        .in16(decoded_imm16)
        );

    mux_2d mux0 (
	.mux_ctl(), //Control
	.din0({adder_pc_sum[31,28], shifter_pc_out}),
	.din1(ReadData1),
	.mux_out(mux0out)
	);

    mux_2d mux1 (
	.mux_ctl(), //And Gate
	.din0(adder_pc_sum),
	.din1(mux_1_1),
	.mux_out(mux1out)
	);

    mux_2d mux2 (
	.mux_ctl(), //Control
	.din0(mux1out),
	.din1(mux0out),
	.mux_out(mux2out)
	);

    mux_2d mux7 (
	.mux_ctl(), //Control
	.din0(mux1out),
	.din1(mux0out),
	.mux_out(mux2out)
	);


    initial clk=0;
    always #10 clk =! clk;


    regfile regfile (
	.ReadData1(ReadData1),
	.ReadData2(ReadData2),
	.WriteData(),
	.ReadRegister1(decoded_rs),
	.ReadRegister2(decoded_rt),
	.WriteRegister(),
	.RegWrite(),
	.Clk(clk)
	);

    mux_2d mux5 (
	.mux_ctl(),
	.din0(ReadData2),
	.din1(imm32),
	.mux_out(mux5out)
	);

    MIPSALU alu_cpu (
	.alu_ctl(), //from ALU Control
	.a(ReadData1),
	.b(mux5out),
	.cin(), //none?
	.alu_res(ALUres),
	.zero(ALUzero),
	.ovf(), //none?
	.cout() //none?
	);

    datamemory datamemory_cpu (
	.clk(clk),
	.address(ALUres),
	.data_out(DataMemOut),
	.write_en(), //Control
	.read_en(), //Control
	.data_in(ReadData2)
	);

    mux_2d mux6 (
	.mux_ctl(), //Control
	.din0(ALUres),
	.din1(DataMemOut),
	.mux_out(mux6out)
	);

    ALUControl ALUCtrl (
	.alu_ctl(ALUCtrlOut) //4
	.alu_op() //6

    

endmodule