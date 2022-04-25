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
module Decode #(parameter DATA_WIDTH = 19,
					parameter VECTOR_SIZE = 6,
					parameter SCALAR_REGNUM = 8, parameter VECTOR_REGNUM = 8, 
					parameter ADDRESS_WIDTH = 3, parameter OPCODE_WIDTH = 5, 
					parameter INSTRUCTION_WIDTH = 30)
	(input logic clock, reset, writeEnableScalar, writeEnableVector,
	 input logic [ADDRESS_WIDTH-1:0] writeAddress,
	 input logic [DATA_WIDTH-1:0] writeScalarData,
	 input logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] writeVectorData,
	 input logic [INSTRUCTION_WIDTH-1:0] instruction,
	 output logic [DATA_WIDTH-1:0] reg1ScalarContent, reg2ScalarContent, inmediate,
	 output logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] reg1VectorContent, reg2VectorContent,
	 output logic [ADDRESS_WIDTH-1:0] regDestinationAddress, reg1Address, reg2Address,
	 output logic [OPCODE_WIDTH-1:0] opcode,
	 input logic weMaskVector,
	 input logic resetMaskVector,
	 input logic [VECTOR_SIZE-1:0] maskVectorIn,	
	 output logic [VECTOR_SIZE-1:0] maskVectorOut
	 );
			
	assign reg1Address = instruction[21:19];
	assign reg2Address = instruction[18:16];
	assign regDestinationAddress = instruction[24:22];
	assign inmediate[18:0] = instruction[18:0];
	assign opcode = instruction[29:25];


	scalarRegFile #(.DATA_WIDTH(DATA_WIDTH), 
						 .REGNUM(SCALAR_REGNUM), 
						 .ADDRESSWIDTH(ADDRESS_WIDTH)
						 ) scalarRegFile
	(.clk(!clock),
	.we3(writeEnableScalar),
	.ra1(reg1Address), .ra2(reg2Address), .wa3(writeAddress),
   .wd3(writeScalarData),
	.rd1(reg1ScalarContent), .rd2(reg2ScalarContent));

	vectorRegFile #(.DATA_WIDTH(DATA_WIDTH), 
						 .REGNUM(VECTOR_REGNUM), 
						 .ADDRESSWIDTH(ADDRESS_WIDTH),
						 .VECTOR_SIZE(VECTOR_SIZE))
	vectorRegFile
	(.clk(!clock),
	.we3(writeEnableVector),
	.ra1(reg1Address), .ra2(reg2Address), .wa3(writeAddress),
   .wd3(writeVectorData),
	.rd1(reg1VectorContent), .rd2(reg2VectorContent),
	.weMaskVector(weMaskVector),
	.resetMaskVector(resetMaskVector || reset),
	.maskVectorIn(maskVectorIn),	
	.maskVectorOut(maskVectorOut));
	
endmodule