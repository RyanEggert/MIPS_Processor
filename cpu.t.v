// cpu.t.v
`include "cpu.v"

module test_cpu(dutpassed);
    output reg dutpassed;

    cpu dut ();


    initial begin
        dutpassed = 1;
        #10
        $display("CPU Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("\tCPU PASSED");
        end else begin
            $display("\tCPU FAILED");
        end
    end
    
endmodule