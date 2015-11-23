// pc.t.v
`include "pc.v"

module test_pc(dutpassed);
    reg clk , reset;
    reg [31:0] pcin;
    wire [31:0]  pcout;

    output reg dutpassed;

    pc dut (
        .clk(clk),
        .reset(reset),
        .pcin(pcin),
        .pcout(pcout)
        );

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
        dutpassed = 1;
        #10

        pcin = 0;
        // PC Test 1: Initial PC ?= 0
        $display("Starting PC Test 1 @time = %0dns...", $time);
        if (pcout != 0) begin
            dutpassed = 0;
            $display("PC Test 1 failed.");
        end
        #10
        
        // PC Test 2: Increment PC by four
        $display("Starting PC Test 2 @time = %0dns...", $time);
        pcin = pcout + 3'd4;
        #30
        if (pcout != 4) begin
            dutpassed = 0;
            $display("PC Test 2 failed.");
        end
        #10

        // PC Test 3: Increment PC by a bigger number
        $display("Starting PC Test 3 @time = %0dns...", $time);
        pcin = pcout + 10'd800;
        #30
        if (pcout != 10'd804) begin
            dutpassed = 0;
            $display("PC Test 3 failed.");
        end
        #10

        // PC Test 4: PC Test reset LOW
        $display("Starting PC Test 4 @time = %0dns...", $time);
        reset = 0;
        #30
        if (pcout != 10'd804) begin
            dutpassed = 0;
            $display("PC Test 4 failed.");
        end
        #10

        // PC Test 5: PC Test reset HIGH
        $display("Starting PC Test 5 @time = %0dns...", $time);
        reset = 1;
        #30
        reset = 0;
        if (pcout != 10'd0) begin
            dutpassed = 0;
            $display("PC Test 5 failed.");
        end
        #10

        $display("PC Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("\tPC PASSED");
        end else begin
            $display("\tPC FAILED");
        end
    end
    
endmodule