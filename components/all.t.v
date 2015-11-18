`include "alu.t.v"
`include "adder.t.v"
`include "datamemory.t.v"
`include "instructiondecode.t.v"
`include "muxes.t.v"
`include "pc.t.v"
`include "regfile.t.v"
`include "shifter.t.v"
`include "signextend.t.v"

module runalltests();
    wire[9:0] dutspassed;
    // initialize_wire wire_inits (dutspassed);
    // assign dutspassed = {32{1'b1}};
    test_adder tests0 (dutspassed[0]);
    test_datamemory tests2 (dutspassed[1]);
    test_instructiondecode tests3 (dutspassed[2]);
    test_muxes tests4 (dutspassed[3], dutspassed[4]);
    test_pc tests5 (dutspassed[5]);
    test_regfile tests6 (dutspassed[6]);
    test_shifter tests7 (dutspassed[7], dutspassed[8]);
    test_signextend tests8 (dutspassed[9]);
    // test_alu tests1 (dutspassed[1]); // ALU testbench doesn't use DUTPassed schema. Run manually or re-write.
    initial begin
        $display("\nBEGIN ALL TESTS");
        $display("________________________________________________________________________________________");
        #20000  // Be sure to give time for all above tests to complete
        $display("________________________________________________________________________________________");
        $display("ALL TESTS COMPLETE");

        if (& dutspassed) begin
            $display("All tests passed!");
            $display("[Test result vector: %b]", dutspassed);

        end else begin
            $display("WARNING: Some tests failed.");
            $display("[Test result vector: %b]", dutspassed);
        end
    end
endmodule
