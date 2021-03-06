//----------------------------------------------------------------------------
//  Control Unit
//  Control Unit to set all the control wires based on the opcode and function.    
//  Can Handle LW, SW, J, JAL, BNE, XORI R, ADD, SUB, SLT, SYSCALL, andNOOP
//
//
//----------------------------------------------------------------------------

    
module control(  Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JumpSel, RegDst, WriDataSel, ALUOp, opcode, funct, clk);
    input clk;
    input[5:0] opcode, funct;

    output reg Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JumpSel, WriDataSel, RegDst;
    output reg[5:0] ALUOp;

    parameter LW = 6'b100011, SW = 6'b101011, J = 6'b000010, JR = 6'b001000, JAL = 6'b000011 , BNE = 6'b000101, XORI = 6'b001110, 
    ADD = 6'b100000, ADDI = 6'b001000,  SUB = 6'b100010, SLT = 6'b101010, SYSCALL = 6'b001100, NOOP = 6'b000000, More = 6'b000000, err = 6'bxxxxxx;
    //opps in fist case: LW, SW, J, JAL, BNE, XORI
    //opps that have opcode zero and go in second case to check their funct: JR, ADD, SUB, SLT, SYSCALL, NOOP
    always @(opcode, funct) begin

        $display("opcode is %b", opcode);
        $display("funct is %b", funct);

        // case within case to handle each opcode (and function if need be). 
        case(opcode)
        LW: begin

            $display("LW" );
            RegDst = 0;
            Jump = 0;
            JumpSel = 0;
            Branch = 0;
            MemRead = 1;
            MemtoReg = 1;
            ALUOp = 6'b100000;
            
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            WriDataSel = 1;
        end

        SW: begin 
            $display("SW" );

            RegDst = 0;
            Jump = 0;
            JumpSel = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b100000;
            MemWrite = 1;
            ALUSrc = 1;
            RegWrite = 0;
        end 
        J: begin 
            $display("J" );

            Jump = 1;
            JumpSel = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b101100;
            
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
        end
        JAL: begin 
            $display("JAL" );
            Jump = 1;
            JumpSel = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b101100;
            
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;
            WriDataSel = 0;
        end
        BNE: begin 
            $display("BNE" );
            RegDst = 0;
            Jump = 0;
            JumpSel = 0;
            Branch = 1;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b100010;
            
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;

        end
        XORI: begin 
            $display("XORI" );
            RegDst = 0 ;
            Jump = 0;
            JumpSel = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b100110;
            
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            WriDataSel = 1;
        end
        ADDI: begin
            $display("ADDI");
            RegDst = 0 ;
            Jump = 0;
            JumpSel = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b100000;
            
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            WriDataSel = 1;

            
        end
        err: begin
            // this occurs when we get an undefined opcode (xxxxxx), in which case something is broken in our CPU and we should stop
            //different to default, which handles opcode we haven't programmed in. 
            $display("ERROR: Next instruction opcode is %b. Shutting down.", opcode );
            $finish;            
        end
        More: begin 
            case(funct)
            JR: begin 
                $display("JR" );
                Jump = 1;
                JumpSel = 1;                
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b101100;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
            end
            ADD: begin
                $display("ADD");
                RegDst = 1;
                Jump = 0;
                JumpSel = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b100000;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;
                WriDataSel = 1;
            end
            SUB:  begin
                $display("SUB" );
                RegDst = 1;
                Jump = 0;
                JumpSel = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b100010;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;
                WriDataSel = 1;             
            end
            SLT:  begin 
                $display("SLT" );

                RegDst = 1;
                Jump = 0;
                JumpSel = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b101010;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;  
                WriDataSel = 1;          
            end
            err: begin
                $display("error" );
                    $finish;            
                end 
            SYSCALL: begin
                $display("SYSCALL recieved, processor shutting down." );
                    $finish;            
                end
            NOOP:  begin
                $display("NOOP" );
                RegDst = 0;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b101100;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
                WriDataSel = 0;
                JumpSel = 0; 
            end
            default: begin
                //default to handle all other opps by doing a noop. 
                $display("ERROR [@t=%0dns]: Control default case triggered [opcode = More]. Triggering NOOP behavior", $time); // Print error message to console
                
                RegDst = 0;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b101100;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
                WriDataSel = 0;
                JumpSel = 0;
            end
            endcase
        end 
        default: begin
            //default to handle all other opps by doing a noop. 
            $display("ERROR [@t=%0dns]: Control default case triggered [unknown opcode]. Triggering NOOP behavior", $time); 
            // Print error message to console
            
            RegDst = 0;
            Jump = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b101100;
            
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            WriDataSel = 0;
            JumpSel = 0;
        end
        endcase
    end
endmodule
