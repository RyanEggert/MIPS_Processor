// signextend.t.v
`include "signextend.v"

module test_signextend(dutpassed);
    reg[15:0]   in;
    wire[31:0]  out;

    output reg dutpassed;

    signextend dut (
                    .in16(in),
                    .out32(out)
                    );


    initial begin
        dutpassed = 1;
        #1

        // SIGN EXTEND Test 1: Sign extend zeroes
        $display("Starting SIGN EXTEND Test 1 @time = %0dns...", $time);
        in = 16'b0;
        #1
        if (out !=0) begin
            dutpassed = 0;
            $display("SIGN EXTEND Test 1 failed.");
        end
        #1

        // SIGN EXTEND Test 2: SIgn extend ones
        $display("Starting SIGN EXTEND Test 2 @time = %0dns...", $time);
        in = 16'd65535;
        #1
        if (out !=32'd4294967295) begin
            dutpassed = 0;
            $display("SIGN EXTEND Test 2 failed.");
        end
        #1

        #10
        $display("SIGN EXTEND Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("\tSIGN EXTEND PASSED");
        end else begin
            $display("\tSIGN EXTEND FAILED");
        end
    end
    
endmodule