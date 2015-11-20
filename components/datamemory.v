// Data Memory code modified from Lab2 resources.
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
    parameter depth         = 2**14,
    parameter width         = 32,
    parameter loadfrom      = "NONE"
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

    always @(negedge clk) begin
        if(write_en) begin
            memory[address] <= data_in;
            $display("Writing 0x%h to 0x%h", data_in, address);
        end
        if (read_en) begin
            data_out <= memory[address];
        end else begin
            data_out <= {width{1'bz}};
        end
    end
    initial begin
        if ((loadfrom == "NONE") | (loadfrom == "")) begin
            $display("\tNo data memory memfile specified");
        end else begin
            $display("\tLoading \"%s\" into data memory", loadfrom);
            $readmemh(loadfrom, memory);
        end
    end

endmodule
