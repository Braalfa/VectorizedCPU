module vectorAdderSubstractor #(parameter DATA_WIDTH = 19, parameter LANES = 6)( 
				 input [LANES-1:0][DATA_WIDTH-1:0] operand1,
				 input [LANES-1:0][DATA_WIDTH-1:0] operand2,
				 input operationMode,
				 output logic [LANES-1:0][DATA_WIDTH-1:0] out,
				 output [LANES-1:0] C, V, N
			);

	Adder_Substractor #(.WIDTH( DATA_WIDTH )) adderSubstractor1(
	operand1[0],operand2[0],out[0], operationMode,C[0],V[0]);

	Adder_Substractor #(.WIDTH( DATA_WIDTH )) adderSubstractor2(
	operand1[1],operand2[1],out[1], operationMode,C[1],V[1]);

	Adder_Substractor #(.WIDTH( DATA_WIDTH )) adderSubstractor3(
	operand1[2],operand2[2],out[2], operationMode,C[2],V[2]);

	Adder_Substractor #(.WIDTH( DATA_WIDTH )) adderSubstractor4(
	operand1[3],operand2[3],out[3], operationMode,C[3],V[3]);

	Adder_Substractor #(.WIDTH( DATA_WIDTH )) adderSubstractor5(
	operand1[4],operand2[4],out[4], operationMode,C[4],V[4]);
	
	Adder_Substractor #(.WIDTH( DATA_WIDTH )) adderSubstractor6(
	operand1[5],operand2[5],out[5], operationMode,C[5],V[5]);

	assign N[0] = out[0][DATA_WIDTH-1];
	assign N[1] = out[1][DATA_WIDTH-1];
	assign N[2] = out[2][DATA_WIDTH-1];
	assign N[3] = out[3][DATA_WIDTH-1];
	assign N[4] = out[4][DATA_WIDTH-1];
	assign N[5] = out[5][DATA_WIDTH-1];
	
endmodule
