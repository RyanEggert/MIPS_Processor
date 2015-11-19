//----------------------------------------------------------------------------
//  memory
//      Read-only memory initialized from a .dat file. Useful for instruction
//      memory.
//
//----------------------------------------------------------------------------

module memory(clk, Addr, DataOut);
    input clk;
    input[9:0] Addr;
    output[31:0]  DataOut;

    reg [31:0] mem[1023:0];  

    initial $readmemh(“/mem/instr.dat”, mem);

    assign DataOut = mem[Addr];
endmodule