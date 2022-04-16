module memory #(parameter MEM_SIZE = 4096, 
					 parameter DATA_WIDTH = 32,
					 parameter ADDRESS_WIDTH = 32 )(
			  input writeEnable, clk,
			  input logic [ADDRESS_WIDTH-1:0] readAddress, writeAddress,
			  input logic [DATA_WIDTH-1:0] inputData,
			  output logic [DATA_WIDTH-1:0] outputData
			);

	logic [DATA_WIDTH-1:0] RAM[MEM_SIZE-1:0];
	assign outputData = RAM[readAddress];

	initial
		$readmemb("data.txt", RAM);
		
	always_ff @(posedge clk)
		if (writeEnable) RAM[writeAddress] <= inputData;
endmodule 