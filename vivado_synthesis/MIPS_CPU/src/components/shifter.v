//------------------------------------------------------------------------------
//  shift2
//      Takes a `width_in`-bit input, shifts each bit left by 2 bits.
//      The `width_out` parameter determines the width of the shifted output.
//      Note that `width_out` >= `width_in`. [`width_out` - `width_in` >= 0]
//
//------------------------------------------------------------------------------

module shift2 (out, in);
    parameter width_in = 32;
    parameter width_out = 32;

    input [width_in-1:0] in;
    output reg[width_out-1:0] out;

    always @(in) begin 
        out <= {{width_out-width_in{1'b0}}, in << 2};
    end
endmodule