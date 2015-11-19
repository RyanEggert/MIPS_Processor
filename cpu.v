`include "components/alu.v"
`include "components/adder.v"
`include "components/control.v"
`include "components/datamemory.v"
`include "components/instructiondecode.v"
`include "components/instructionmemory.v"
`include "components/muxes.v"
`include "components/pc.v"
`include "components/regfile.v"
`include "components/shifter.v"
`include "components/signextend.v"


module cpu();
	
	reg clk;
	reg reset;
	wire [31:0] pcin, inst_addr, instr, imm32, shifted_imm32, mux_1_1;
    wire [27:0] shifter_pc_out;

    wire[5:0] decoded_opcode, decoded_funct;
    wire[4:0] decoded_rs, decoded_rt, decoded_rd, decoded_shamt;
    wire[15:0] decoded_imm16;
    wire[25:0] decoded_address;

    wire[31:0]   b;
    wire[31:0]  adder_pc_sum;
    assign b = 32'd4;

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
        .out(shifter_pc_out[27:0]),
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

    mux_2d mux0 ();


    initial clk=0;
    always #10 clk =! clk;

endmodule