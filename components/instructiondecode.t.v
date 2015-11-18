// instructiondecode.t.v
`include "instructiondecode.v"

module test_instructiondecode(dutpassed);
    reg clk;
    reg[31:0] instr;

    wire[5:0] opcode, funct;
    wire[4:0] rs, rt, rd, shamt;
    wire[15:0] imm16;
    wire[25:0] address;

    output reg dutpassed;

    instructiondecode dut (
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

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
        dutpassed = 1;
        #10

        // INSTRUCTION DECODE Test 1: Test NOP [all 0s]
        $display("Starting INSTRUCTION DECODE Test 1 @time = %0dns...", $time);
        instr = 32'b0;
        #30
        if (opcode != 0) begin
            dutpassed = 0;
            $display("INSTRUCTION DECODE Test 1 failed.");
        end
        #10

        // INSTRUCTION DECODE Test 2: Write with enable
        $display("Starting INSTRUCTION DECODE Test 2 @time = %0dns...", $time);
        instr = 32'h01782020;
        #30
        if (opcode != 0) begin
            dutpassed = 0;
            $display("INSTRUCTION DECODE Test 2.1 failed. Wrong opcode. [opcode = %h]", opcode);
        end
        instr = 32'h01782020;
        #30
        if (funct != 6'h20) begin
            dutpassed = 0;
            $display("INSTRUCTION DECODE Test 2.2 failed. Wrong function code. [functcode = %h]", funct);
        end
        #10
        
        $display("INSTRUCTION DECODE Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("\tINSTRUCTION DECODE PASSED");
        end else begin
            $display("\tINSTRUCTION DECODE FAILED");
        end
    end
    
endmodule