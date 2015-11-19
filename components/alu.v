`include "includes/alucontrols.v" // Define ALUCtl codes [modified from Lab1]

//----------------------------------------------------------------------------
//  MIPS ALU
//      Arithmetic Logic Unit with ADD, SUB, XOR, SLT, AND, NOR, OR
//      operations. Operations are specificed by a three-bit binary alu_ctl
//      code.  
//   
//----------------------------------------------------------------------------
module MIPSALU (alu_res, zero, ovf, cout, a, b, cin, alu_ctl) ;
    input [3:0] alu_ctl;
    input [31:0] a,b;
    input cin;

    output reg [31:0] alu_res;
    output reg zero, ovf, cout;

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
                    | ~a[31] & ~b[31] & alu_res[31];    // Set overflow*
            end

            `SUB:   begin
                {cout, alu_res} = a - b;
                ovf = a[31] & ~b[31] & alu_res[31]      // SUB + set carryout
                    | ~a[31] & b[31] & ~alu_res[31];    // Set overflow*
            end

            `SLT:   begin 
                alu_res = a < b ? 1 : 0;    // SLT
                cout = 0;
                ovf = 0;
            end

            `NOOP:   begin 
                alu_res = {32{1'bz}};    // NOOP
                cout = 1'bz;
                ovf = 1'bz;
            end
            
            default: begin
                alu_res = 0;           // Something's wrong.
                $display("ERROR [@t=%0dns]: ALU default case triggered.", $time); // Print error message to console
            end
        endcase

        // always set zero flag
        zero = ~| alu_res; // zero is reduction NOR of ALUout

    end
endmodule

//----------------------------------------------------------------------------
//  ALU Control
//      Translates 6-bit MIPS function codes [alu_op] from ADD, SUB, AND, OR,
//      XOR, NOR, SLT instructions to 3-bit ALU control codes. Also translates
//      0x2C to a NOOP code.
//   
//----------------------------------------------------------------------------
module ALUControl(alu_ctl, alu_op);
    output reg[3:0]  alu_ctl;
    input [5:0] alu_op;
    
   
   always @(alu_op) begin
        case (alu_op)
            6'h20: alu_ctl <=`ADD;       // add
            6'h22: alu_ctl <=`SUB;       //subtract
            6'h24: alu_ctl <=`AND;       // and
            6'h25: alu_ctl <=`OR;        // or
            6'h26: alu_ctl <=`XOR;       // XOR
            6'h27: alu_ctl <=`NOR;       // nor
            6'h2A: alu_ctl <=`SLT;       // slt
            6'h2C: alu_ctl <= `NOOP;     // no operation
            default: alu_ctl <= `ERROR;  // should not happen
        endcase
    end
endmodule

// * ADD/SUB overflow detection inspired by
// http://www.ece.lsu.edu/ee3755/2012f/l05.v.html