`timescale 1 ns / 1 ns
module testCPU();
	
	parameter DATA_WIDTH = 19; 
	parameter INSTRUCTION_WIDTH = 30;
	parameter VECTOR_SIZE = 6; 
	parameter PC_WIDTH = 32;
	parameter SCALAR_REGNUM = 8; 
	parameter VECTOR_REGNUM = 8;
	parameter REG_ADDRESS_WIDTH = 3; 
	parameter OPCODE_WIDTH = 5;
	parameter OUTPUT_WIDTH = 8;
	logic reset;
	logic clock;
	logic outFlag;
	logic [VECTOR_SIZE*OUTPUT_WIDTH-1:0] out;	
	
	
	CPU CPU(clock, reset, out, outFlag);
	
	integer OutFile;
	integer i;
	
	initial begin	
	
		OutFile = $fopen("C://Users//Alejandro//Documents//Development//VectorizedCPU//microarquitectura//outfile.img");
		reset = 1;
		clock = 0;
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
		#10;
		
		i = 0;
		while(i<200000) begin
		   i += 1;
			clock = 1;
			#1	
		
			if(outFlag) begin 
				$fdisplay(OutFile,"%b", out);
			end
				
			clock = 0;
			#1;
		end
	end
	
endmodule 