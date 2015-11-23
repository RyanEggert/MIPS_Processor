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
    test_adder test0 (dutspassed[0]);
    test_datamemory test1 (dutspassed[1]);
    test_instructiondecode test2 (dutspassed[2]);
    test_muxes test3 (dutspassed[3], dutspassed[4]);
    test_pc test4 (dutspassed[5]);
    test_regfile test5 (dutspassed[6]);
    test_shifter test6 (dutspassed[7], dutspassed[8]);
    test_signextend test7 (dutspassed[9]);
    // test_controls test8 (dutspassed[10]); To be uncommented once the central control logic test is stable.
    // test_alu tests1 (dutspassed[1]); // ALU testbench doesn't use DUTPassed schema. Run manually or re-write.
    initial begin
        $display("\nBEGIN ALL TESTS");
        $display("________________________________________________________________________________________");
        #20000  // Be sure to give sufficient time for all above tests to complete. If this isn't done, results will be unreliable.
        $display("________________________________________________________________________________________");
        $display("ALL TESTS COMPLETE");

        if (& dutspassed) begin
            $display("All tests passed!");
            $display("[Test result vector: %b]", dutspassed);

        end else begin
            $display("WARNING: Some tests may have failed.");
            $display("[Test result vector: %b]", dutspassed); // If you see z's in your vector, check that a test is wired to that bit of the vector
        end
    end
endmodule
