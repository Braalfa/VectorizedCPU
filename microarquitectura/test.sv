`timescale 1 ns / 1 ns
module test();
	
	logic reset;
	logic clock;
	CPU CPU(clock, reset);
	
	integer i;
	initial 
	begin	
		reset = 1;
		clock = 0;
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
		#10;
		
		i = 0;
		while(i<3) begin
			clock = 1;
			#10			
			clock = 0;
			#10;
		end
	end
	
endmodule 