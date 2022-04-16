module ALUV #(parameter DATA_WIDTH = 8, 
				parameter LANES = 6,
				parameter SELECTOR_SIZE = 2)
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
	
			
	always_comb begin  
      case (selector)  
			2'b00 : begin
				out = {outSumador[0], outSumador[1], outSumador[2], outSumador[3], outSumador[4], outSumador[5]};				
			end
			2'b01 : begin
				out = {outRestador[0], outRestador[1], outRestador[2], outRestador[3], outRestador[4], outRestador[5]};				
			end
			2'b10 : begin
				out = {outMultiplicador[0], outMultiplicador[1], outMultiplicador[2], outMultiplicador[3], outMultiplicador[4], outMultiplicador[5]};				
			end
			2'b11 : begin
				out = {outDivisor[0], outDivisor[1], outDivisor[2], outDivisor[3], outDivisor[4], outDivisor[5]};				
			end
      endcase 		
   end
	
endmodule