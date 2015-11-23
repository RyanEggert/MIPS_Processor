// datamemory.t.v
`include "datamemory.v"

module test_datamemory(dutpassed);
    reg           clk;
    reg[31:0]     address;
    reg           write_en;
    reg           read_en;
    reg[31:0]     data_in;
    wire[31:0]    data_out;

    output reg dutpassed;

    datamemory dut (
                    .clk(clk),
                    .address(address),
                    .write_en(write_en),
                    .read_en(read_en),
                    .data_in(data_in),
                    .data_out(data_out)
                    );

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
        dutpassed = 1;
        #10

        // DATA MEMORY Test 1: Write w/o enable
        $display("Starting DATA MEMORY Test 1 @time = %0dns...", $time);
        data_in = 32'd884848;
        address = 32'b0;
        #30
        if (test_datamemory.dut.memory[address] != 0) begin
            dutpassed = 0;
            $display("DATA MEMORY Test 1 failed.");
        end
        #10

        // DATA MEMORY Test 2: Write with enable
        $display("Starting DATA MEMORY Test 2 @time = %0dns...", $time);
        write_en = 1;
        address = 32'b0;
        #30
        if (test_datamemory.dut.memory[address] == 0) begin
            dutpassed = 0;
            $display("DATA MEMORY Test 2 failed.");
        end
        #10
        
        // DATA MEMORY Test 3: Read w/o enable
        $display("Starting DATA MEMORY Test 3 @time = %0dns...", $time);
        write_en = 0;
        address = 32'b0;
        read_en = 0;
        #30
        if (data_out != 32'bz) begin
            dutpassed = 0;
            $display("DATA MEMORY Test 3 failed. [data_out = %b]", data_out);
        end
        #10

        // DATA MEMORY Test 4: Read with enable
        $display("Starting DATA MEMORY Test 4 @time = %0dns...", $time);
        write_en = 0;
        address = 32'b0;
        read_en = 1;
        #30
        if (data_out == 32'bz) begin
            dutpassed = 0;
            $display("DATA MEMORY Test 4 failed. [data_out = %b]", data_out);
        end
        #10

        $display("DATA MEMORY Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("\tDATA MEMORY PASSED");
        end else begin
            $display("\tDATA MEMORY FAILED");
        end
    end
    
endmodule