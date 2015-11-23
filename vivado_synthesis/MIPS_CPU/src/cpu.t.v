// cpu.t.v
`include "cpu.v"

module test_cpu(dutpassed);
    output reg dutpassed;

    cpu dut ();

    initial begin
        dutpassed = 1;
    end
    
endmodule