/*
	Adder
	Inputs
	- a
	- b
	Outputs
	- out = a + b
*/
module adder #(parameter WIDTH = 8)
	(input logic [WIDTH-1:0] a, b,
	output logic [WIDTH-1:0] out);
	assign out = a + b;
endmodule