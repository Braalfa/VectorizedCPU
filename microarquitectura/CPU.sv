module CPU #(parameter SCALAR_DATA_WIDTH = 48, parameter VECTOR_DATA_WIDTH = 8,
					parameter VECTOR_SIZE = 6,
					parameter SCALAR_REGNUM = 16, parameter VECTOR_REGNUM = 16, 
					parameter REG_ADDRESS_WIDTH = 4, parameter OPCODE_WIDTH = 4)
	(input logic clock, reset);

	// ---------------------------------//
	// Control Unit
	
	// Variables que la unidad de control debe de manejar:
	logic isVectorScalarOperationDD; // write enable para escribir en el registro vectorial durante el Decode actual;
	logic resultSelectorWBD; // selecciona el dato a retroalimentar en el write back, 0-> salida de alu, 1-> salida de memoria;
	logic writeEnableScalarWBD;  // write enable para escribir en el registro escalar durante el writeback;
	logic	writeEnableVectorWBD;   // write enable para escribir en el registro vectorial durante el writeback;
	logic writeToMemoryEnableMD; // write enable para escribir en memoria
	logic useInmediateED; // indica si usar inmediate en lugar del registro scalar #2
	logic isScalarInstructionED; // Indica si es una instruccion aritmetica entre escalares o entre vectores; 1-> entre escalares, 0-> entre vectores
	logic writeScalarED; // Indica si pasar a memoria el registro escalar 2 o el registro vector 2. 1-> registro escalar 2, 0-> registro vector 2
	logic [2:0] aluControlED; // Control de ALU
	

	// Insertar control unit aqui. Hay un ejemplo en proyecto viejo alfaro juancho
	
	
	
	// ---------------------------------//
	// Conditional unit (Activa la variable de branching)
	
	logic N2, Z2, V2, C2;
	logic [OPCODE_WIDTH-1:0] opcodeE;
	logic takeBranchE; // tomar branch

	condunit #(.OPCODEWIDTH(OPCODE_WIDTH)) condunit
	(.opcodeE(opcodeE),
	.N(N2), .Z(Z2), .V(V2), .C(C2),
	.takeBranchE(takeBranchE)
	);

	// -----------------//
		

	//Hazards Unit 

	logic [1:0] data1ScalarForwardSelectorE, data2ScalarForwardSelectorE;
	logic [1:0] data1VectorForwardSelectorE, data2VectorForwardSelectorE;
	logic stallF, stallD, flushE, flushD;
	
	hazardsUnit #(.ADDRESSWIDTH(REG_ADDRESS_WIDTH)) hazardUnit
	(.writeEnableScalarWBD(writeEnableScalarWBD),
	 .writeEnableVectorWBD(writeEnableVectorWBD), 
	 .writeToMemoryEnableMD(writeToMemoryEnableMD), 
	 .resultSelectorWBE(resultSelectorWBE), 
	 .takeBranchE(takeBranchE),
	 .isScalarInstructionED(isScalarInstructionED), 
	 .isScalarInstructionEE(isScalarInstructionEE),
	 .isScalarInstructionEM(isScalarInstructionEM), 
	 .isScalarInstructionEWB(isScalarInstructionEWB),
	 .isVectorScalarOperationDD(isVectorScalarOperationDD), 
	 .isVectorScalarOperationDE(isVectorScalarOperationDE),
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
	
	logic [SCALAR_DATA_WIDTH-1:0] NewPCF;
	logic [SCALAR_DATA_WIDTH-1:0] instructionF;
	
	 Fetch #(.PC_WIDTH(SCALAR_DATA_WIDTH), .INSTRUCTION_WIDTH(SCALAR_DATA_WIDTH)) Fetch
	(.NewPC(NewPCF), .PCSelector(takeBranchE), .clock(clock), .reset(reset), .enable(!stallF),
	 .instruction(instructionF)
	 );
	
	// Fetch - Decoding FlipFlop
	
	logic [SCALAR_DATA_WIDTH-1:0] instructionD;
	
	flipflop #(.WIDTH(SCALAR_DATA_WIDTH)) FetchFlipFlop
	(.clk(clock), .reset(flushD), .enable(!stallD),
	 .in(instructionF), .out(instructionD));
	 
	//-------------------------------------------------------------------------------//
	
	// Decoder
	 
	 logic [REG_ADDRESS_WIDTH-1:0] writeAddressD;
	 logic [SCALAR_DATA_WIDTH-1:0] writeScalarDataD;
	 logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] writeVectorDataD;
	 logic writeEnableScalarD;
	 logic writeEnableVectorD;

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
	.isVectorScalarOperation(isVectorScalarOperationDD),
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
	 writeToMemoryEnableME, useInmediateEE, isScalarInstructionEE, writeScalarEE,
	 isVectorScalarOperationDE;
	 logic [2:0] aluControlEE;
	 
	 logic [SCALAR_DATA_WIDTH-1:0] reg1ScalarContentE, reg2ScalarContentE, inmediateE;
	 logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] reg1VectorContentE, reg2VectorContentE;
	 logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBE, reg1AddressE, reg2AddressE;
	 
	 logic N1, Z1, V1, C1;
	 
	 flipflop  #(3*SCALAR_DATA_WIDTH+2*VECTOR_SIZE*VECTOR_DATA_WIDTH+3*REG_ADDRESS_WIDTH+OPCODE_WIDTH+15) 
	 DecodeFlipFlop(.clk(clock), .reset(flushE), .enable(1'b1),
	 .in({reg1ScalarContentD, reg2ScalarContentD, inmediateD,
		 reg1VectorContentD, reg2VectorContentD,
		 regDestinationAddressWBD, reg1AddressD, reg2AddressD,
		 opcodeD,
		 resultSelectorWBD, writeEnableScalarWBD, writeEnableVectorWBD, aluControlED, writeToMemoryEnableMD,
		 useInmediateED, isScalarInstructionED, writeScalarED, isVectorScalarOperationDD,
		 N1, Z1, V1, C1}), 
	 .out({reg1ScalarContentE, reg2ScalarContentE, inmediateE,
			 reg1VectorContentE, reg2VectorContentE,
			 regDestinationAddressWBE, reg1AddressE, reg2AddressE,
			 opcodeE,
			 resultSelectorWBE, writeEnableScalarWBE, writeEnableVectorWBE, aluControlEE, writeToMemoryEnableME,
			 useInmediateEE, isScalarInstructionEE, writeScalarEE, isVectorScalarOperationDE,
			 N2, Z2, V2, C2}));
	 
	//-------------------------------------------------------------------------------//

	//Execute	
   logic [SCALAR_DATA_WIDTH-1:0] executeOuputE, dataToWriteE;
	logic [SCALAR_DATA_WIDTH-1:0]  forwardWB, forwardM;
	
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
	 .forwardWB(forwardWB), 
	 .forwardM(forwardM),
	 .data1ScalarForwardSelector(data1ScalarForwardSelectorE),
	 .data2ScalarForwardSelector(data2ScalarForwardSelectorE),
	 .data1VectorForwardSelector(data1VectorForwardSelectorE),
	 .data2VectorForwardSelector(data2VectorForwardSelectorE),
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
	logic isScalarInstructionEM; 
	flipflop  #(2*SCALAR_DATA_WIDTH+REG_ADDRESS_WIDTH+5) ExecuteFlipFlop(.clk(clock), .reset(reset), .enable(1'b1),
	 .in({executeOuputE, regDestinationAddressWBE, dataToWriteE, resultSelectorWBE, writeEnableScalarWBE, writeEnableVectorWBE, writeToMemoryEnableME, isScalarInstructionEE}), 
	 .out({executeOuputM, regDestinationAddressWBM, dataToWriteM, resultSelectorWBM, writeEnableScalarWBM, writeEnableVectorWBM, writeToMemoryEnableMM, isScalarInstructionEM}));
	 
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
			
	assign forwardM = executeOuputM;
	
	 // Memory - Write Back Flip-Flop

	 logic [SCALAR_DATA_WIDTH-1:0] memoryOutputWB;
	 logic [SCALAR_DATA_WIDTH-1:0] executeOuputWB;
	 logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBWB;
	 logic resultSelectorWBWB, writeEnableScalarWBWB, writeEnableVectorWBWB;
	 logic isScalarInstructionEWB;
	 
 	flipflop  #(2*SCALAR_DATA_WIDTH+REG_ADDRESS_WIDTH+4) MemoryFlipFlop(.clk(clock), .reset(reset), .enable(1'b1),
	 .in({memoryOutputM, executeOuputM, resultSelectorWBM, regDestinationAddressWBM, writeEnableScalarWBM, writeEnableVectorWBM, isScalarInstructionEM}), 
	 .out({memoryOutputWB, executeOuputWB, resultSelectorWBWB, regDestinationAddressWBWB, writeEnableScalarWBWB, writeEnableVectorWBWB, isScalarInstructionEWB}));

    //------------------------------------------------------------------------------//
	 
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
	assign forwardWB = outputWB;

		//assign forwardWB = outputWB;
	 

	 
endmodule

