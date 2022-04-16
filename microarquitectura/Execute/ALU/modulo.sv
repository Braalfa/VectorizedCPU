module modulo #(parameter n = 5) (input signed [n-1:0] A, 
													  input signed [n-1:0] B, 
													  output reg [n-1:0] out,
													  output bit overflow,
													  output bit car);
	assign car = 0;
	assign overflow = 0;
	always_comb  begin
		out = A%B;
	end
endmodule
