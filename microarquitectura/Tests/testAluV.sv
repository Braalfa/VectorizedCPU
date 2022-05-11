module testAluV();

	parameter DATA_WIDTH = 8;
	parameter LANES = 6;
	parameter SELECTOR_SIZE = 3;
	
		
	logic [SELECTOR_SIZE-1:0] selector;
	logic [LANES-1:0][DATA_WIDTH-1:0] operand1;
	logic [LANES-1:0][DATA_WIDTH-1:0] operand2;
	logic [LANES-1:0] vectorMask;
	logic [LANES-1:0][DATA_WIDTH-1:0] out;
	logic [LANES-1:0] outComparison;
	
	ALUV #(.DATA_WIDTH(DATA_WIDTH),
			 .LANES(LANES), 
			 .SELECTOR_SIZE(SELECTOR_SIZE)) ALUV
			 (	.selector(selector),
				.operand1(operand1),
				.operand2(operand2),
				.vectorMask(vectorMask),
				.out(out),
				.outComparison(outComparison)
		);
		
	initial begin
		$display ("=============ALU V SUM=============");
		
		selector = 3'b0;
		
		operand1[0] = 8'b1;
		operand1[1] = 8'b0;
		operand1[2] = 8'b0;
		operand1[3] = 8'b0;
		operand1[4] = 8'b0;
		operand1[5] = 8'b0;
		operand1[6] = 8'b0;
		
		operand2[0] = 8'b10;
		operand2[1] = 8'b10;
		operand2[2] = 8'b10;
		operand2[3] = 8'b10;
		operand2[4] = 8'b10;
		operand2[5] = 8'b10;
		operand2[6] = 8'b10;
		
		#10;
	
	end

endmodule