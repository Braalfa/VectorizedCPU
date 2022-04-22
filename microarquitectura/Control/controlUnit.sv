module controlUnit #(parameter OPCODE_WIDTH = 4)
	(	input logic [OPCODE_WIDTH-1:0] opcodeD,
		output logic isVectorScalarOperationED,
	   output logic resultSelectorWBD,
	   output logic writeEnableScalarWBD,
	   output logic writeEnableVectorWBD, 
	   output logic writeToMemoryEnableMD,
	   output logic useInmediateED,
	   output logic isScalarInstructionED,
	   output logic [2:0] aluControlED,
	   output logic outFlagMD
		);
					
	always@(opcodeD) begin 
		
		case(opcodeD)
			4'b0000: begin 
				isScalarInstructionED = 1'bx;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'bx;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'bx;
				aluControlED = 3'bx;
				outFlagMD = 1'b0;
			end
			4'b0001: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'bx;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b1;
				useInmediateED = 1'bx;
				aluControlED = 3'b110;
				outFlagMD = 1'b0;
			end
			4'b0010: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'b1;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b1;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'bx;
				aluControlED = 3'b110;
				outFlagMD = 1'b0;
			end
			4'b0011: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b1;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b1;
				aluControlED = 3'b111;
				outFlagMD = 1'b0;
			end
			4'b0100: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'b1;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'bx;
				aluControlED = 3'b110;
				outFlagMD = 1'b1;
			end
			4'b0101: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b1;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b0;
				aluControlED = 3'b000;
				outFlagMD = 1'b0;
			end
			4'b0110: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b1;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b0;
				aluControlED = 3'b001;
				outFlagMD = 1'b0;
			end
			4'b0111: begin 
				isScalarInstructionED = 1'b0;
				isVectorScalarOperationED = 1'b0;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b1;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'bx;
				aluControlED = 3'b000;
				outFlagMD = 1'b0;
			end
			4'b1000: begin 
				isScalarInstructionED = 1'b0;
				isVectorScalarOperationED = 1'b0;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b1;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'bx;
				aluControlED = 3'b001;
				outFlagMD = 1'b0;
			end
			4'b1001: begin 
				isScalarInstructionED = 1'b0;
				isVectorScalarOperationED = 1'b0;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b1;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'bx;
				aluControlED = 3'b011;
				outFlagMD = 1'b0;
			end
			4'b1010: begin 
				isScalarInstructionED = 1'b0;
				isVectorScalarOperationED = 1'b1;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b1;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b1;
				aluControlED = 3'b010;
				outFlagMD = 1'b0;
			end
			4'b1011: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'bx;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b0;
				aluControlED = 3'b001;
				outFlagMD = 1'b0;
			end
			4'b1100: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b1;
				aluControlED = 3'b111;
				outFlagMD = 1'b0;
			end
			4'b1101: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b1;
				aluControlED = 3'b111;
				outFlagMD = 1'b0;
			end
			4'b1110: begin 
				isScalarInstructionED = 1'b1;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b1;
				aluControlED = 3'b111;
				outFlagMD = 1'b0;
			end
			4'b1111: begin 
				isScalarInstructionED = 1'bx;
				isVectorScalarOperationED = 1'bx;
				resultSelectorWBD = 1'bx;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'bx;
				aluControlED = 3'bx;
				outFlagMD = 1'b0;
			end
		endcase
	
	end
	
endmodule 