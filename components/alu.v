// Define ALUCtl codes [modified from Lab1]
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define ERROR 3'd5
`define NOR  3'd6
`define OR   3'd7
// Note that NAND from Lab1 has been replaced with an ERROR designation. 
// This is because there is no NAND function code in the MIPS ISA.

//----------------------------------------------------------------------------
// MIPS ALU
//   Translates 6-bit function codes from ADD, SUB, AND, OR, XOR, NOR, SLT
//   instructions to 3-bit ALU control codes. 
//   
//----------------------------------------------------------------------------
module MIPSALU (ALUctl, A, B, ALUOut, Zero);
    input [3:0] ALUctl;
    input [31:0] A,B;
    output reg [31:0] ALUOut;
    output Zero;
    assign Zero = (ALUOut==0); //Zero is true if ALUOut is 0
    always @(ALUctl, A, B) begin //reevaluate if these change
    case (ALUctl)
        `AND: ALUOut <= A & B;          // AND
        `OR: ALUOut <= A | B;           // OR
        `XOR: ALUOut <= A ^ B;          // XOR
        `ADD: ALUOut <= A + B;          // ADD
        `SUB: ALUOut <= A - B;          // SUB
        `SLT: ALUOut <= A < B ? 1 : 0;  // SLT
        `NOR: ALUOut <= ~(A | B);       // NOR
        default: ALUOut <= 0;           // Something's wrong.
    endcase
    end
endmodule

//----------------------------------------------------------------------------
// ALU Control
//   Translates 6-bit function codes from ADD, SUB, AND, OR, XOR, NOR, SLT
//   instructions to 3-bit ALU control codes. 
//   
//----------------------------------------------------------------------------
module ALUControl(ALUCtl, FuncCode);
    output [2:0] reg ALUCtl;
    input [5:0] FuncCode;
    
    always case (FuncCode)
        6'h20: ALUCtl <=`ADD;       // add
        6'h22: ALUCtl <=`SUB;       //subtract
        6'h24: ALUCtl <=`AND;       // and
        6'h25: ALUCtl <=`OR;        // or
        6'h26: ALUCtl <=`XOR;       // XOR
        6'h27: ALUCtl <=`NOR;       // nor
        6'h2A: ALUCtl <=`SLT;       // slt
        default: ALUCtl <= `ERROR;  // should not happen
    endcase
endmodule