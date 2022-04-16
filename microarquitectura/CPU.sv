module CPU #(parameter SCALAR_DATA_WIDTH = 48, parameter VECTOR_DATA_WIDTH = 8,
					parameter VECTOR_SIZE = 6,
					parameter SCALAR_REGNUM = 16, parameter VECTOR_REGNUM = 16, 
					parameter REG_ADDRESS_WIDTH = 4, parameter OPCODE_WIDTH = 4)
	(input logic clock, reset);

	logic writeEnableScalarD, writeEnableVectorD, isVectorScalarOperationD,
	resultSelectorWBD, writeEnableScalarWBD, writeEnableVectorWBD, 
	writeToMemoryEnableMD, useInmediateED, isScalarInstructionED, writeScalarED;
	logic [2:0] aluControlED;
	
// Control Unit
//	controlunit #(OPCODEWIDTH) controlunit(
//		writeEnableDD,
//		writeDataEnableMD,
//		resultSelectorWBD,
//		data2SelectorED,
//		outFlagIOD,
//		aluControlED,
//		opcodeD
//	);
	
	
	logic N2, Z2, V2, C2;
// condunit
	
//	condunit #(OPCODEWIDTH) condunit
//	(takeBranchE,
//	 opcodeE,
//	NE2, ZE2, VE2, CE2
//	);
	
	// -----------------//
		
	logic takeBranchE;

	//Hazards Unit 
//	hazardsUnitsv #(WIDTH, ADDRESSWIDTH) HazardsUnit(
//		writeEnableDWB, writeEnableDM, resultSelectorWBE, takeBranchE,
//		regDestinationAddressWBM, regDestinationAddressWBWB, regDestinationAddressWBE,
//		reg1AddressE, reg2AddressE, reg1AddressD, reg2AddressD,
//		data1ForwardSelectorE, data2ForwardSelectorE,
//		stallF, stallD, flushE, flushD);
	
	
	//-------------------------------------------------------------------------------//
	// Fetch
	
	logic [SCALAR_DATA_WIDTH-1:0] NewPCF;
	logic [SCALAR_DATA_WIDTH-1:0] instructionF;
	
	 Fetch #(.PC_WIDTH(SCALAR_DATA_WIDTH), .INSTRUCTION_WIDTH(SCALAR_DATA_WIDTH)) Fetch
	(.NewPC(NewPCF), .PCSelector(takeBranchE), .clock(clock), .reset(reset), .enable(1),
	 .instruction(instructionF)
	 );
	
	// Fetch - Decoding FlipFlop
	
	logic [SCALAR_DATA_WIDTH-1:0] instructionD;
	
	flipflop #(.WIDTH(SCALAR_DATA_WIDTH)) FetchFlipFlop
	(.clk(clock), .reset(0), .enable(1),
	 .in(instructionF), .out(instructionD));
	 
	//-------------------------------------------------------------------------------//
	
	// Decoder
	 
	 logic [REG_ADDRESS_WIDTH-1:0] writeAddressD;
	 logic [SCALAR_DATA_WIDTH-1:0] writeScalarDataD;
	 logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] writeVectorDataD;
	 
	 logic [SCALAR_DATA_WIDTH-1:0] reg1ScalarContentD, reg2ScalarContentD, inmediateD;
	 logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] reg1VectorContentD, reg2VectorContentD;
	 logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBD, reg1AddressD, reg2AddressD;
	 logic [OPCODE_WIDTH-1:0] opcodeD;
	 
	 Decode #(.SCALAR_DATA_WIDTH(SCALAR_DATA_WIDTH), .VECTOR_DATA_WIDTH(VECTOR_DATA_WIDTH),
				 .VECTOR_SIZE(VECTOR_SIZE), .SCALAR_REGNUM(SCALAR_REGNUM), .VECTOR_REGNUM(VECTOR_REGNUM) 
					, .ADDRESS_WIDTH(REG_ADDRESS_WIDTH), .OPCODE_WIDTH(OPCODE_WIDTH) 
					,.INSTRUCTION_WIDTH(SCALAR_DATA_WIDTH)) Decode
	(.clock(clock), .reset(reset), 
	.writeEnableScalar(writeEnableScalarD), 
	.writeEnableVector(writeEnableVectorD), 
	.isVectorScalarOperation(isVectorScalarOperationD),
	 .writeAddress(writeAddressD),
	 .writeScalarData(writeScalarDataD),
	 .writeVectorData(writeVectorDataD),
	 .instruction(instructionD),
	 .reg1ScalarContent(reg1ScalarContentD), 
	 .reg2ScalarContent(reg2ScalarContentD), 
	 .inmediate(inmediateD),
	 .reg1VectorContent(reg1VectorContentD), 
	 .reg2VectorContent(reg2VectorContentD),
	 .regDestinationAddress(regDestinationAddressWBD), 
	 .reg1Address(reg1AddressD), 
	 .reg2Address(reg2AddressD),
	 .opcode(opcodeD)
	 );
	 	 
	 
	 // Decode - Execution Flip-Flop

	 logic resultSelectorWBE, writeEnableScalarWBE, writeEnableVectorWBE, 
	 writeToMemoryEnableME, useInmediateEE, isScalarInstructionEE, writeScalarEE;
	 logic [2:0] aluControlEE;
	 
	 logic [SCALAR_DATA_WIDTH-1:0] reg1ScalarContentE, reg2ScalarContentE, inmediateE;
	 logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] reg1VectorContentE, reg2VectorContentE;
	 logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBE, reg1AddressE, reg2AddressE;
	 logic [OPCODE_WIDTH-1:0] opcodeE;
	 
	 logic N1, Z1, V1, C1;
	 
	 flipflop  #(3*SCALAR_DATA_WIDTH+2*VECTOR_SIZE*VECTOR_DATA_WIDTH+3*REG_ADDRESS_WIDTH+OPCODE_WIDTH+14) 
	 DecodeFlipFlop(.clk(clock), .reset(0), .enable(1),
	 .in({reg1ScalarContentD, reg2ScalarContentD, inmediateD,
		 reg1VectorContentD, reg2VectorContentD,
		 regDestinationAddressWBD, reg1AddressD, reg2AddressD,
		 opcodeD,
		 resultSelectorWBD, writeEnableScalarWBD, writeEnableVectorWBD, aluControlED, writeToMemoryEnableMD,
		 useInmediateED, isScalarInstructionED, writeScalarED,
		 N1, Z1, V1, C1}), 
	 .out({reg1ScalarContentE, reg2ScalarContentE, inmediateE,
			 reg1VectorContentE, reg2VectorContentE,
			 regDestinationAddressWBE, reg1AddressE, reg2AddressE,
			 opcodeE,
			 resultSelectorWBE, writeEnableScalarWBE, writeEnableVectorWBE, aluControlEE, writeToMemoryEnableME,
			 useInmediateEE, isScalarInstructionEE, writeScalarEE,
			 N2, Z2, V2, C2}));
	 
	//-------------------------------------------------------------------------------//

	//Execute	
   logic [SCALAR_DATA_WIDTH-1:0] executeOuputE, dataToWriteE;

	Execute #(.SCALAR_DATA_WIDTH(SCALAR_DATA_WIDTH),
				 .VECTOR_DATA_WIDTH(VECTOR_DATA_WIDTH),
				 .VECTOR_SIZE(VECTOR_SIZE)) Execute
	(.scalarData1(reg1ScalarContentE), 
	 .scalarData2(reg2ScalarContentE), 
	 .scalarInmediate(inmediateE),
	 .vectorOperand1(reg1VectorContentE), 
	 .vectorOperand2(reg2VectorContentE),
	 .aluControl(aluControlEE),
	 .useInmediate(useInmediateEE),
	 .isScalarInstruction(isScalarInstructionEE),
	 .writeScalar(writeScalarEE),
	 .out(executeOuputE),
	 .dataToWrite(dataToWriteE),
	 .N(N1), 
	 .Z(Z1), 
	 .V(V1), 
	 .C(C1)
	 );	
		
	 assign NewPCF = executeOuputE;

	 // Execution - Memory Flip-Flop
	 
   logic [SCALAR_DATA_WIDTH-1:0] executeOuputM;
	logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBM;
	logic [SCALAR_DATA_WIDTH-1:0] dataToWriteM;
	logic resultSelectorWBM, writeEnableScalarWBM, writeEnableVectorWBM, writeToMemoryEnableMM;
	 
	flipflop  #(2*SCALAR_DATA_WIDTH+REG_ADDRESS_WIDTH+4) ExecuteFlipFlop(.clk(clock), .reset(0), .enable(1),
	 .in({executeOuputE, regDestinationAddressWBE, dataToWriteE, resultSelectorWBE, writeEnableScalarWBE, writeEnableVectorWBE, writeToMemoryEnableME}), 
	 .out({executeOuputM, regDestinationAddressWBM, dataToWriteM, resultSelectorWBM, writeEnableScalarWBM, writeEnableVectorWBM, writeToMemoryEnableMM}));
	 
   //-------------------------------------------------------------------------------//

	//Memory
	
	logic [SCALAR_DATA_WIDTH-1:0] memoryOutputM;
//	assign forwardM = aluOutputM;

	memory #(.DATA_WIDTH(SCALAR_DATA_WIDTH), .ADDRESS_WIDTH(SCALAR_DATA_WIDTH)) Memory(
			  .writeEnable(writeToMemoryEnableMM), .clk(clock),
			  .readAddress(executeOuputM), .writeAddress(executeOuputM),
			  .inputData(dataToWriteM),
			  .outputData(memoryOutputM)
			);
 
	
	 // Memory - Write Back Flip-Flop

	 logic [SCALAR_DATA_WIDTH-1:0] memoryOutputWB;
	 logic [SCALAR_DATA_WIDTH-1:0] executeOuputWB;
	 logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBWB;
	 logic resultSelectorWBWB, writeEnableScalarWBWB, writeEnableVectorWBWB;
	 
 	flipflop  #(2*SCALAR_DATA_WIDTH+REG_ADDRESS_WIDTH+3) MemoryFlipFlop(.clk(clock), .reset(0), .enable(1),
	 .in({memoryOutputM, executeOuputM, resultSelectorWBM, regDestinationAddressWBM, writeEnableScalarWBM, writeEnableVectorWBM}), 
	 .out({memoryOutputWB, executeOuputWB, resultSelectorWBWB, regDestinationAddressWBWB, writeEnableScalarWBWB, writeEnableVectorWBWB}));

    //-------------------------------------------------------------------------------//
	 
	//Write Back
	 
	 logic [SCALAR_DATA_WIDTH-1:0] outputWB;
	 mux2  #(SCALAR_DATA_WIDTH) writeBack (executeOuputWB, memoryOutputWB, resultSelectorWBWB, outputWB);
	 assign writeAddressD = regDestinationAddressWBWB;
	 assign writeScalarDataD = outputWB;
	 assign writeVectorDataD = {outputWB[VECTOR_DATA_WIDTH*6-1:VECTOR_DATA_WIDTH*5],
									   outputWB[VECTOR_DATA_WIDTH*5-1:VECTOR_DATA_WIDTH*4], 
										outputWB[VECTOR_DATA_WIDTH*4-1:VECTOR_DATA_WIDTH*3], 
										outputWB[VECTOR_DATA_WIDTH*3-1:VECTOR_DATA_WIDTH*2], 
										outputWB[VECTOR_DATA_WIDTH*2-1:VECTOR_DATA_WIDTH*1],
										outputWB[VECTOR_DATA_WIDTH*1-1:VECTOR_DATA_WIDTH*0]};
	assign writeEnableVectorD = writeEnableVectorWBWB;
	assign writeEnableScalarD = writeEnableScalarWBWB;

	//assign forwardWB = outputWB;
	 

	 
endmodule

