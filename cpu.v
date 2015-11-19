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
	reg reset;
	wire [31:0] pcin, instr;

    wire[5:0] opcode, funct;
    wire[4:0] rs, rt, rd, shamt;
    wire[15:0] imm16;
    wire[25:0] address;

    wire[31:0]   b;
    wire[31:0]  sum;
    assign b = 32'd4;

    pc pc_comp (
        .clk(clk),
        .reset(reset),
        .pcin(pcin),
        .pcout(instr)
        );

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

    adder adder_pc (
        .sum(sum),
        .a(instr),
        .b(b)
        );


    initial clk=0;
    always #10 clk =! clk;

endmodule