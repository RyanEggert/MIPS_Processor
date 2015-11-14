// regfile.t.v
`include "regfile.v"
// Register File test code modified from Ryan Eggert's Homework 4 assignment.

module test_regfile();

    wire[31:0]    ReadData1;      // Data from first register read
    wire[31:0]    ReadData2;      // Data from second register read
    wire[31:0]    WriteData;      // Data to write to register
    wire[4:0]     ReadRegister1;  // Address of first register to read
    wire[4:0]     ReadRegister2;  // Address of second register to read
    wire[4:0]     WriteRegister;  // Address of register to write
    wire          RegWrite;       // Enable writing of register when High
    wire          Clk;            // Clock (Positive Edge Triggered)

    reg           begintest;      // Set High to begin testing register file
    wire          dutpassed;      // Indicates whether register file passed tests

    // Instantiate the register file being tested.  DUT = Device Under Test
    regfile DUT(
            .ReadData1(ReadData1),
            .ReadData2(ReadData2),
            .WriteData(WriteData),
            .ReadRegister1(ReadRegister1),
            .ReadRegister2(ReadRegister2),
            .WriteRegister(WriteRegister),
            .RegWrite(RegWrite),
            .Clk(Clk)
          );

    // Instantiate test bench to test the DUT
    regfiletestbench tester(
                    .begintest(begintest),
                    .endtest(endtest), 
                    .dutpassed(dutpassed),
                    .ReadData1(ReadData1),
                    .ReadData2(ReadData2),
                    .WriteData(WriteData), 
                    .ReadRegister1(ReadRegister1), 
                    .ReadRegister2(ReadRegister2),
                    .WriteRegister(WriteRegister),
                    .RegWrite(RegWrite), 
                    .Clk(Clk)
                    );

    // Test harness asserts 'begintest' for 1000 time steps, starting at time 10
    initial begin
    begintest=0;
    #10;
    begintest=1;
    #1000;
    end

    // Display test results ('dutpassed' signal) once 'endtest' goes high
    always @(posedge endtest) begin
        $display("Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("Device PASSED");
        end else begin
            $display("Device FAILED");
        end
    end

endmodule

module regfiletestbench
(
// Test bench driver signal connections
input   begintest,// Triggers start of testing
output reg endtest,// Raise once test completes
output reg dutpassed,// Signal test result

// Register File DUT connections
input[31:0]         ReadData1,
input[31:0]         ReadData2,
output reg[31:0]    WriteData,
output reg[4:0]     ReadRegister1,
output reg[4:0]     ReadRegister2,
output reg[4:0]     WriteRegister,
output reg          RegWrite,
output reg          Clk
);

    // Initialize register driver signals
    initial begin
        WriteData=32'd0;
        ReadRegister1=5'd0;
        ReadRegister2=5'd0;
        WriteRegister=5'd0;
        RegWrite=0;
        Clk=0;
    end

    // Once 'begintest' is asserted, start running test cases
    always @(posedge begintest) begin
        endtest = 0;
        dutpassed = 1;
        #10

        // Test Case 1: 
        //   Write '42' to register 2, verify with Read Ports 1 and 2
        //   (Passes because example register file is hardwired to return 42)
        $display("Test 1: testing read/write");
        WriteRegister = 5'd2;
        WriteData = 32'd42;
        RegWrite = 1;
        ReadRegister1 = 5'd2;
        ReadRegister2 = 5'd2;
        #5 Clk=1; #5 Clk=0;// Generate single clock pulse

        // Verify expectations and report test result
        if((ReadData1 != 42) || (ReadData2 != 42)) begin
            dutpassed = 0;// Set to 'false' on failure
            $display("Test Case 1 Failed");
        end

        // Test Case 2: 
        //   Write '15' to register 2, verify with Read Ports 1 and 2
        //   (Fails with example register file, but should pass with yours)
        $display("Test 2: testing read/write");
        WriteRegister = 5'd2;
        WriteData = 32'd15;
        RegWrite = 1;
        ReadRegister1 = 5'd2;
        ReadRegister2 = 5'd2;
        #5 Clk=1; #5 Clk=0;

        if((ReadData1 != 15) || (ReadData2 != 15)) begin
            dutpassed = 0;
            $display("Test Case 2 Failed");
        end

        // Test Case 3:
        //    Input '29' to register 12, but write is disabled.
        //    Try to read from register 12, should not see '29'.
        $display("Test 3: testing write enable");
        WriteRegister=5'd12;
        WriteData = 32'd29;
        RegWrite = 0;
        ReadRegister1 = 5'd12;
        ReadRegister2 = 5'd12;
        #5 Clk=1; #5 Clk=0;

        if ((ReadData1 == 29) || (ReadData2 == 29)) begin
            dutpassed = 0;
            $display("Test Case 3 Failed");
        end

        // Test Case 4:
        //    Test decoder. If decoder is broken, we will write to the improper
        //    register(s). To test, try to write '1' to register 1. If 1 is read
        //    from at least one other register, there has been a problem
        $display("Test 4: testing decoder + all registers");
        WriteRegister = 5'd1;
        WriteData = 32'd1;
        // For loops only work in SystemVerilog? Hmm?
        ReadRegister1 = 0;
        ReadRegister2 = 2;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 3;
        ReadRegister2 = 4;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 5;
        ReadRegister2 = 6;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 7;
        ReadRegister2 = 8;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 9;
        ReadRegister2 = 10;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 11;
        ReadRegister2 = 12;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 13;
        ReadRegister2 = 14;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 15;
        ReadRegister2 = 16;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 17;
        ReadRegister2 = 18;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 19;
        ReadRegister2 = 20;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 21;
        ReadRegister2 = 22;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 23;
        ReadRegister2 = 24;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 25;
        ReadRegister2 = 26;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 27;
        ReadRegister2 = 28;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 29;
        ReadRegister2 = 30;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        ReadRegister1 = 31;
        ReadRegister2 = 31;
        #5 Clk=1; #5 Clk=0; 
        if ((ReadData1==1 ) || (ReadData2==1)) begin
            dutpassed = 0;
            $display("Test Case 4 Failed");
        end

        // Test Case 5:
        //    Check the zero register. Attempt to write and read.
        //    Try to write '500' to register 0. Try to read from
        //    register 0.
        $display("Test 5: testing zero register");
        WriteRegister=5'd0;
        WriteData = 32'd500;
        RegWrite = 1;
        ReadRegister1 = 5'd0;
        ReadRegister2 = 5'd0;
        #5 Clk=1; #5 Clk=0;

        if ((ReadData1 != 0) || (ReadData2 != 0)) begin
            dutpassed = 0;
            $display("Test Case 5 Failed");
        end

        // Test Case 6:
        //    Check the read ports. Attempt to write and read.
        //    Try to write '500' to register 0. Try to read from
        //    register 0.
        $display("Test 6: testing ports");
        $display("Test 6.1: Write and confirm read to register 17");
        WriteRegister=5'd17;
        WriteData = 32'd1234;
        RegWrite = 1;
        ReadRegister1 = 5'd17;
        ReadRegister2 = 5'd17;
        #5 Clk=1; #5 Clk=0;

        if ((ReadData1 != 1234) || (ReadData2 != 1234)) begin
            dutpassed = 0;
            $display("Test Case 6.1 Failed");
        end

        $display("Test 6.2: check that other ports do not read from port 17 (e.g.)");
        WriteRegister=5'd17;
        WriteData = 32'd1334;
        RegWrite = 0;
        ReadRegister1 = 5'd7;
        ReadRegister2 = 5'd30;
        #5 Clk=1; #5 Clk=0;

        if ((ReadData1 == 1234) || (ReadData2 == 1234)) begin
            dutpassed = 0;
            $display("Test Case 6.2 Failed");
        end

        // All done!  Wait a moment and signal test completion.
        #5
        endtest = 1;
    end
endmodule