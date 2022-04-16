/*
	Execution Module
	Inputs:
	
	Outputs:
	- aluOutput: 
	- N, Z, V, C: alu flags
	
	Params: 
	- WIDTH: width of the data
*/

module Execute #(parameter SCALAR_DATA_WIDTH = 48,
					 parameter VECTOR_DATA_WIDTH = 8,
					 parameter VECTOR_SIZE = 6)
	(input logic [SCALAR_DATA_WIDTH-1:0] scalarData1, scalarData2, scalarInmediate,
	 input logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] vectorOperand1, vectorOperand2,
	 input [2:0] aluControl,
	 input useInmediate,
	 input isScalarInstruction, writeScalar,
	 input logic [SCALAR_DATA_WIDTH-1:0]  forwardWB, forwardM,
	 input logic [1:0] data1ScalarForwardSelector, data2ScalarForwardSelector,
	 input logic [1:0] data1VectorForwardSelector, data2VectorForwardSelector,
	 output logic [SCALAR_DATA_WIDTH-1:0] out,
	 output logic [SCALAR_DATA_WIDTH-1:0] dataToWrite,
	 output logic N, Z, V, C
	 );		
	
	logic [SCALAR_DATA_WIDTH-1:0] vectorOut;
	logic [SCALAR_DATA_WIDTH-1:0] scalarOut;
	
	logic [SCALAR_DATA_WIDTH-1:0] scalarData1AfterForward;
	logic [SCALAR_DATA_WIDTH-1:0] scalarData2AfterForward;
	logic [SCALAR_DATA_WIDTH-1:0] scalarData2Final;
	
	mux3  #(SCALAR_DATA_WIDTH) scalarData1ForwardMUX(scalarData1, forwardWB, forwardM, 
									data1ScalarForwardSelector, scalarData1AfterForward);	
									
	mux3  #(SCALAR_DATA_WIDTH) scalarData2ForwardMUX(scalarData2, forwardWB, forwardM, 
									data2ScalarForwardSelector, scalarData2AfterForward);	
	
	mux2  #(SCALAR_DATA_WIDTH) inmediateMux(scalarData2AfterForward, 
				scalarInmediate, useInmediate, scalarData2Final);
	
	logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] vectorData1AfterForward;
	logic [VECTOR_SIZE-1:0][VECTOR_DATA_WIDTH-1:0] vectorData2AfterForward;
	
	mux3  #(SCALAR_DATA_WIDTH) vectorData1ForwardMUX(vectorOperand1,forwardWB, forwardM, 
									data1VectorForwardSelector, vectorData1AfterForward);	
									
	mux3  #(SCALAR_DATA_WIDTH) vectorData2ForwardMUX(vectorOperand2, forwardWB, forwardM, 
									data2VectorForwardSelector, vectorData2AfterForward);	

	
	ALUV #(.DATA_WIDTH(VECTOR_DATA_WIDTH), 
			 .LANES(VECTOR_SIZE)) ALUV
			( 
				 .selector(aluControl),
				 .operand1(vectorData1AfterForward),
				 .operand2(vectorData2AfterForward),
				 .out(vectorOut)
			);
			
	ALU #(SCALAR_DATA_WIDTH) ALU( 
		 .A(scalarData1AfterForward),
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

