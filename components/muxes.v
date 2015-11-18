//------------------------------------------------------------------------------
//  mux_2d
//      Multiplexer which chooses between two `width`-bit inputs [din0, din1].
//          WIDTH: `width`, DEPTH: 2
//          MUX_CTL: 1bit. MUX_CTL = 0 selects din0; MUX_CTL = 1 selects din1.
//          `width` is a parameter which specifies width, in bits, of each mux
//          input. The default value of `width` is 32, which corresponds to a
//          32-bit number.
//------------------------------------------------------------------------------
module  mux_2d#(parameter width = 32)(mux_out, mux_ctl, din0, din1);
    input mux_ctl;
    input [width-1:0] din0, din1;

    output reg[width-1:0] mux_out;

    always @ (mux_ctl or din0 or din1)
    begin
        case(mux_ctl ) 
            1'b0 : mux_out = din0;
            1'b1 : mux_out = din1;
        endcase 
    end

endmodule