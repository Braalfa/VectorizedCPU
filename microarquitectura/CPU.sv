module CPU #(parameter SCALAR_DATA_WIDTH = 48, parameter VECTOR_DATA_WIDTH = 8,
					parameter VECTOR_SIZE = 6,
					parameter SCALAR_REGNUM = 16, parameter VECTOR_REGNUM = 16, 
					parameter REG_ADDRESS_WIDTH = 4, parameter OPCODE_WIDTH = 4)
	(input logic clock, reset);

	// ---------------------------------//
	// Control Unit
	
	// Variables que la unidad de control debe de manejar:
	logic isVectorScalarOperationD; // write enable para escribir en el registro vectorial durante el Decode actual;
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

	condunit #(.OPCODEWIDTH(OPCODE_WIDTH))
	(.opcodeE(opcodeE),
	.N(N2), .Z(Z2), .V(V2), .C(C2),
	.takeBranchE(takeBranchE)
	);

	// -----------------//
		

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

