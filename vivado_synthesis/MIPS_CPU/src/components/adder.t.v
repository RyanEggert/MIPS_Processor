// adder.t.v
`include "adder.v"

module test_adder(dutpassed);
    reg[31:0]   a;
    reg[31:0]   b;
    wire[31:0]  sum;

    output reg dutpassed;

    adder dut (
                    .sum(sum),
                    .a(a),
                    .b(b)
                    );


    initial begin
        dutpassed = 1;
        #1

        // ADDER Test 1: Add zeroes
        $display("Starting ADDER Test 1 @time = %0dns...", $time);
        a = 32'b0;
        b = 32'b0;
        #1
        if (sum !=0) begin
            dutpassed = 0;
            $display("ADDER Test 1 failed.");
        end
        #1

        // ADDER Test 2: Add ones
        $display("Starting ADDER Test 2 @time = %0dns...", $time);
        a = 32'b1;
        b = 32'b1;
        #1
        if (sum !=2) begin
            dutpassed = 0;
            $display("ADDER Test 2 failed.");
        end
        #1

        // ADDER Test 3: Add small numbers
        $display("Starting ADDER Test 3 @time = %0dns...", $time);
        a = 32'd4;
        b = 32'd12;
        #1
        if (sum !=32'd16) begin
            dutpassed = 0;
            $display("ADDER Test 3 failed.");
        end
        #1

        // ADDER Test 4: Add big numbers
        $display("Starting ADDER Test 4 @time = %0dns...", $time);
        a = 32'd19239859;
        b = 32'd5435932;
        #1
        if (sum !=32'd24675791) begin
            dutpassed = 0;
            $display("ADDER Test 4 failed.");
        end
        #1

        #10
        $display("ADDER Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("\tADDER PASSED");
        end else begin
            $display("\tADDER FAILED");
        end
    end
    
endmodule