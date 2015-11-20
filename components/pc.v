//----------------------------------------------------------------------------
//  pc
//      Program counter with synchronous reset [resets to 0].
//   
//----------------------------------------------------------------------------

module pc(pcout, clk, pcin, reset);
    input clk , reset;
    input [31:0] pcin ;
    output  reg [31:0]  pcout;
    
    initial begin
        pcout=0;
    end
    
    always @(posedge clk) begin
        if(reset)
            pcout = 0 ;
        else
            pcout = pcin ;
    end
endmodule
