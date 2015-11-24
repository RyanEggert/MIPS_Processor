`include "control.v"

module test_control(dutpassed);
	reg clk;
    reg[5:0] opcode, funct;

    wire Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JumpSel, WriDataSel, RegDst;
    wire[5:0] ALUOp;

    output reg dutpassed;

    control dut (
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


    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    /*		
    	if (RegDst != || Jump !=  || Branch != || MemRead != || MemtoReg != || ALUOp != || MemWrite != || ALUSrc != || RegWrite != || JumpSel != || WriDataSel !=  ) begin
			dutpassed = 0;
			$display("LW Failed");
		end
	*/

    initial begin
		
    	$display("Starting CONTROL Tests @time = %0dns...", $time);
		opcode = 6'b100011;
		funct = 6'b000000;
		
		#20
		//LW
		if (RegDst != 0 || Jump !=0  || Branch !=0 || MemRead !=1 || MemtoReg !=1 || ALUOp !=6'b100000 || MemWrite !=0 || ALUSrc !=1 || RegWrite != 1 || WriDataSel !=1 ) begin
			dutpassed = 0;
			$display("LW Failed");
		end
	
		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
				opcode = 6'b101011;
		funct = 6'b000000;
		#20	
		//TestSW
		if (RegDst != 0 || Jump !=0  || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp !=6'b100000 || MemWrite !=1 || ALUSrc !=1 || RegWrite != 0  ) begin
			dutpassed = 0;
			$display("SW Failed");
		end

		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b000010;
		funct = 6'b000000;
		#20	
		//TestJ
		if ( Jump != 1 || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b101100 || MemWrite != 0 || ALUSrc !=0 || RegWrite!= 0 || JumpSel != 0 ) begin			
			dutpassed = 0;
			$display("J Failed");
		end

		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b000000;
		funct = 6'b001000;
		#20	
		//TestJR
		if ( Jump != 1 || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b101100 || MemWrite != 0 || ALUSrc !=0 || RegWrite!= 0 || JumpSel != 1 ) begin			
			dutpassed = 0;
			$display("JR Failed");
		end


		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b000011;
		funct = 6'b000000;
		#20	
		//TestJAL
		if ( Jump != 1 || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b101100 || MemWrite != 0 || ALUSrc !=0 || RegWrite!= 1 || WriDataSel !=0 || JumpSel != 0 ) begin			
			dutpassed = 0;
			$display("JAL Failed");
		end
		
		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b000101;
		funct = 6'b000000;
		#20	
		//TestBNE
		if ( RegDst != 0 || Jump != 0 || Branch !=1 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b100010 || MemWrite != 0 || ALUSrc !=0 || RegWrite != 0) begin			
			dutpassed = 0;
			$display("BNE Failed");
		end

		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b001110;
		funct = 6'b000000;
		#20	
		//TestXORi
		if ( RegDst != 1 || Jump != 0 || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b100110 || MemWrite != 0 || ALUSrc !=1 || RegWrite != 1) begin			
			dutpassed = 0;
			$display("XORi Failed");
		end

		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b000000;
		funct = 6'b100000;
		#20	
		//TestADD
		if ( RegDst != 1 || Jump != 0 || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b100000 || MemWrite != 0 || ALUSrc !=0 || RegWrite != 1) begin			
			dutpassed = 0;
			$display("ADD Failed");
		end
		

		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b000000;
		funct = 6'b100010;
		#20	
		//TestSUB
		if ( RegDst != 1 || Jump != 0 || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b100010 || MemWrite != 0 || ALUSrc !=0 || RegWrite != 1) begin			
			dutpassed = 0;
			$display("SUB Failed");
		end

		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b000000;
		funct = 6'b101010;
		#20	
		//TestSLT
		if ( RegDst != 1 || Jump != 0 || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b101010 || MemWrite != 0 || ALUSrc !=0 || RegWrite != 1) begin			
			dutpassed = 0;
			$display("SLT Failed");
		end


		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		
		opcode = 6'b000000;
		funct = 6'b000000;
		#20	
		//TestNOOP
		if ( RegDst != 0 || Jump != 0 || Branch !=0 || MemRead !=0 || MemtoReg !=0 || ALUOp != 6'b101100 || MemWrite != 0 || ALUSrc !=0 || RegWrite != 0) begin			
			dutpassed = 0;
			$display("NOOP Failed");
		end

		$display("CONTROL Tests Complete @time = %0dns.", $time);
		if (dutpassed == 1) begin
		    $display("\tCONTROL PASSED");
		end else begin
		    $display("\tCONTROL FAILED");
		end
	

		// opcode = 6'b000000;
		// funct = 6'b001100;
		// #20	
		// //TestSYSCALL
		// if ( 1 ==0) begin			
		// 	dutpassed = 0;
		// 	$display("SYSCALL Failed");
		// end

	
	end
endmodule