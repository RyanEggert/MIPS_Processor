`include "components/alu.v"
`include "components/adder.v"
`include "components/control.v"
`include "components/datamemory.v"
`include "components/instructiondecode.v"
`include "components/instructionmemory.v"
`include "components/muxes.v"
`include "components/pc.v"
`include "components/regfile.v"
`include "components/shifter.v"
`include "components/signextend.v"


module cpu();

//pc out    + others
    reg clk;
    reg reset;
    wire [31:0] pcin, inst_addr, instr, imm32, shifted_imm32, mux_1_1, adder_pc_sum;
    wire [27:0] shifter_pc_out;

//instruction out 
    wire[5:0] decoded_opcode, decoded_funct;
    wire[4:0] decoded_rs, decoded_rt, decoded_rd, decoded_shamt;
    wire[15:0] decoded_imm16;
    wire[25:0] decoded_address;

//adder out
    wire[31:0]   b;
    wire[31:0]  sum;
    assign b = 32'd4;

//regfile out
    wire[31:0] ReadData1, ReadData2;

//mux0
    wire[31:0] SelectedJump;

//mux1
    wire[31:0] nonJumpPC;
    
//mux2
    wire[31:0] PCUpdate;

//mux3
    wire[31:0] SelectedWriteRegister1;

//mux4
    wire[31:0] SelectedWriteRegister2;
    
//mux5
    wire[31:0] ALU_B;

//alu
    wire[31:0] ALUres;
    wire zero, cin, cout, ovf;
    assign cin = 0;

// control wires
wire Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JumpSel, WriDataSel, RegDst;

//datamemory
    wire[31:0] DataMemOut;

//mux6
    wire[31:0] mux6out;
//mux7 	
    wire[31:0] SelectedWriteData;

//ALUCtrl
    wire[3:0] ALUCtrlOut;

    pc pc_comp (
        .clk(clk),
        .reset(reset),
        .pcin(pcin),
        .pcout(inst_addr)
        );

    memory instruction_memory (
        .clk(clk),
        .address(inst_addr),
        .data_out(instr)
        );

    instructiondecode instructiondecode_comp (
        .opcode(decoded_opcode),
        .funct(decoded_funct),
        .rs(decoded_rs),
        .rt(decoded_rt),
        .rd(decoded_rd),
        .shamt(decoded_shamt),
        .imm16(decoded_imm16),
        .address(decoded_address),
        .clk(clk),
        .instr(instr)
        );

    adder adder_pc (
        .sum(adder_pc_sum),
        .a(instr),
        .b(b)
        );

    adder adder_alures (
        .sum(mux_1_1),
        .a(adder_pc_sum),
        .b(shifted_imm32)
        );

    shift2 #(.width_in(26), .width_out(28)) shifter_pc  (
        .out(shifter_pc_out),
        .in(decoded_address)
        );

    shift2 #(.width_in(32), .width_out(32)) shifter_imm  (
        .out(shifted_imm32),
        .in(imm32)
        );

    signextend imm_signextend (
        .out32(imm32),
        .in16(decoded_imm16)
        );

    mux_2d mux0 (
    .mux_ctl(JumpSel), //Control
    .din0({{adder_pc_sum[31:28]}, shifter_pc_out}),
    .din1(ReadData1),
    .mux_out(SelectedJump)
    );

    and andgate(andout, Branch, zero);

    mux_2d mux1 (
    .mux_ctl(andout),
    .din0(adder_pc_sum),
    .din1(mux_1_1),
    .mux_out(nonJumpPC)
    );

    mux_2d mux2 (
    .mux_ctl(Jump), 
    .din0(nonJumpPC),
    .din1(SelectedJump),
    .mux_out(PCUpdate)
    );

    mux_2d mux3 (
    .mux_ctl(RegDst), 
    .din0(decoded_rt),
    .din1(decoded_rd), 
    .mux_out(SelectedWriteRegister1)
    );

    mux_2d mux4 (
    .mux_ctl(Jump),
    .din0(SelectedWriteRegister1),
    .din1(31),
    .mux_out(SelectedWriteRegister2)
    );

    mux_2d mux7 (
    .mux_ctl(WriDataSel), 
    .din0(adder_pc_sum),
    .din1(mux6out),
    .mux_out(SelectedWriteData)
    );


    initial clk=0;
    always #10 clk =! clk;


    regfile regfile (
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(SelectedWriteData),
    .ReadRegister1(decoded_rs),
    .ReadRegister2(decoded_rt),
    .WriteRegister(SelectedWriteRegister2),
    .RegWrite(RegWrite), 
    .Clk(clk)
    );

    mux_2d mux5 (
    .mux_ctl(ALUSrc), 
    .din0(ReadData2),
    .din1(imm32),
    .mux_out(ALU_B)
    );

    MIPSALU alu_cpu (
    .alu_ctl(ALUCtrlOut), 
    .a(ReadData1),
    .b(ALU_B),
    .cin(cin),
    .alu_res(ALUres),
    .zero(ALUzero),
    .ovf(ovf),
    .cout(cout)
    );

    datamemory datamemory_cpu (
    .clk(clk),
    .address(ALUres),
    .data_out(DataMemOut),
    .write_en(MemWrite), //Control
    .read_en(MemRead), //Control
    .data_in(ReadData2)
    );

    mux_2d mux6 (
    .mux_ctl(MemtoReg), //Control
    .din0(ALUres),
    .din1(DataMemOut),
    .mux_out(mux6out)
    );

    ALUControl ALUCtrl (
    .alu_ctl(ALUCtrlOut),
    .alu_op(ALUOp) 
    );

    control control_cpu (
    .Jump(Jump),
        .Branch(Branch),
    .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .JumpSel(JumpSel),
        .RegDst(RegDst),
        .WriDataSel(WriDataSel),
        .ALUOp(ALUOp),
        .opcode(opcode),
        .funct(funct),
        .clk(clk)
        );
endmodule