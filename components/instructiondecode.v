//----------------------------------------------------------------------------
//  instructiondecode
//      Decodes MIPS instructions into all possible fields. Provides opcode,
//      rs, rt, and rd register addresses, shift amount, function code,
//      16-bit immediate, and address. These are all the fields needed to 
//      decode I-type, J-type, and R-type instructions.
//----------------------------------------------------------------------------

module instructiondecode(opcode, rs, rt, rd, shamt, funct, imm16, address, clk, instr);
    input clk;
    input[31:0] instr;

    output reg[5:0] opcode, funct;
    output reg[4:0] rs, rt, rd, shamt;
    output reg[15:0] imm16;
    output reg[25:0] address;

    always @(posedge clk, instr) begin
        // All Instructions
        opcode <= instr[31:26];

        // R and I type instructions ONLY
        rs <= instr[25:21];
        rt <= instr[20:16];

        // R type instructions ONLY
        rd <= instr[15:11];
        shamt <= instr[10:6];
        funct <= instr[5:0];

        // I type instructions ONLY
        imm16 <= instr[15:0];

        // J type instructions ONLY
        address <= instr[25:0];
    end
endmodule
