module shiftR_modulo #(parameter n = 5) (input logic[n-1:0] A, 
												  output logic [n-1:0] out,
												  output bit overflow,
												  output bit car);
	assign car = 0;
	assign overflow = 0;
	always_comb  begin
		out = A >> 1;
	end
endmodule
