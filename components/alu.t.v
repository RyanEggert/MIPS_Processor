// alu.t.v
`include "alu.v"

// Define ALUCtl codes [modified from Lab1]
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define ERROR 3'd5
`define NOR  3'd6
`define OR   3'd7

module test_alu;
    wire[31:0]    res;
    wire          cout;
    wire          zero;
    wire          ovf;
    
    reg[31:0]     opA;
    reg[31:0]     opB;
    reg[2:0]      cmd;
    reg           cin;

    MIPSALU DUT(res, zero, ovf, cout, opA, opB, cin, cmd);

    initial begin
        $display("                                    Inputs                                    |                             Expected Outputs                  |                                Outputs                        |");
        $display("command | operandA                         | operandB                         | result                           | carryout | overflow | zero | result                           | carryout | overflow | zero |");
        cin = 0;
        // Add d1 + d1
        cmd=`ADD; opA=32'b00000000000000000000000000000001; opB=32'b00000000000000000000000000000001; #5000
        $display("%b     | %b | %b | 00000000000000000000000000000010 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // Add d-1 and d1. Raise the zero flag. CARRYOUT
        cmd=`ADD; opA=32'b11111111111111111111111111111111; opB=32'b00000000000000000000000000000001; #5000
        $display("%b     | %b | %b | 00000000000000000000000000000000 | 1        | 0        | 1    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // -5 + -21474836485 = 2147483643 OVERFLOW CARRYOUT
        cmd=`ADD; opA=32'b11111111111111111111111111111011; opB=32'b10000000000000000000000000000000; #5000
        $display("%b     | %b | %b | 01111111111111111111111111111011 | 1        | 1        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // Check AND
        cmd=`AND; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
        $display("%b     | %b | %b | 00011111000001100000100000000001 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // Check OR
        cmd=`OR; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
        $display("%b     | %b | %b | 00111111111111110011111000110001 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // Check NOR
        cmd=`NOR; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
        $display("%b     | %b | %b | 11000000000000001100000111001110 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // Check XOR
        cmd=`XOR; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
        $display("%b     | %b | %b | 00100000111110010011011000110000 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // Check SUB
        cmd=`SUB; opA=32'b00000000000000000000000000000100; opB=32'b00000000000000000000000000000011; #5000
        $display("%b     | %b | %b | 00000000000000000000000000000001 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // Check SLT true
        cmd=`SLT; opA=32'b00000000000000000000000000000001; opB=32'b00000100000000000000000000000001; #5000
        $display("%b     | %b | %b | 00000000000000000000000000000001 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

        // Check SLT false
        cmd=`SLT; opA=32'b00100000000000000000000000000001; opB=32'b00000000000000000000000000000001; #5000
        $display("%b     | %b | %b | 00000000000000000000000000000000 | 0        | 0        | 1    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);
    end
endmodule