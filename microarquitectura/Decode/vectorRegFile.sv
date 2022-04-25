
/**
	Vector register module 
	Inputs:
	- ra1 and ra2 indicate de registers to be read
   - we3 indicates whether to write into the registers
	- wa3 indicates the register on which to write
	- wd3 : the data to write
	Outputs:
 	- rd1 and rd2 provide the requested registers value
	Params:
	- REGNUM: number of registers
	- DATA_WIDTH: width of each register
	- ADRESSWIDTH: size of the addresses
**/

module vectorRegFile #(parameter DATA_WIDTH = 8, parameter VECTOR_SIZE = 6, parameter REGNUM = 16, parameter ADDRESSWIDTH = 4)
	(input logic clk,
	input logic we3,
	input logic [ADDRESSWIDTH-1:0] ra1, ra2, wa3,
	input logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] wd3,
	output logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0]rd1, rd2,
	input logic weMaskVector,
	input logic resetMaskVector,
	input logic [VECTOR_SIZE-1:0] maskVectorIn,	
	output logic [VECTOR_SIZE-1:0] maskVectorOut);
	
	logic [VECTOR_SIZE-1:0][DATA_WIDTH-1:0] registers[REGNUM-1:0];
	logic [VECTOR_SIZE-1:0] maskVector;
	
	always_ff @(posedge clk) begin
		if (we3) registers[wa3] <= wd3;
		if(resetMaskVector) begin
			maskVector <= {VECTOR_SIZE{1'b1}};
		end
		if (weMaskVector) begin
			maskVector <= maskVectorIn;
		end
	end
	
	always_comb begin
		rd1 = registers[ra1];
		rd2 = registers[ra2];
		maskVectorOut = maskVector;
	end
endmodule