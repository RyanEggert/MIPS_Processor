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
	
	reg clk;
	reg rest;
	reg [31:0] pcin, instr;

    pc pc_comp (
        .clk(clk),
        .reset(reset),
        .pcin(pcin),
        .pcout(instr)
        );


    reg[5:0] opcode, funct;
    reg[4:0] rs, rt, rd, shamt;
    reg[15:0] imm16;
    reg[25:0] address;


    instructiondecode instructiondecode_comp (
        .opcode(opcode),
        .funct(funct),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .imm16(imm16),
        .address(address),
        .clk(clk),
        .instr(instr)
        );
        reg[31:0]   a;
    reg[31:0]   b;
    wire[31:0]  sum;
     assign b = 32'd4;

    adder adder (
        .sum(sum),
        .a(a),
        .b(b)
        );


    initial clk=0;
    always #10 clk =! clk;
    initial begin

    assign b = 32'd4;
    




endmodule