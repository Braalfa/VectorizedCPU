`timescale 1 ns / 1 ns
module test();
	
	parameter DATA_WIDTH = 19; 
	parameter INSTRUCTION_WIDTH = 30;
	parameter VECTOR_SIZE = 6; 
	parameter PC_WIDTH = 32;
	parameter SCALAR_REGNUM = 8; 
	parameter VECTOR_REGNUM = 8;
	parameter REG_ADDRESS_WIDTH = 3; 
	parameter OPCODE_WIDTH = 5;
	parameter OUTPUT_WIDTH = 8;
	logic reset;
	logic clock;
	logic outFlag;
	logic [VECTOR_SIZE*OUTPUT_WIDTH-1:0] out;
	
	
	logic isScalarOutputED, isScalarReg1ED, isScalarReg2ED,
	isScalarOutputEM, isScalarReg1EM, isScalarReg2EM,
	isScalarOutputEE, isScalarReg1EE, isScalarReg2EE,
	isScalarOutputEWB, isScalarReg1EWB, isScalarReg2EWB,
	useScalarAluED, useScalarAluEE;
	logic [OPCODE_WIDTH-1:0] opcodeD;
	logic resultSelectorWBD; 
	logic writeEnableScalarWBD;  
	logic	writeEnableVectorWBD;  
	logic writeToMemoryEnableMD; 
	logic useInmediateED; 
	logic [2:0] aluControlED;
	logic outFlagMD; 
   logic N2, Z2, V2, C2;
	logic [OPCODE_WIDTH-1:0] opcodeE;
	logic takeBranchE;
	logic [1:0] data1ScalarForwardSelectorE, data2ScalarForwardSelectorE;
	logic [1:0] data1VectorForwardSelectorE, data2VectorForwardSelectorE;
	logic stallF, stallD, flushE, flushD;
   logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBE, reg1AddressE, reg2AddressE, reg1AddressD, reg2AddressD;
	logic resultSelectorWBE;
	logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBM;
	logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBWB;
	logic [PC_WIDTH-1:0] NewPCF;
	logic [INSTRUCTION_WIDTH-1:0] instructionF;
	logic [INSTRUCTION_WIDTH-1:0] instructionD;
	logic [REG_ADDRESS_WIDTH-1:0] writeAddressD;
	logic [DATA_WIDTH-1:0] writeScalarDataD;
	logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] writeVectorDataD;
	logic writeEnableScalarD;
	logic writeEnableVectorD;
	logic [DATA_WIDTH-1:0] reg1ScalarContentD, reg2ScalarContentD, inmediateD;
	logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] reg1VectorContentD, reg2VectorContentD;
	logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBD;
	logic writeEnableScalarWBE, writeEnableVectorWBE, 
	writeToMemoryEnableME, useInmediateEE;
	logic [2:0] aluControlEE;
	logic outFlagME;
	logic [DATA_WIDTH-1:0] reg1ScalarContentE, reg2ScalarContentE, inmediateE;
	logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] reg1VectorContentE, reg2VectorContentE;
	logic N1, Z1, V1, C1;
	logic [DATA_WIDTH*VECTOR_SIZE-1:0] executeOuputE, dataToWriteE;
	logic [DATA_WIDTH*VECTOR_SIZE-1:0]  forwardWB, forwardM;
	logic [DATA_WIDTH*VECTOR_SIZE-1:0] executeOuputM;
	logic [DATA_WIDTH*VECTOR_SIZE-1:0] dataToWriteM;
	logic outFlagMM; 
	logic resultSelectorWBM, writeEnableScalarWBM, writeEnableVectorWBM, writeToMemoryEnableMM;
	logic [DATA_WIDTH*VECTOR_SIZE-1:0] memoryOutputM;
	logic [DATA_WIDTH*VECTOR_SIZE-1:0] memoryOutputWB;
	logic [DATA_WIDTH*VECTOR_SIZE-1:0] executeOuputWB;
	logic resultSelectorWBWB, writeEnableScalarWBWB, writeEnableVectorWBWB;
	logic outputFlagMWB;
	logic [DATA_WIDTH*VECTOR_SIZE-1:0] outputWB;
	
	
	
	CPU CPU(clock, reset, out, outFlag);
	
	integer OutFile;
	integer i;
	
	initial begin	
	
		OutFile = $fopen("C://Users//Brayan//Documents//I Sem 2022//Arqui//Proyecto 2//proyecto2//microarquitectura//outfile.txt");
		reset = 1;
		clock = 0;
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
		#10;
		
		i = 0;
		while(i<200000) begin
		   i += 1;
			clock = 1;
			#1	
		
			if(outFlag) begin 
				$fdisplay(OutFile,"%b", out);
			end
				
			clock = 0;
			#1;
		end
	end
	
endmodule 