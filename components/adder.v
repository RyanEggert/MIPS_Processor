//----------------------------------------------------------------------------
//  Parameterized-Width Adder
//      Adds a and b and outputs their sum to sum. The `width` parameter
//      (default value 32) specifies the width, in bits, of a, b, and sum.
//   
//----------------------------------------------------------------------------

module adder #(parameter width = 32) (sum, a, b) ;
    input [width-1:0] a, b;
    output reg[width-1:0] sum;

    always @(a, b) begin    // Whenever a or b changes,
        sum = a + b;        // set sum equal to the sum of a and b
    end

endmodule