//------------------------------------------------------------------------------
// memory
//   Simple read-only memory initialized from a .dat file.
//   data_out always has the value mem[address]
//   Parameter default values will support 32-bit addresses and 32-bit data.
//
//------------------------------------------------------------------------------

module memory
#(
    parameter addresswidth  = 32,
    parameter depth         = 2**addresswidth,
    parameter width         = 32
)
(
    output wire [width-1:0]      data_out,
    input                       clk,
    input [addresswidth-1:0]    address
);

    reg [width-1:0] mem [depth-1:0];

    assign data_out = mem[address];
    // initial $readmemh(“/mem/instr.dat”, mem);

endmodule