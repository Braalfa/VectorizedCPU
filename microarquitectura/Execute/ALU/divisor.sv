//AAAAAAAAAAAAAAAAAAAAAA
module divisor #(parameter n = 5) (input signed [n-1:0] A, 
													  input signed [n-1:0] B, 
													  output reg [n-1:0] out,
 													  output bit overflow,
													  output bit car);
	reg [n:0] div;	
	assign car = 0;
	always_comb  begin
		div = A/B;
		out = div[n-1:0];
		case (div[n:n-1])
			1'b01: overflow = 1;
			default: overflow = 0;
		endcase
	end
endmodule
