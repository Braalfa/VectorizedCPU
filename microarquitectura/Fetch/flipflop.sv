/**
	Resetable Flip Flop module 
	Inputs:
	- in: input to save
   - clock: the clock
	- WIDTH: size of the value stored
	- reset: resets the stored value to 0
	Outputs:
 	- out: current saved value
**/
module flipflop #(parameter WIDTH = 8)
	(input logic clk, reset, enable,
	input logic [WIDTH-1:0] in,
	output logic [WIDTH-1:0] out);	
		
	always_ff @(posedge clk) begin
		if (reset) out <= 0;
		else if(enable) out <= in;
	end
endmodule