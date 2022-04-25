module controlUnit #(parameter OPCODE_WIDTH = 5)
	(	input logic [OPCODE_WIDTH-1:0] opcodeD,
		output logic useScalarAluED, isScalarOutputED, isScalarReg1ED, isScalarReg2ED,
	   output logic resultSelectorWBD,
	   output logic writeEnableScalarWBD,
	   output logic writeEnableVectorWBD, 
	   output logic writeToMemoryEnableMD,
	   output logic useInmediateED,
	   output logic [2:0] aluControlED,
	   output logic outFlagMD
		);
					
	always@(opcodeD) begin 
		
		case(opcodeD)
		5'b00000:begin
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
     end

     5'b00001:begin
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
     end

     5'b00010:begin
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
     end

     5'b00011:begin
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
     end

     5'b00100:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b0;
         outFlagMD = 1'b0;
     end

     5'b00101:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b1;
         outFlagMD = 1'b0;
     end

     5'b00110:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b10;
         outFlagMD = 1'b0;
     end

     5'b00111:begin
         useScalarAluED = 1'b0;
         isScalarOutputED = 1'b0;
         isScalarReg1ED = 1'b0;
         isScalarReg2ED = 1'b0;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b1;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b110;
         outFlagMD = 1'b0;
     end

     5'b01000:begin
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
     end

     5'b01001:begin
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
     end

     5'b01010:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b1;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b1;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b0;
         outFlagMD = 1'b0;
     end

     5'b01011:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b1;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b1;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b1;
         outFlagMD = 1'b0;
     end

     5'b01100:begin
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
     end

     5'b01101:begin
         useScalarAluED = 1'b1;
         isScalarOutputED = 1'b1;
         isScalarReg1ED = 1'b1;
         isScalarReg2ED = 1'b1;
         resultSelectorWBD = 1'b0;
         writeEnableScalarWBD = 1'b0;
         writeEnableVectorWBD = 1'b0;
         writeToMemoryEnableMD = 1'b0;
         useInmediateED = 1'b0;
         aluControlED = 3'b1;
         outFlagMD = 1'b0;
     end

     5'b01110:begin
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
     end

     5'b01111:begin
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
			end
		endcase
	
	end
	
endmodule 