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
    parameter depth         = 2**14,
    parameter width         = 32,
    parameter loadfrom      = "NONE"
)
(
    output reg [width-1:0]     data_out,
    input                      clk,
    input [addresswidth-1:0]   address
);
    reg [width-1:0] shiftedadd;
    reg [width-1:0] mem [depth-1:0];

    always @(address) begin 
        shiftedadd = address >> 2;
        data_out = mem[shiftedadd];
    end
    initial begin
        if ((loadfrom == "NONE") | (loadfrom == "")) begin
            $display("\tNo instruction memory memfile specified");
        end else begin
            $display("\tLoading \"%s\" into instruction memory", loadfrom);
            $readmemh(loadfrom, mem); // Still throws "can not open in read mode" error?
        end
    end
endmodule