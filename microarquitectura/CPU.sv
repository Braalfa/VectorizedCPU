
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

module CPU #(parameter DATA_WIDTH = 16, parameter INSTRUCTION_WIDTH = 24,
					parameter VECTOR_SIZE = 6, parameter PC_WIDTH = 32,
					parameter SCALAR_REGNUM = 16, parameter VECTOR_REGNUM = 16, 
					parameter REG_ADDRESS_WIDTH = 4, parameter OPCODE_WIDTH = 4)
	(input logic clock, reset,
	 output logic [VECTOR_SIZE*DATA_WIDTH-1:0] out,
	 output logic outFlag,
	 output logic [OPCODE_WIDTH-1:0] opcodeD,
	output logic isVectorScalarOperationED, 
	output logic resultSelectorWBD,
	output logic writeEnableScalarWBD,  
	output logic	writeEnableVectorWBD,  
	output logic writeToMemoryEnableMD, 
	output logic useInmediateED,
	output logic isScalarInstructionED,
	output logic [2:0] aluControlED,
	output logic outFlagMD, 
   output logic N2, Z2, V2, C2,
	output logic [OPCODE_WIDTH-1:0] opcodeE,
	output logic takeBranchE, 
	output logic [1:0] data1ScalarForwardSelectorE, data2ScalarForwardSelectorE,
	output logic [1:0] data1VectorForwardSelectorE, data2VectorForwardSelectorE,
	output logic stallF, stallD, flushE, flushD,
   output logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBE, reg1AddressE, reg2AddressE, reg1AddressD, reg2AddressD,
	output logic resultSelectorWBE, isScalarInstructionEE, isVectorScalarOperationEE,
	output logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBM,
	output logic isScalarInstructionEM, 
	output logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBWB,
	output logic isScalarInstructionEWB,
	output logic [PC_WIDTH-1:0] NewPCF,
	output logic [INSTRUCTION_WIDTH-1:0] instructionF,
	output logic [INSTRUCTION_WIDTH-1:0] instructionD,
	 output logic [REG_ADDRESS_WIDTH-1:0] writeAddressD,
	 output logic [DATA_WIDTH-1:0] writeScalarDataD,
	 output logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] writeVectorDataD,
	 output logic writeEnableScalarD,
	 output logic writeEnableVectorD,
	 output logic [DATA_WIDTH-1:0] reg1ScalarContentD, reg2ScalarContentD, inmediateD,
	 output logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] reg1VectorContentD, reg2VectorContentD,
	 output logic [REG_ADDRESS_WIDTH-1:0] regDestinationAddressWBD,
	output logic writeEnableScalarWBE, writeEnableVectorWBE, writeToMemoryEnableME, useInmediateEE,
	output logic [2:0] aluControlEE,
	output logic outFlagME,
	output logic [DATA_WIDTH-1:0] reg1ScalarContentE, reg2ScalarContentE, inmediateE,
	output logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] reg1VectorContentE, reg2VectorContentE,
	output logic N1, Z1, V1, C1,
	output logic [DATA_WIDTH*VECTOR_SIZE-1:0] executeOuputE, dataToWriteE,
	output logic [DATA_WIDTH*VECTOR_SIZE-1:0]  forwardWB, forwardM,
	output logic [DATA_WIDTH*VECTOR_SIZE-1:0] executeOuputM,
	output logic [DATA_WIDTH*VECTOR_SIZE-1:0] dataToWriteM,
	output logic outFlagMM, 
	output logic resultSelectorWBM, writeEnableScalarWBM, writeEnableVectorWBM, writeToMemoryEnableMM,
	output logic [DATA_WIDTH*VECTOR_SIZE-1:0] memoryOutputM,
	output logic [DATA_WIDTH*VECTOR_SIZE-1:0] memoryOutputWB,
	output logic [DATA_WIDTH*VECTOR_SIZE-1:0] executeOuputWB,
	output logic resultSelectorWBWB, writeEnableScalarWBWB, writeEnableVectorWBWB,
	output logic outputFlagMWB,
	output logic [DATA_WIDTH*VECTOR_SIZE-1:0] outputWB);

	// ---------------------------------//
	// Control Unit
	
 
	
	
	controlUnit #(.OPCODE_WIDTH(OPCODE_WIDTH)) controlUnit
	(	.opcodeD(opcodeD),
		.isVectorScalarOperationED(isVectorScalarOperationED),
	   .resultSelectorWBD(resultSelectorWBD),
	   .writeEnableScalarWBD(writeEnableScalarWBD),
	   .writeEnableVectorWBD(writeEnableVectorWBD), 
	   .writeToMemoryEnableMD(writeToMemoryEnableMD),
	   .useInmediateED(useInmediateED),
	   .isScalarInstructionED(isScalarInstructionED),
	   .aluControlED(aluControlED),
	   .outFlagMD(outFlagMD)
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
	 .resultSelectorWBE(resultSelectorWBE), 
	 .takeBranchE(takeBranchE),
	 .isScalarInstructionED(isScalarInstructionED), 
	 .isScalarInstructionEE(isScalarInstructionEE),
	 .isScalarInstructionEM(isScalarInstructionEM), 
	 .isScalarInstructionEWB(isScalarInstructionEWB),
	 .isVectorScalarOperationED(isVectorScalarOperationED), 
	 .isVectorScalarOperationEE(isVectorScalarOperationEE),
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
	 .opcode(opcodeD)
	 );
	 	 
	 
	 // Decode - Execution Flip-Flop

	
	 flipflop  #(3*DATA_WIDTH+2*VECTOR_SIZE*DATA_WIDTH+3*REG_ADDRESS_WIDTH+OPCODE_WIDTH+15) 
	 DecodeFlipFlop(.clk(clock), .reset(flushE|reset), .enable(1'b1),
	 .in({reg1ScalarContentD, reg2ScalarContentD, inmediateD,
		 reg1VectorContentD, reg2VectorContentD,
		 regDestinationAddressWBD, reg1AddressD, reg2AddressD,
		 opcodeD,
		 resultSelectorWBD, writeEnableScalarWBD, writeEnableVectorWBD, aluControlED, writeToMemoryEnableMD,
		 useInmediateED, isScalarInstructionED, isVectorScalarOperationED, outFlagMD,
		 N1, Z1, V1, C1}), 
	 .out({reg1ScalarContentE, reg2ScalarContentE, inmediateE,
			 reg1VectorContentE, reg2VectorContentE,
			 regDestinationAddressWBE, reg1AddressE, reg2AddressE,
			 opcodeE,
			 resultSelectorWBE, writeEnableScalarWBE, writeEnableVectorWBE, aluControlEE, writeToMemoryEnableME,
			 useInmediateEE, isScalarInstructionEE, isVectorScalarOperationEE, outFlagME, 
			 N2, Z2, V2, C2}));
	 
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
	 .isVectorScalarOperation(isVectorScalarOperationEE),
	 .isScalarInstruction(isScalarInstructionEE),
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
		
	 assign NewPCF = executeOuputE[PC_WIDTH-1:0];

	 // Execution - Memory Flip-Flop
	 
  
	
	flipflop  #(2*DATA_WIDTH*VECTOR_SIZE+REG_ADDRESS_WIDTH+6) ExecuteFlipFlop(.clk(clock), .reset(reset), .enable(1'b1),
	 .in({executeOuputE, regDestinationAddressWBE, dataToWriteE, resultSelectorWBE, writeEnableScalarWBE, writeEnableVectorWBE, writeToMemoryEnableME, isScalarInstructionEE, outFlagME}), 
	 .out({executeOuputM, regDestinationAddressWBM, dataToWriteM, resultSelectorWBM, writeEnableScalarWBM, writeEnableVectorWBM, writeToMemoryEnableMM, isScalarInstructionEM, outFlagMM}));
	 
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

	 
 	flipflop  #(2*DATA_WIDTH*VECTOR_SIZE+REG_ADDRESS_WIDTH+5) MemoryFlipFlop(.clk(clock), .reset(reset), .enable(1'b1),
	 .in({memoryOutputM, executeOuputM, resultSelectorWBM, regDestinationAddressWBM, writeEnableScalarWBM, writeEnableVectorWBM, isScalarInstructionEM, outFlagMM}), 
	 .out({memoryOutputWB, executeOuputWB, resultSelectorWBWB, regDestinationAddressWBWB, writeEnableScalarWBWB, writeEnableVectorWBWB, isScalarInstructionEWB, outputFlagMWB}));

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
	assign out = memoryOutputWB;
	assign outFlag = outputFlagMWB; 
	 
	always @(posedge clock) begin
		$display("##FETCH##");
		$display("NewPCF %d ; TakeBranch: %b ; Enable/StallF: %b ; InstructionF : %b", NewPCF, takeBranchE, stallF, instructionF);
		$display("##HAZARDS##");
		$display("data1ScalarForwardSelectorE %b ; data2ScalarForwardSelectorE %b ; data1VectorForwardSelectorE: %b ; data2VectorForwardSelectorE: %b ; stallF: %b, stallD: %b, flushE: %b, flushD : %b", 
		data1ScalarForwardSelectorE, data2ScalarForwardSelectorE, data1VectorForwardSelectorE, data2VectorForwardSelectorE, stallF, stallD, flushE, flushD);
		$display("##DECODE##");
		$display("writeEnableScalarD %b,  writeEnableVectorD %b, 	 writeAddressD %b,	 writeScalarDataD %b,	 writeVectorDataD %b,	 instructionD %b,	 reg1ScalarContentD %b, reg2ScalarContentD %b, 	 inmediateD %b,	 reg1VectorContentD %b, 	 reg2VectorContentD %b,	 regDestinationAddressWBD %b, 	 reg1AddressD %b, 	 reg2AddressD %b,	 opcode %b",
		writeEnableScalarD,  writeEnableVectorD , 	 writeAddressD ,	 writeScalarDataD ,	 writeVectorDataD ,	 instructionD ,	 reg1ScalarContentD , reg2ScalarContentD, 	 inmediateD,	 reg1VectorContentD, 	 reg2VectorContentD ,	 regDestinationAddressWBD , 	 reg1AddressD , 	 reg2AddressD ,	 opcodeD);
		$display("##Control Unit##");
		$display("opcodeD %b,		isVectorScalarOperationED %b,	   resultSelectorWBD %b,	   writeEnableScalarWBD %b,	   writeEnableVectorWBD %b, 	   writeToMemoryEnableMD %b, useInmediateED %b,	   isScalarInstructionED %b,	   aluControlED %b,	   outFlagMD %b",
		opcodeD,		isVectorScalarOperationED,	   resultSelectorWBD,	   writeEnableScalarWBD,	   writeEnableVectorWBD, 	   writeToMemoryEnableMD, useInmediateED,	   isScalarInstructionED,	   aluControlED,	   outFlagMD);
		$display("##EXECUTE##");
		$display("reg1ScalarContentE %b, reg2ScalarContentE %b, 	 inmediateE %b,	 reg1VectorContentE %b, 	 reg2VectorContentE %b,	 aluControlEE %b,	 useInmediateEE %b,	 isVectorScalarOperationEE %b,	 isScalarInstructionEE %b,	 forwardWB %b, 	 forwardM %b,	 data1ScalarForwardSelectorE %b,	 data2ScalarForwardSelectorE %b,	 data1VectorForwardSelectorE %b,	 data2VectorForwardSelectorE %b ,	 executeOuputE %b,	 dataToWriteE %b,	 N1 %b, 	 Z1 %b, 	 V1 %b, 	 C1 %b", 
	   reg1ScalarContentE, reg2ScalarContentE, 	 inmediateE,	 reg1VectorContentE, 	 reg2VectorContentE,	 aluControlEE,	 useInmediateEE,	 isVectorScalarOperationEE,	 isScalarInstructionEE,	 forwardWB, 	 forwardM,	 data1ScalarForwardSelectorE,	 data2ScalarForwardSelectorE,	 data1VectorForwardSelectorE,	 data2VectorForwardSelectorE,	 executeOuputE,	 dataToWriteE,	 N1, 	 Z1, 	 V1, 	 C1	);	
		$display("##MEMORY##");
		$display("writeEnable %b readAddress %b writeAddress %b inputData %b outputData %b",
		writeToMemoryEnableMM, executeOuputM[DATA_WIDTH-1:0], executeOuputM[DATA_WIDTH-1:0], dataToWriteM, memoryOutputM);
		$display("-----------------------------------------------------------------------------------------------------------");
	end	
	 
endmodule

