`include "control.v"

module test_control(dutpassed);
	reg clk;
    reg[5:0] opcode, funct;

    wire Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JumpSel, WriDataSel;
    wire[1:0] RegDst;
    wire[5:0] ALUOp;

Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JumpSel, RegDst, WriDataSel, ALUOp, opcode, funct, clk
    output reg dutpassed;
    control dut (
                .Jump(Jump),
                .Branch(Branch),
		        .MemRead(MemRead),
                .MemtoReg(MemtoReg),
                .MemWrite(MemWrite),
                .ALUSrc(ALUSrc),
                .RegWrite(RegWrite),
                .JumpSel(JumpSel),
                .RegDst(RegDst),
                .WriDataSel(WriDataSel),
                .ALUOp(ALUOp),
                .opcode(opcode),
                .funct(funct),
                .clk(clk)
                );


    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		$display("0	0	0	1	1	32	0	1	1	1	x")
		$disply("%b	%b	ALUOp: %b",Jump , Branch,ALUOp);

		funct = 6'b001100;
		#20

		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		$display("0	0	0	1	1	32	0	1	1	1	x")
		$disply("%b	%b	ALUOp: %b",Jump , Branch,ALUOp);
	
	end
endmodule


