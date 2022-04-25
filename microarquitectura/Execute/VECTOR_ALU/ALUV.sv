module ALUV #(parameter DATA_WIDTH = 8, 
				parameter LANES = 6,
				parameter SELECTOR_SIZE = 3)
			( 
				 input [SELECTOR_SIZE-1:0] selector,
				 input [LANES-1:0][DATA_WIDTH-1:0] operand1,
				 input [LANES-1:0][DATA_WIDTH-1:0] operand2,
				 input logic [LANES-1:0] vectorMask,
				 output logic [LANES-1:0][DATA_WIDTH-1:0] out,
				 output logic [LANES-1:0] outComparison
			);

	logic [LANES-1:0][DATA_WIDTH-1:0] unfilteredOut;
	integer i;

	//=============SUMADOR - RESTADOR =============
	logic [LANES-1:0] C, V, N;
	logic [LANES-1:0][DATA_WIDTH-1:0] outSumadorRestador ;

	vectorAdderSubstractor #(.DATA_WIDTH(DATA_WIDTH), .LANES(LANES)) vectorAdderSubstractor(
				 .operand1(operand1),
				 .operand2(operand2),
				 .operationMode(selector[0]),
				 .out(outSumadorRestador),
				 .C(C), 
				 .V(V), 
				 .N(N)
			);

	//=============Multiplicador FP=============

	logic [LANES-1:0][DATA_WIDTH-1:0] outMultiplicadorFP ;

	vectorFPMultiplier #(.DATA_WIDTH(DATA_WIDTH), .LANES(LANES)) vectorFPMultiplier( 
				 .operand1(operand1),
				 .operand2(operand2),
				 .out(outMultiplicadorFP)
			);	

			
	always_comb begin  
		// Arithmetic output
      case (selector)  
			3'b000 : begin
				unfilteredOut = outSumadorRestador;
			end
			3'b001 : begin
				unfilteredOut = outSumadorRestador;
			end
			3'b010 : begin
				unfilteredOut = outMultiplicadorFP;
			end
			3'b110 : begin
				unfilteredOut = operand1;
			end
			3'b111 : begin
				unfilteredOut = operand2;				
			end
			default begin
				unfilteredOut = operand1;
			end
      endcase 
	
		// Comparison Output
      case (selector)  
			3'b011 : begin // LT
				outComparison = {N[5], N[4], N[3], N[2], N[1], N[0]};
			end
			default begin
				outComparison = 6'b000000;
			end
      endcase
	
		// Output filtering (according to mask)
		for(i=0; i< LANES; i++) begin
			if(vectorMask[i])
				out[i] = unfilteredOut[i];
			else
				out[i] = operand1[i];
		end
   end
	
endmodule
