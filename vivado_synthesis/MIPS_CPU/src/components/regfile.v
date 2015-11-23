// Register File code modified from Ryan Eggert's Homework 4 assignment.

//------------------------------------------------------------------------------
//  regfile
//      MIPS register file
//          width: 32 bits
//          depth: 32 words (reg[0] is static zero register)
//          2 asynchronous read ports
//          1 synchronous, positive edge triggered write port
//
//------------------------------------------------------------------------------

module regfile
(
output[31:0]    ReadData1,      // Contents of first register read
output[31:0]    ReadData2,      // Contents of second register read
input[31:0]     WriteData,      // Contents to write to register
input[4:0]      ReadRegister1,  // Address of first register to read
input[4:0]      ReadRegister2,  // Address of second register to read
input[4:0]      WriteRegister,  // Address of register to write
input           RegWrite,       // Enable writing of register when High
input           Clk             // Clock (Positive Edge Triggered)
);

    wire[31:0] wrenables;  // Output of decoder, used to set write enables on each register.

    // This may be implementable with a genvar/for-loop
    wire[31:0] reg31out;
    wire[31:0] reg30out;
    wire[31:0] reg29out;
    wire[31:0] reg28out;
    wire[31:0] reg27out;
    wire[31:0] reg26out;
    wire[31:0] reg25out;
    wire[31:0] reg24out;
    wire[31:0] reg23out;
    wire[31:0] reg22out;
    wire[31:0] reg21out;
    wire[31:0] reg20out;
    wire[31:0] reg19out;
    wire[31:0] reg18out;
    wire[31:0] reg17out;
    wire[31:0] reg16out;
    wire[31:0] reg15out;
    wire[31:0] reg14out;
    wire[31:0] reg13out;
    wire[31:0] reg12out;
    wire[31:0] reg11out;
    wire[31:0] reg10out;
    wire[31:0] reg9out;
    wire[31:0] reg8out;
    wire[31:0] reg7out;
    wire[31:0] reg6out;
    wire[31:0] reg5out;
    wire[31:0] reg4out;
    wire[31:0] reg3out;
    wire[31:0] reg2out;
    wire[31:0] reg1out;
    wire[31:0] reg0out;

    // Decoder for writing to register.
    decoder1to32 in_decoder(wrenables, RegWrite, WriteRegister);

    // Wire the registers (again, has potential for looping)
    register32 register31(reg31out, WriteData, wrenables[31], Clk);
    register32 register30(reg30out, WriteData, wrenables[30], Clk);
    register32 register29(reg29out, WriteData, wrenables[29], Clk);
    register32 register28(reg28out, WriteData, wrenables[28], Clk);
    register32 register27(reg27out, WriteData, wrenables[27], Clk);
    register32 register26(reg26out, WriteData, wrenables[26], Clk);
    register32 register25(reg25out, WriteData, wrenables[25], Clk);
    register32 register24(reg24out, WriteData, wrenables[24], Clk);
    register32 register23(reg23out, WriteData, wrenables[23], Clk);
    register32 register22(reg22out, WriteData, wrenables[22], Clk);
    register32 register21(reg21out, WriteData, wrenables[21], Clk);
    register32 register20(reg20out, WriteData, wrenables[20], Clk);
    register32 register19(reg19out, WriteData, wrenables[19], Clk);
    register32 register18(reg18out, WriteData, wrenables[18], Clk);
    register32 register17(reg17out, WriteData, wrenables[17], Clk);
    register32 register16(reg16out, WriteData, wrenables[16], Clk);
    register32 register15(reg15out, WriteData, wrenables[15], Clk);
    register32 register14(reg14out, WriteData, wrenables[14], Clk);
    register32 register13(reg13out, WriteData, wrenables[13], Clk);
    register32 register12(reg12out, WriteData, wrenables[12], Clk);
    register32 register11(reg11out, WriteData, wrenables[11], Clk);
    register32 register10(reg10out, WriteData, wrenables[10], Clk);
    register32 register9(reg9out, WriteData, wrenables[9], Clk);
    register32 register8(reg8out, WriteData, wrenables[8], Clk);
    register32 register7(reg7out, WriteData, wrenables[7], Clk);
    register32 register6(reg6out, WriteData, wrenables[6], Clk);
    register32 register5(reg5out, WriteData, wrenables[5], Clk);
    register32 register4(reg4out, WriteData, wrenables[4], Clk);
    register32 register3(reg3out, WriteData, wrenables[3], Clk);
    register32 register2(reg2out, WriteData, wrenables[2], Clk);
    register32 register1(reg1out, WriteData, wrenables[1], Clk);
    // Wire the zeroth [zero] register
    register32zero register0(reg0out, WriteData, wrenables[0], Clk);

    mux32to1by32 port1mux(ReadData1, ReadRegister1, reg31out, reg30out, reg29out, reg28out, reg27out, reg26out, reg25out, reg24out, reg23out, reg22out, reg21out, reg20out, reg19out, reg18out, reg17out, reg16out, reg15out, reg14out, reg13out, reg12out, reg11out, reg10out, reg9out, reg8out, reg7out, reg6out, reg5out, reg4out, reg3out, reg2out, reg1out, reg0out);
    mux32to1by32 port2mux(ReadData2, ReadRegister2, reg31out, reg30out, reg29out, reg28out, reg27out, reg26out, reg25out, reg24out, reg23out, reg22out, reg21out, reg20out, reg19out, reg18out, reg17out, reg16out, reg15out, reg14out, reg13out, reg12out, reg11out, reg10out, reg9out, reg8out, reg7out, reg6out, reg5out, reg4out, reg3out, reg2out, reg1out, reg0out);
endmodule

//------------------------------------------------------------------------------
//  register32
//      MIPS register with write-enable, positive-edge triggered.
//          width: 32 bits
//   
//------------------------------------------------------------------------------
module register32(q, d, wrenable, clk);
    parameter SIZE = 32; // SIZE is the size (in bits) of the register. 
                         // For example, N=32 corresponds to a 32-bit register.
    output reg[SIZE-1:0] q;
    input[SIZE-1:0] d;
    input wrenable;
    input clk;

    always @(posedge clk ) begin
        if (wrenable) begin
            q = d;
        end
    end
    // generate
    //     genvar i; // instantiate variable for generate sequence
    //     for (i=0; i<SIZE; i=i+1) begin
    //         always @(negedge clk) begin
    //             if(wrenable) begin
    //                 q[i] = d[i];
    //             end
    //         end
    //     end
    // endgenerate
endmodule

//------------------------------------------------------------------------------
//  register32zero
//      MIPS register with write-enable [disabled], positive-edge triggered.
//          width: 32 bits
//          ALWAYS outputs 32'b0. Cannot be written to. 
//
//------------------------------------------------------------------------------
module register32zero(q, d, wrenable, clk);
    parameter SIZE = 32; // SIZE is the size (in bits) of the register. 
                         // For example, N=32 corresponds to a 32-bit register.
    output reg[SIZE-1:0] q;
    input[SIZE-1:0] d;
    input wrenable;
    input clk;
        always @(posedge clk) begin
            q = {SIZE{1'b0}};
        end
endmodule

//------------------------------------------------------------------------------
//  mux32to1by32
//      Multiplexer which chooses among 32 32-bit inputs [din0, din1,
//      ... , din31].
//          WIDTH: 32, DEPTH: 32
//          MUX_CTL: 5-bit. MUX_CTL = 0 selects din0; MUX_CTL = 1 selects din1.
//
//------------------------------------------------------------------------------
module mux32to1by32
(
output[31:0]    mux_out,
input[4:0]      mux_ctl,
input[31:0]     din31, din30, din29, din28, din27, din26, din25, din24, din23, din22, din21, din20, din19, din18, din17, din16, din15, din14, din13, din12, din11, din10, din9, din8, din7, din6, din5, din4, din3, din2, din1, din0
);

    wire[31:0] mux[31:0];         // Create a 2D array of wires
    assign mux[31] = din31;
    assign mux[30] = din30;
    assign mux[29] = din29;
    assign mux[28] = din28;
    assign mux[27] = din27;
    assign mux[26] = din26;
    assign mux[25] = din25;
    assign mux[24] = din24;
    assign mux[23] = din23;
    assign mux[22] = din22;
    assign mux[21] = din21;
    assign mux[20] = din20;
    assign mux[19] = din19;
    assign mux[18] = din18;
    assign mux[17] = din17;
    assign mux[16] = din16;
    assign mux[15] = din15;
    assign mux[14] = din14;
    assign mux[13] = din13;
    assign mux[12] = din12;
    assign mux[11] = din11;
    assign mux[10] = din10;
    assign mux[9] = din9;
    assign mux[8] = din8;
    assign mux[7] = din7;
    assign mux[6] = din6;
    assign mux[5] = din5;
    assign mux[4] = din4;
    assign mux[3] = din3;
    assign mux[2] = din2;
    assign mux[1] = din1;
    assign mux[0] = din0;
    assign mux_out = mux[mux_ctl];    // Connect the output of the array
endmodule

//------------------------------------------------------------------------------
//  decoder1to32
//      Decoder which sets one bit of 32-bit out to high, leaving all other
//      bits low. The bit set high is determined by the five-bit address input.
//      The above happens only if enable is set high. If enable is low, out will
//      be a 32-bit 0. 
//
//------------------------------------------------------------------------------
module decoder1to32
(
output[31:0]    out,
input           enable,
input[4:0]      address
);
    assign out = enable<<address; 
endmodule