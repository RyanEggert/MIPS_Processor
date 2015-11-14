//------------------------------------------------------------------------------
// Data Memory
//   Positive edge triggered
//   data_out always has the value mem[address]
//      If write_en is true, writes data_in to memory[address].
//      If read_en is true, reads memory[address] to data_out. 
//      Else data_out = `width`'bz.
//   Parameter default values will support 32-bit addresses and 32-bit data.
//
//------------------------------------------------------------------------------

module datamemory
#(
    parameter addresswidth  = 32,
    parameter depth         = 2**addresswidth,
    parameter width         = 32
)
(
    input                       clk,
    output reg [width-1:0]      data_out,
    input [addresswidth-1:0]    address,
    input                       write_en,
    input                       read_en,
    input [width-1:0]           data_in
);

    reg [width-1:0] memory [depth-1:0];

    always @(posedge clk) begin
        if(write_en) begin
            memory[address] <= data_in;
        end
        if (read_en) begin
            data_out <= memory[address];
        end else begin
            data_out <= {width{1'bz}};
        end
    end

endmodule
