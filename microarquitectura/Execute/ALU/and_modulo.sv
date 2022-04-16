module and_modulo #(parameter n = 5) (input [n-1:0] A, 
												  input [n-1:0] B, 
												  output reg [n-1:0] out,
												  output bit overflow,
												  output bit car);
	assign car = 0;
	assign overflow = 0;
	reg [n:0] i;	
	always_comb  begin
		for(i = 0; i < n; i = i + 1) begin
			out[i] = A[i]&&B[i];
		end
	end
endmodule
