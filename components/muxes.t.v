// muxes.t.v
`include "muxes.v"


module test_muxes(mux32passed, mux5passed);
    wire[31:0] out_32;
    wire[4:0] out_5;

    reg[31:0] din0_32, din1_32;
    reg[4:0] din0_5, din1_5;
    reg mux_ctl;

    output reg mux32passed, mux5passed;

    mux_2d #(32) mux_32 (.mux_out(out_32),
                         .mux_ctl(mux_ctl),
                         .din0(din0_32),
                         .din1(din1_32));

    mux_2d #(5) mux_5 (.mux_out(out_5),
                         .mux_ctl(mux_ctl),
                         .din0(din0_5),
                         .din1(din1_5));


    initial begin
        mux32passed = 1;
        mux5passed = 1;
        #1

        // Initialize MUX inputs
        din0_32 = 32'd123456;
        din1_32 = 32'd555555;
        din0_5 = 5'd10;
        din1_5 =5'd20;

        // Test 1
        $display("Starting Test 1 @time = %0dns...", $time);
        mux_ctl = 0;
        #1
        if (out_32 != din0_32) begin
            mux32passed = 0;
            $display("Test 1 failed by mux32.");
        end
        if (out_5 != din0_5) begin
            mux5passed = 0;
            $display("Test 1 failed by mux5.");
        end
        #1

        // Test 2
        $display("Starting Test 2 @time = %0dns...", $time);
        mux_ctl = 1;
        #1
        if (out_32 != din1_32) begin
            mux32passed = 0;
            $display("Test 2 failed by mux32. [out = %d; expected = %d]", out_32, din1_32);
        end
        if (out_5 != din1_5) begin
            mux5passed = 0;
            $display("Test 2 failed by mux5. [out = %d]; expected = %d", out_5, din1_5);
        end
        
        #1
        $display("Tests Complete @time = %0dns.", $time);
        if (mux32passed == 1) begin
            $display("mux32 PASSED");
        end else begin
            $display("mux32 FAILED");
        end

        if (mux5passed == 1) begin
            $display("mux5 PASSED");
        end else begin
            $display("mux5 FAILED");
        end
    end
    
endmodule