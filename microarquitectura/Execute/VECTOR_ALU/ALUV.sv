module ALUV #(parameter DATA_WIDTH = 8, 
				parameter LANES = 6,
				parameter SELECTOR_SIZE = 3)
			( 
				 input [SELECTOR_SIZE-1:0] selector,
				 input [LANES-1:0][DATA_WIDTH-1:0] operand1,
				 input [LANES-1:0][DATA_WIDTH-1:0] operand2,
				 output logic [DATA_WIDTH*LANES-1:0] out
			);


	//=============SUMADOR=============

	logic [LANES-1:0][DATA_WIDTH-1:0] outSumador;

	vectorAdder #(.DATA_WIDTH(DATA_WIDTH), .LANES(LANES)) vectorAdder( 
				 .operand1(operand1),
				 .operand2(operand2),
				 .out(outSumador)
			);	

	//=============Restador=============

	logic [LANES-1:0][DATA_WIDTH-1:0] outRestador;

	vectorSubstracter #(.DATA_WIDTH(DATA_WIDTH), .LANES(LANES)) vectorSubstracter( 
				 .operand1(operand1),
				 .operand2(operand2),
				 .out(outRestador)
			);	

	//=============Multiplicador=============

	logic [LANES-1:0][DATA_WIDTH-1:0] outMultiplicador ;

	vectorMultiplier #(.DATA_WIDTH(DATA_WIDTH), .LANES(LANES)) vectorMultiplier( 
				 .operand1(operand1),
				 .operand2(operand2),
				 .out(outMultiplicador)
			);	

	
	//=============Divisor=============

	logic [LANES-1:0][DATA_WIDTH-1:0] outDivisor;

	vectorDivider #(.DATA_WIDTH(DATA_WIDTH), .LANES(LANES)) vectorDivider( 
				 .operand1(operand1),
				 .operand2(operand2),
				 .out(outDivisor)
			);	
	
	//=============Multiplicador FP=============

	logic [LANES-1:0][DATA_WIDTH-1:0] outMultiplicadorFP ;

	vectorFPMultiplier #(.DATA_WIDTH(DATA_WIDTH), .LANES(LANES)) vectorFPMultiplier( 
				 .operand1(operand1),
				 .operand2(operand2),
				 .out(outMultiplicadorFP)
			);	
			
			
	always_comb begin  
      case (selector)  
			3'b000 : begin
				out = {outSumador[5], outSumador[4], outSumador[3], outSumador[2], outSumador[1], outSumador[0]};				
			end
			3'b001 : begin
				out = {outRestador[5], outRestador[4], outRestador[3], outRestador[2], outRestador[1], outRestador[0]};				
			end
			3'b010 : begin
				out = {outMultiplicador[5], outMultiplicador[4], outMultiplicador[3], outMultiplicador[2], outMultiplicador[1], outMultiplicador[0]};				
			end
			3'b011 : begin
				out = {outDivisor[5], outDivisor[4], outDivisor[3], outDivisor[2], outDivisor[1], outDivisor[0]};				
			end
			3'b100 : begin
				out = {outMultiplicadorFP[5], outMultiplicadorFP[4], outMultiplicadorFP[3], outMultiplicadorFP[2], outMultiplicadorFP[1], outMultiplicadorFP[0]};				
			end
			3'b101 : begin
				out = {operand1[5], operand1[4], operand1[3], operand1[2], operand1[1], operand1[0]};				
			end
			3'b110 : begin
				out = {operand2[5], operand2[4], operand2[3], operand2[2], operand2[1], operand2[0]};				
			end
			default begin
				out = {operand1[5], operand1[4], operand1[3], operand1[2], operand1[1], operand1[0]};
			end
      endcase 		
   end
	
endmodule