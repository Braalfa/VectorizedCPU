module controlUnit #(parameter OPCODE_WIDTH = 5)
	(	input logic [OPCODE_WIDTH-1:0] opcodeD,
		output logic useScalarAluED, isScalarOutputED, isScalarReg1ED, isScalarReg2ED,
	   output logic resultSelectorWBD,
	   output logic writeEnableScalarWBD,
	   output logic writeEnableVectorWBD, 
	   output logic writeToMemoryEnableMD,
	   output logic useInmediateED,
	   output logic [2:0] aluControlED,
	   output logic outFlagMD,
		output logic resetMaskVectorDD,
		output logic writeToMaskVectorED
		);
					
	always@(opcodeD) begin 
		
		case(opcodeD)
		5'b0:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b0;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b1;
         useInmediateED = 1'b0;
         aluControlED = 3'b110;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b10:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b1;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b110;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b11:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b1;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b1;
         writeEnableScalarWBD = 1'b1;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b110;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b100:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b000;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b101:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b001;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b110:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b010;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b111:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b111;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1000:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b1;
         aluControlED = 3'b111;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1001:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b1;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b110;
         outFlagMD = 1'b1;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1010:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b1;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b1;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b000;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1011:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b1;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b1;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b001;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1100:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b1;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b1;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b1;
         aluControlED = 3'b111;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1101:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b1;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b001;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1110:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b1;
         aluControlED = 3'b111;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b1111:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b1;
         aluControlED = 3'b111;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b10000:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b1;
         aluControlED = 3'b111;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b0;
     end

     5'b10001:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b011;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b0;
         writeToMaskVectorED = 1'b1;
     end

     5'b10010:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b0;
         outFlagMD = 1'b0;
         resetMaskVectorDD = 1'b1;
         writeToMaskVectorED = 1'b0;
     end
			default: begin 
				useScalarAluED = 1'b0; 
				isScalarOutputED = 1'b0;  
				isScalarReg1ED = 1'b0;  
				isScalarReg2ED = 1'b0; 
				resultSelectorWBD = 1'b0;
				writeEnableScalarWBD = 1'b0;
				writeEnableVectorWBD = 1'b0;
				writeToMemoryEnableMD = 1'b0;
				useInmediateED = 1'b0;
				aluControlED = 3'b0;
				outFlagMD = 1'b0;
				resetMaskVectorDD = 1'b0;
				writeToMaskVectorED = 1'b0;
			end
		endcase
	
	end
	
endmodule 