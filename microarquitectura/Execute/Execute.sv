/*
	Execution Module
	Inputs:
	- scalarData1: dato escalar 1
	- scalarData2: dato escalar 2
	- scalarInmediate: dato escalar inmediato
	- vectorOperand1: dato vectorial 1
	- vectorOperand2: dato vectorial 2
	- aluControl: variable de control, indica la operacion de las alus (un mismo codigo pueden ser operaciones diferentes en cada alu)
	- useInmediate: variable de control, indica si usar inmediato en lugar de dato escalar 2
	- isScalarInstruction: variable de control, indica si tomar el resultado de la alu escalar (1) o la alu vectorial (0)
	- forwardWB: dato adelantado desde el Write Back, puede ser escalar (se toman solo bits iniciales) o vectorial (se realiza una conversion de formato)
	- forwardM: dato adelantado desde Memoria, puede ser escalar (se toman solo bits iniciales) o vectorial (se realiza una conversion de formato)
	- data1ScalarForwardSelector: variable de modulo de hazard, indica como y de donde adelantar el dato escalar 1 si corresponde
	- data2ScalarForwardSelector: variable de modulo de hazard, indica como y de donde adelantar el dato escalar 2 si corresponde
	- data1VectorForwardSelector: variable de modulo de hazard, indica como y de donde adelantar el dato vectorial 1 si corresponde
	- data2VectorForwardSelector: variable de modulo de hazard, indica como y de donde adelantar el dato vectorial 2 si corresponde
	Outputs:
	- out: salida del execute, es la salida de alguna de las dos alus
	- dataToWrite: dato a escribir en memoria (es el segundo operando )
	- N, Z, V, C: flags de alu escalar
	writeScalar
	Params: 
	- DATA_WIDTH: Ancho de los datos escalares y vectoriales
	- VECTOR_SIZE: Cantidad de datos en los vectores
*/

module Execute #(parameter DATA_WIDTH = 8,
					 parameter VECTOR_SIZE = 6)
	(input logic [DATA_WIDTH-1:0] scalarData1, scalarData2, scalarInmediate,
	 input logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] vectorOperand1, vectorOperand2,
	 input [2:0] aluControl,
	 input useInmediate,
	 input useScalarAlu,
	 input isScalarReg2,
	 input logic [DATA_WIDTH*VECTOR_SIZE-1:0]  forwardWB, forwardM,
	 input logic [1:0] data1ScalarForwardSelector, data2ScalarForwardSelector,
	 input logic [1:0] data1VectorForwardSelector, data2VectorForwardSelector,
	 output logic [DATA_WIDTH*VECTOR_SIZE-1:0] out,
	 output logic [DATA_WIDTH*VECTOR_SIZE-1:0] dataToWrite,
	 output logic N, Z, V, C
	 );		
	
	logic [DATA_WIDTH*VECTOR_SIZE-1:0] vectorOut;
	logic [DATA_WIDTH-1:0] scalarOut;
	
	logic [DATA_WIDTH-1:0] scalarData1AfterForward;
	logic [DATA_WIDTH-1:0] scalarData2AfterForward;
	logic [DATA_WIDTH-1:0] scalarData2Final;
	
	mux3  #(DATA_WIDTH) scalarData1ForwardMUX(scalarData1, forwardWB[DATA_WIDTH-1:0], forwardM[DATA_WIDTH-1:0], 
									data1ScalarForwardSelector, scalarData1AfterForward);	
									
	mux3  #(DATA_WIDTH) scalarData2ForwardMUX(scalarData2, forwardWB[DATA_WIDTH-1:0], forwardM[DATA_WIDTH-1:0], 
									data2ScalarForwardSelector, scalarData2AfterForward);	
	
	mux2  #(DATA_WIDTH) inmediateMux(scalarData2AfterForward, 
				scalarInmediate, useInmediate, scalarData2Final);
	
	logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] vectorData1AfterForward;
	logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] vectorData2AfterForward;
	logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] vectorData2Final;

	mux3  #(DATA_WIDTH*VECTOR_SIZE) vectorData1ForwardMUX(vectorOperand1,forwardWB, forwardM, 
									data1VectorForwardSelector, vectorData1AfterForward);	
									
	mux3  #(DATA_WIDTH*VECTOR_SIZE) vectorData2ForwardMUX(vectorOperand2, forwardWB, forwardM, 
									data2VectorForwardSelector, vectorData2AfterForward);	

	
	mux2 #(DATA_WIDTH*VECTOR_SIZE) vectorData2ScalarMux(.d0(vectorData2AfterForward), 
	.d1({scalarData2Final,scalarData2Final, scalarData2Final, scalarData2Final, scalarData2Final, scalarData2Final}), 
	.s(isScalarReg2), 
	.y(vectorData2Final));		

	
	ALUV #(.DATA_WIDTH(DATA_WIDTH), 
			 .LANES(VECTOR_SIZE)) ALUV
			( 
				 .selector(aluControl),
				 .operand1(vectorData1AfterForward),
				 .operand2(vectorData2Final),
				 .out(vectorOut)
			);
			
	ALU #(DATA_WIDTH) ALU( 
		 .A(scalarData1AfterForward),
		 .B(scalarData2Final),
		 .sel(aluControl),
		 .Out(scalarOut),
		 .N(N),
		 .Z(Z),
		 .V(V),
		 .C(C) 
	);
	
	mux2 #(DATA_WIDTH*VECTOR_SIZE) executeOutputMux(.d0(vectorOut), .d1({{DATA_WIDTH*(VECTOR_SIZE-1){1'b0}}, scalarOut}), .s(useScalarAlu), .y(out));		
	assign dataToWrite = {vectorData2AfterForward[5], vectorData2AfterForward[4], vectorData2AfterForward[3], vectorData2AfterForward[2], vectorData2AfterForward[1], vectorData2AfterForward[0]}; 
endmodule

