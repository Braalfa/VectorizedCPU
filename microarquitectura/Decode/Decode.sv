/*
	Instruction Decoding Module
	Inputs:
	- clock 
	- reset 
	- writeEnableScalar 
	- writeEnableVector
	- writeAddress
	- writeScalarData: data to write on the scalar register
	- writeVectorData: data to write on the vector register
	- instruction: current instruction
	- reg1ScalarContent: content 1 on scalar register
	- reg2ScalarContent: content 2 on scalar register
	- inmediate: inmediate obtained from instruction
	- reg1VectorContent: content 1 on vector register
	- reg2VectorContent: content 1 on vector register
	- regDestinationAddress: address to write data into (obtained from instruction)
	- reg1Address: address to read from 
	- reg2Address: address to read from
	- opcode: operation code
	
	Params: 
	- REGNUM: number of registers in regfile
	- WIDTH: width of the data
	- ADRESSWIDTH: size of the addresses in regfile
*/
module Decode #(parameter SCALAR_DATA_WIDTH = 48, parameter VECTOR_DATA_WIDTH = 8,
					parameter VECTOR_SIZE = 6,
					parameter SCALAR_REGNUM = 16, parameter VECTOR_REGNUM = 16, 
					parameter ADDRESS_WIDTH = 4, parameter OPCODE_WIDTH = 4, 
					parameter INSTRUCTION_WIDTH = 48)
	(input logic clock, reset, writeEnableScalar, writeEnableVector, isVectorScalarOperation,
	 input logic [ADDRESS_WIDTH-1:0] writeAddress,
	 input logic [SCALAR_DATA_WIDTH-1:0] writeScalarData,
	 input logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] writeVectorData,
	 input logic [INSTRUCTION_WIDTH-1:0] instruction,
	 output logic [SCALAR_DATA_WIDTH-1:0] reg1ScalarContent, reg2ScalarContent, inmediate,
	 output logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] reg1VectorContent, reg2VectorContent,
	 output logic [ADDRESS_WIDTH-1:0] regDestinationAddress, reg1Address, reg2Address,
	 output logic [OPCODE_WIDTH-1:0] opcode
	 );
		
	// Fix this according to how the instructions are built
	// assign reg1Address = instruction[15:12];
	// assign reg2Address = instruction[11:8];
	// assign regDestinationAddress = instruction[19:16];
	// assign inmediate[15:0] = instruction[15:0];
	// assign inmediate[WIDTH-1:16] = 0;
	// assign opcode = instruction[23:20];

	logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] tempReg2VectorContent;
	
	mux2 #(VECTOR_DATA_WIDTH*VECTOR_SIZE) reg2VectorContentMux(.d0(tempReg2VectorContent), 
	.d1({reg1ScalarContent[VECTOR_DATA_WIDTH-1:0],reg1ScalarContent[VECTOR_DATA_WIDTH-1:0], reg1ScalarContent[VECTOR_DATA_WIDTH-1:0], reg1ScalarContent[VECTOR_DATA_WIDTH-1:0], reg1ScalarContent[VECTOR_DATA_WIDTH-1:0], reg1ScalarContent[VECTOR_DATA_WIDTH-1:0]}), 
	.s(isVectorScalarOperation), 
	.y(reg2VectorContent));		

	scalarRegFile #(.DATA_WIDTH(SCALAR_DATA_WIDTH), 
						 .REGNUM(SCALAR_REGNUM), 
						 .ADDRESSWIDTH(ADDRESS_WIDTH)
						 ) scalarRegFile
	(.clk(!clock),
	.we3(writeEnableScalar),
	.ra1(reg1Address), .ra2(reg2Address), .wa3(writeAddress),
   .wd3(writeScalarData),
	.rd1(reg1ScalarContent), .rd2(reg2ScalarContent));

	vectorRegFile #(.DATA_WIDTH(VECTOR_DATA_WIDTH), 
						 .REGNUM(VECTOR_REGNUM), 
						 .ADDRESSWIDTH(ADDRESS_WIDTH),
						 .VECTOR_SIZE(VECTOR_SIZE))
	vectorRegFile
	(.clk(!clock),
	.we3(writeEnableVector),
	.ra1(reg1Address), .ra2(reg2Address), .wa3(writeAddress),
   .wd3(writeVectorData),
	.rd1(reg1VectorContent), .rd2(tempReg2VectorContent));
	
endmodule