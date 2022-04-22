module vectorFPMultiplier #(parameter DATA_WIDTH = 8, parameter LANES = 6)( 
				 input [LANES-1:0][DATA_WIDTH-1:0] operand1,
				 input [LANES-1:0][DATA_WIDTH-1:0] operand2,
				 output logic [LANES-1:0][DATA_WIDTH-1:0] out
			);

	always_comb begin 
		integer i;
		for(i = 0; i<LANES; i++) begin 
			out[i] = (operand1[i]*operand2[i])>>DATA_WIDTH;
		end
	end
endmodule