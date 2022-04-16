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
module Execute #(parameter SCALAR_DATA_WIDTH = 32,
					 parameter VECTOR_DATA_WIDTH = 8,
					 parameter VECTOR_SIZE = 6, 
					 parameter REGNUM = 16)
	(input logic [SCALAR_DATA_WIDTH-1:0] scalarData1, scalarData2,
	 input logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] vectorOperand1, vectorOperand2,
	 input [2:0] aluControl, 
	 input isScalarInstruction,
	 output logic [SCALAR_DATA_WIDTH-1:0] out,
	 output logic N, Z, V, C
	 );		
	
	logic [SCALAR_DATA_WIDTH-1:0] vectorOut;
	logic [SCALAR_DATA_WIDTH-1:0] scalarOut;
	
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
		 .B(scalarData2),
		 .sel(aluControl),
		 .Out(scalarOut),
		 .N(N),
		 .Z(Z),
		 .V(V),
		 .C(C) 
	);
	
	mux2 #(SCALAR_DATA_WIDTH) executeOutputMux(.d0(vectorOut), .d1(scalarOut), .s(isScalarInstruction), .y(out));

		
endmodule

