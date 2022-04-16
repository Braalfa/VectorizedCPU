module multiplicador #(parameter n = 5) (input signed [n-1:0] A, 
													  input signed [n-1:0] B, 
													  output reg [n-1:0] out,
													  output bit overflow,
													  output bit car);
	reg [2*n-2:0] multi;	
	assign car = 0;
	always_comb  begin
		multi = A*B;
		out[n-1:0] = multi[n-1:0];
		case (multi[2*n-2:n-1])
			{(n){1'b1}}: overflow = 0;
			{(n){1'b0}}: overflow = 0;
			default: overflow = 1;
		endcase
	end
endmodule
