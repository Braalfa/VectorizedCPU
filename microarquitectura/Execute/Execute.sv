/*
	Execution Module
	Inputs:
	- data1, data2
	- aluControl: alu operation mode
	
	Outputs:
	- aluOutput: 
	- N, Z, V, C: alu flags
	
	Params: 
	- WIDTH: width of the data
*/

/*
	todo: write scalar
*/
module Execute #(parameter SCALAR_DATA_WIDTH = 48,
					 parameter VECTOR_DATA_WIDTH = 8,
					 parameter VECTOR_SIZE = 6)
	(input logic [SCALAR_DATA_WIDTH-1:0] scalarData1, scalarData2, scalarInmediate,
	 input logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] vectorOperand1, vectorOperand2,
	 input [2:0] aluControl,
	 input useInmediate,
	 input isScalarInstruction, writeScalar,
	 output logic [SCALAR_DATA_WIDTH-1:0] out,
	 output logic [SCALAR_DATA_WIDTH-1:0] dataToWrite,
	 output logic N, Z, V, C
	 );		
	
	logic [SCALAR_DATA_WIDTH-1:0] vectorOut;
	logic [SCALAR_DATA_WIDTH-1:0] scalarOut;
	logic [SCALAR_DATA_WIDTH-1:0] scalarData2Final;
	
	mux2  #(SCALAR_DATA_WIDTH) MUX(scalarData2, 
				scalarInmediate, useInmediate, scalarData2Final);

	
	ALUV #(.DATA_WIDTH(VECTOR_DATA_WIDTH), 
			 .LANES(VECTOR_SIZE)) ALUV
			( 
				 .selector(aluControl),
				 .operand1(vectorOperand1),
				 .operand2(vectorOperand2),
				 .out(vectorOut)
			);
			
	ALU #(SCALAR_DATA_WIDTH) ALU( 
		 .A(scalarData1),
		 .B(scalarData2Final),
		 .sel(aluControl),
		 .Out(scalarOut),
		 .N(N),
		 .Z(Z),
		 .V(V),
		 .C(C) 
	);
	
	mux2 #(SCALAR_DATA_WIDTH) executeOutputMux(.d0(vectorOut), .d1(scalarOut), .s(isScalarInstruction), .y(out));		
	mux2 #(SCALAR_DATA_WIDTH) dataToWriteMux(
	.d0({vectorOperand2[5], vectorOperand2[4], vectorOperand2[3], vectorOperand2[2], vectorOperand2[1], vectorOperand2[0]}), 
	.d1(scalarData2Final), .s(writeScalar), .y(dataToWrite));		
endmodule

