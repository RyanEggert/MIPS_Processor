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
//  MIPS ALU
//      Arithmetic Logic Unit with ADD, SUB, XOR, SLT, AND, NOR, OR
//      operations. Operations are specificed by a three-bit binary alu_ctl
//      code.  
//   
//   
//----------------------------------------------------------------------------
module MIPSALU (alu_res, zero, ovf, cout, a, b, cin, alu_ctl) ;
    input [3:0] alu_ctl;
    input [31:0] a,b;
    input cin;

    output reg [31:0] alu_res;
    output zero, ovf, cout;

    

    always @(alu_ctl, a, b, cin) begin 
        case (alu_ctl)
            `AND:   begin
                alu_res = a & b;        // AND
                cout = 0;
                ovf = 0;
            end

            `OR:    begin
                alu_res = a | b;        // OR
                cout = 0;
                ovf = 0;
            end

            `XOR:   begin
                alu_res = a ^ b;        // XOR
                cout = 0;
                ovf = 0;
            end

            `NOR: begin 
                alu_res = ~(a | b);     // NOR
                cout = 0;
                ovf = 0;
            end    

            `ADD:   begin
                {cout, alu_res} = a + b + cin;          // ADD + set carryout
                ovf = a[31] & b[31] & ~alu_res[31] 
                    | ~a[31] & ~b[31] & alu_res[31];    // Set overflow
            end

            `SUB:   begin
                {cout, alu_res} = a - b;
                ovf = a[31] & ~b[31] & alu_res[31]      // SUB + set carryout
                    | ~a[31] & b[31] & ~alu_res[31];    // Set overflow
            end

            `SLT:   begin 
                alu_res = a < b ? 1 : 0;    // SLT
                cout = 0;
                ovf = 0;
            end
            
            default: alu_res = 0;           // Something's wrong.
        endcase

        // always set zero flag
        zero = ~| alu_res; // zero is reduction NOR of ALUout

    end
endmodule

//----------------------------------------------------------------------------
//  ALU Control
//      Translates 6-bit MIPS function codes [ALUOp] from ADD, SUB, AND, OR,
//      XOR, NOR, SLT instructions to 3-bit ALU control codes. 
//   
//----------------------------------------------------------------------------
module ALUControl(ALUCtl, ALUOp);
    output [2:0] reg ALUCtl;
    input [5:0] ALUOp;
    
    always case (ALUOp)
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