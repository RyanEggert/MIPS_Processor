//----------------------------------------------------------------------------
//  signextend
//      Adds a and b and outputs their sum to sum. The `width` parameter
//      (default value 32) specifies the width, in bits, of a, b, and sum.
//   
//----------------------------------------------------------------------------

module signextend (out32, in16) ;
    input [15:0] in16;
    output reg[31:0] out32;

    always @(in16) begin         // Whenever 16-bit input changes,
        out32 = {{16{in16[15]}},{in16}};  // Precede in16 with 16 of its MSB
    end

endmodule