
/*
   DATA_WIDTH: Tamano de los datos (escalares y en vector)
	INSTRUCTION_WIDTH: Tamano de la instruccion
   VECTOR_SIZE: Elementos en el vector
	PC_WIDTH: Ancho del PC
   SCALAR_REGNUM: Numero de elementos en el registro escalar
	VECTOR_REGNUM: Numero de elementos en el registro vectorial
   REG_ADDRESS_WIDTH: Ancho del address (para ambos registros, debe de ser el valor mas grande entre scalar y vector)
	OPCODE_WIDTH: Ancho del codigo de OP en la instruccion
*/

module CPU #(parameter DATA_WIDTH = 19, parameter INSTRUCTION_WIDTH = 30,
					parameter VECTOR_SIZE = 6, parameter PC_WIDTH = 32,
					parameter SCALAR_REGNUM = 8, parameter VECTOR_REGNUM = 8, 
					parameter REG_ADDRESS_WIDTH = 3, parameter OPCODE_WIDTH = 5,
					parameter OUTPUT_WIDTH = 8)
	(input logic clock, reset, 	
	output logic [VECTOR_SIZE*OUTPUT_WIDTH-1:0] out,	output logic outFlag);
	
	 logic [OPCODE_WIDTH-1:0] opcodeD;
	 logic isScalarOutputED, isScalarReg1ED, isScalarReg2ED,
	isScalarOutputEM, isScalarReg1EM, isScalarReg2EM,
	isScalarOutputEE, isScalarReg1EE, isScalarReg2EE,
	isScalarOutputEWB, isScalarReg1EWB, isScalarReg2EWB,
	useScalarAluED, useScalarAluEE;
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
	logic writeEnableScalarWBE, writeEnableVectorWBE, writeToMemoryEnableME, useInmediateEE;
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

	// ---------------------------------//
	// Control Unit
	
	logic resetMaskVectorDD;
	logic writeToMaskVectorED, writeToMaskVectorEE, writeToMaskVectorDD;
	logic [VECTOR_SIZE-1:0] maskVectorInD;
	logic [VECTOR_SIZE-1:0] maskVectorOutD, maskVectorOutE;
	logic [VECTOR_SIZE-1:0] outVectorComparisonE;
	
	controlUnit #(.OPCODE_WIDTH(OPCODE_WIDTH)) controlUnit
	(	.opcodeD(opcodeD),
		.useScalarAluED(useScalarAluED),
		.isScalarOutputED(isScalarOutputED), 
		.isScalarReg1ED(isScalarReg1ED), 
		.isScalarReg2ED(isScalarReg2ED),
	   .resultSelectorWBD(resultSelectorWBD),
	   .writeEnableScalarWBD(writeEnableScalarWBD),
	   .writeEnableVectorWBD(writeEnableVectorWBD), 
	   .writeToMemoryEnableMD(writeToMemoryEnableMD),
	   .useInmediateED(useInmediateED),
	   .aluControlED(aluControlED),
	   .outFlagMD(outFlagMD),
		.resetMaskVectorDD(resetMaskVectorDD),
		.writeToMaskVectorED(writeToMaskVectorED)
		);
	
	// Insertar control unit aqui. Hay un ejemplo en proyecto viejo alfaro juancho
	
	
	
	// ---------------------------------//
	// Conditional unit (Activa la variable de branching)
	
	condunit #(.OPCODEWIDTH(OPCODE_WIDTH)) condunit
	(.opcodeE(opcodeE),
	.N(N2), .Z(Z2), .V(V2), .C(C2),
	.takeBranchE(takeBranchE)
	);

	// -----------------//
		

	//Hazards Unit 


	hazardsUnit #(.ADDRESSWIDTH(REG_ADDRESS_WIDTH)) hazardUnit
	(.writeEnableScalarWBWB(writeEnableScalarWBWB), 
	 .writeEnableScalarWBM(writeEnableScalarWBM), 
	 .writeEnableVectorWBWB(writeEnableVectorWBWB), 
	 .writeEnableVectorWBM(writeEnableVectorWBM),
	 .isScalarOutputED(isScalarOutputED),
	 .isScalarReg1ED(isScalarReg1ED), 
	 .isScalarReg2ED(isScalarReg2ED),
	 .isScalarOutputEM(isScalarOutputEM), 
	 .isScalarReg1EM(isScalarReg1EM), 
	 .isScalarReg2EM(isScalarReg2EM),
	 .isScalarOutputEE(isScalarOutputEE), 
	 .isScalarReg1EE(isScalarReg1EE), 
	 .isScalarReg2EE(isScalarReg2EE),
	 .isScalarOutputEWB(isScalarOutputEWB), 
	 .isScalarReg1EWB(isScalarReg1EWB), 
	 .isScalarReg2EWB(isScalarReg2EWB),
	 .resultSelectorWBE(resultSelectorWBE), 
	 .takeBranchE(takeBranchE),
	 .writeAddressM(regDestinationAddressWBM), 
	 .writeAddressWB(regDestinationAddressWBWB), 
	 .writeAddressE(regDestinationAddressWBE),
	 .reg1ReadAddressE(reg1AddressE), 
	 .reg2ReadAddressE(reg2AddressE), 
	 .reg1ReadAddressD(reg1AddressD), 
	 .reg2ReadAddressD(reg2AddressD),
	 .data1ScalarForwardSelectorE(data1ScalarForwardSelectorE), 
	 .data2ScalarForwardSelectorE(data2ScalarForwardSelectorE),
	 .data1VectorForwardSelectorE(data1VectorForwardSelectorE), 
	 .data2VectorForwardSelectorE(data2VectorForwardSelectorE),
	 .stallF(stallF), 
	 .stallD(stallD), 
	 .flushE(flushE), 
	 .flushD(flushD));
	
	
	//-------------------------------------------------------------------------------//
	// Fetch

	
	 Fetch #(.PC_WIDTH(PC_WIDTH), .INSTRUCTION_WIDTH(INSTRUCTION_WIDTH)) Fetch
	(.NewPC(NewPCF), .PCSelector(takeBranchE), .clock(clock), .reset(reset), .enable(!stallF),
	 .instruction(instructionF)
	 );
	
	// Fetch - Decoding FlipFlop

	
	flipflop #(.WIDTH(INSTRUCTION_WIDTH)) FetchFlipFlop
	(.clk(clock), .reset(flushD|reset), .enable(!stallD),
	 .in(instructionF), .out(instructionD));
	 
	//-------------------------------------------------------------------------------//
	
	// Decoder
	
	 Decode #(.DATA_WIDTH(DATA_WIDTH),
				 .VECTOR_SIZE(VECTOR_SIZE), .SCALAR_REGNUM(SCALAR_REGNUM), .VECTOR_REGNUM(VECTOR_REGNUM) 
					, .ADDRESS_WIDTH(REG_ADDRESS_WIDTH), .OPCODE_WIDTH(OPCODE_WIDTH) 
					,.INSTRUCTION_WIDTH(INSTRUCTION_WIDTH)) Decode
	(.clock(clock), .reset(reset), 
	.writeEnableScalar(writeEnableScalarD), 
	.writeEnableVector(writeEnableVectorD), 
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
	 .opcode(opcodeD),
	 .weMaskVector(writeToMaskVectorDD),
	 .resetMaskVector(resetMaskVectorDD),
	 .maskVectorIn(maskVectorInD),
	 .maskVectorOut(maskVectorOutD)
	 );
	 
	 
	 // Decode - Execution Flip-Flop

	 flipflop  #(3*DATA_WIDTH+2*VECTOR_SIZE*DATA_WIDTH+3*REG_ADDRESS_WIDTH+OPCODE_WIDTH+18+VECTOR_SIZE) 
	 DecodeFlipFlop(.clk(clock), .reset(flushE|reset), .enable(1'b1),
	 .in({reg1ScalarContentD, reg2ScalarContentD, inmediateD,
		 reg1VectorContentD, reg2VectorContentD,
		 regDestinationAddressWBD, reg1AddressD, reg2AddressD,
		 opcodeD,
		 resultSelectorWBD, writeEnableScalarWBD, writeEnableVectorWBD, aluControlED, writeToMemoryEnableMD,
		 useInmediateED, outFlagMD, isScalarOutputED, isScalarReg1ED, isScalarReg2ED, useScalarAluED,
		 N1, Z1, V1, C1, writeToMaskVectorED,
		 maskVectorOutD}), 
	 .out({reg1ScalarContentE, reg2ScalarContentE, inmediateE,
			 reg1VectorContentE, reg2VectorContentE,
			 regDestinationAddressWBE, reg1AddressE, reg2AddressE,
			 opcodeE,
			 resultSelectorWBE, writeEnableScalarWBE, writeEnableVectorWBE, aluControlEE, writeToMemoryEnableME,
			 useInmediateEE, outFlagME, isScalarOutputEE, isScalarReg1EE, isScalarReg2EE, useScalarAluEE,
			 N2, Z2, V2, C2, writeToMaskVectorEE,
			 maskVectorOutE}));
	 
	//-------------------------------------------------------------------------------//

	//Execute	
  
	Execute #(.DATA_WIDTH(DATA_WIDTH),
				 .VECTOR_SIZE(VECTOR_SIZE)) Execute
	(.scalarData1(reg1ScalarContentE), 
	 .scalarData2(reg2ScalarContentE), 
	 .scalarInmediate(inmediateE),
	 .vectorOperand1(reg1VectorContentE), 
	 .vectorOperand2(reg2VectorContentE),
	 .aluControl(aluControlEE),
	 .useInmediate(useInmediateEE),
	 .forwardWB(forwardWB), 
	 .forwardM(forwardM),
	 .useScalarAlu(useScalarAluEE),
	 .isScalarReg2(isScalarReg2EE),
	 .data1ScalarForwardSelector(data1ScalarForwardSelectorE),
	 .data2ScalarForwardSelector(data2ScalarForwardSelectorE),
	 .data1VectorForwardSelector(data1VectorForwardSelectorE),
	 .data2VectorForwardSelector(data2VectorForwardSelectorE),
	 .out(executeOuputE),
	 .dataToWrite(dataToWriteE),
	 .N(N1), 
	 .Z(Z1), 
	 .V(V1), 
	 .C(C1),
	 .vectorMask(maskVectorOutE),
	 .outVectorComparison(outVectorComparisonE)
	 );	
		
	 assign writeToMaskVectorDD = writeToMaskVectorEE;
	 assign maskVectorInD = outVectorComparisonE;
	 assign NewPCF = executeOuputE[PC_WIDTH-1:0];

	 // Execution - Memory Flip-Flop
	 
 

	flipflop  #(2*DATA_WIDTH*VECTOR_SIZE+REG_ADDRESS_WIDTH+8) ExecuteFlipFlop(.clk(clock), .reset(reset), .enable(1'b1),
	 .in({executeOuputE, regDestinationAddressWBE, dataToWriteE, resultSelectorWBE, writeEnableScalarWBE, 
	 writeEnableVectorWBE, writeToMemoryEnableME, outFlagME, isScalarOutputEE, isScalarReg1EE, isScalarReg2EE}), 
	 .out({executeOuputM, regDestinationAddressWBM, dataToWriteM, resultSelectorWBM, writeEnableScalarWBM, 
	 writeEnableVectorWBM, writeToMemoryEnableMM, outFlagMM, isScalarOutputEM, isScalarReg1EM, isScalarReg2EM}));
	 
   //-------------------------------------------------------------------------------//

	//Memory
	
	

	memory #(.DATA_WIDTH(DATA_WIDTH*VECTOR_SIZE), .ADDRESS_WIDTH(DATA_WIDTH)) Memory(
			  .writeEnable(writeToMemoryEnableMM), .clk(clock),
			  .readAddress(executeOuputM[DATA_WIDTH-1:0]), .writeAddress(executeOuputM[DATA_WIDTH-1:0]),
			  .inputData(dataToWriteM),
			  .outputData(memoryOutputM)
			);
			
	assign forwardM = executeOuputM;
	 // Memory - Write Back Flip-Flop

 	flipflop  #(2*DATA_WIDTH*VECTOR_SIZE+REG_ADDRESS_WIDTH+7) MemoryFlipFlop(.clk(clock), .reset(reset), .enable(1'b1),
	 .in({memoryOutputM, executeOuputM, resultSelectorWBM, regDestinationAddressWBM, writeEnableScalarWBM, writeEnableVectorWBM, outFlagMM,
	 isScalarOutputEM, isScalarReg1EM, isScalarReg2EM}), 
	 .out({memoryOutputWB, executeOuputWB, resultSelectorWBWB, regDestinationAddressWBWB, writeEnableScalarWBWB, writeEnableVectorWBWB, outputFlagMWB,
	 isScalarOutputEWB, isScalarReg1EWB, isScalarReg2EWB}));

    //------------------------------------------------------------------------------//
	 
	//Write Back
	 
	 
	 mux2  #(DATA_WIDTH*VECTOR_SIZE) writeBack (executeOuputWB, memoryOutputWB, resultSelectorWBWB, outputWB);
	 assign writeAddressD = regDestinationAddressWBWB;
	 assign writeScalarDataD = outputWB[DATA_WIDTH-1:0];
	 assign writeVectorDataD = {outputWB[DATA_WIDTH*6-1:DATA_WIDTH*5],
									   outputWB[DATA_WIDTH*5-1:DATA_WIDTH*4], 
										outputWB[DATA_WIDTH*4-1:DATA_WIDTH*3], 
										outputWB[DATA_WIDTH*3-1:DATA_WIDTH*2], 
										outputWB[DATA_WIDTH*2-1:DATA_WIDTH*1],
										outputWB[DATA_WIDTH*1-1:DATA_WIDTH*0]};
	assign writeEnableVectorD = writeEnableVectorWBWB;
	assign writeEnableScalarD = writeEnableScalarWBWB;
	assign forwardWB = outputWB;	 
	assign out = {memoryOutputWB[112:105], memoryOutputWB[93:86], memoryOutputWB[74:67], memoryOutputWB[55:48], memoryOutputWB[36:29], memoryOutputWB[17:10]};
	assign outFlag = outputFlagMWB; 
	 
	 
endmodule

