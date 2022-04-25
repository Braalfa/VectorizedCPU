module vectorFPMultiplier #(parameter DATA_WIDTH = 8, parameter LANES = 6)( 
				 input [LANES-1:0][DATA_WIDTH-1:0] operand1,
				 input [LANES-1:0][DATA_WIDTH-1:0] operand2,
				 output logic [LANES-1:0][DATA_WIDTH-1:0] out
			);

	logic [LANES-1:0][4*DATA_WIDTH-1:0] tempOut;
	always_comb begin 
		integer i;
		for(i = 0; i<LANES; i++) begin 
			tempOut[i] = (operand1[i]*operand2[i])>>10;
			out[i] = tempOut[i][DATA_WIDTH-1:0];
		end
	end
endmodule