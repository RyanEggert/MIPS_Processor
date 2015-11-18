// shifter.t.v
`include "shifter.v"

module test_shifter(dutpassed, dut2passed);
    reg[31:0]   in;
    wire[31:0]  out;

    reg[25:0]   in_2;
    wire[27:0]  out_2;

    output reg dutpassed, dut2passed;

    shift2 dut1 (
        .in(in),
        .out(out)
    );

    shift2 #(
        .width_in(26),
        .width_out(28)) dut2 (
        .in(in_2),
        .out(out_2)
    );

    initial begin
        dutpassed = 1;
        dut2passed = 1;
        #1

        // Test 1: Test basic output
        $display("Starting Test 1 @time = %0dns...", $time);
        in = 32'd0;
        in_2 = 26'd0;
        #1
        if (out != 32'b0) begin // Note that 32'b0 == 28'b0 is true. The lengths are included for clarity
            dutpassed = 0;
            $display("Test 1 failed by dut1.");
        end
        if (out_2 != 28'b0) begin
            dutpassed = 0;
            $display("Test 1 failed by dut2.");
        end
        #1

        // Test 2: Shift something
        $display("Starting Test 2 @time = %0dns...", $time);
        in = 32'd10;
        in_2 = 26'd10;
        #1
        if (out != 32'd40) begin 
            dutpassed = 0;
            $display("Test 2 failed by dut1. [out = %b]", out);
        end
        if (out_2 != 28'd40) begin
            dut2passed = 0;
            $display("Test 2 failed by dut2. [out = %b]", out_2);
        end
        #1
        // Test 3: Shift something
        $display("Starting Test 3 @time = %0dns...", $time);
        in = 32'd4294967295;
        in_2 = 26'd67108863;
        #1
        if (out != 32'b11111111111111111111111111111100) begin 
            dutpassed = 0;
            $display("Test 3 failed by dut1. [out = %b]", out);
        end
        if (out_2 != 28'b0011111111111111111111111100) begin
            dut2passed = 0;
            $display("Test 3 failed by dut2. [out = %b]", out_2);
        end
        #1
        $display("Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("dut1 PASSED");
        end else begin
            $display("dut1 FAILED");
        end
        if (dut2passed == 1) begin
            $display("dut2 PASSED");
        end else begin
            $display("dut2 FAILED");
        end
    end
    
endmodule