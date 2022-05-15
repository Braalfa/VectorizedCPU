
/*

	Modulo de memoria: Cada elemento de memoria es un vector.

	parameters
	- MEM_SIZE: Tamano de la memoria
	- DATA_INTEGER_WIDTH: Tamano de cada dato
	- ADDRESS_WIDTH: Tamano de las direcciones
	inputs:
	- 
	outputs:
	- 
*/
module memory #(parameter MEM_SIZE = 35000, 
					 parameter DATA_INTEGER_WIDTH = 8,
					 parameter DATA_WIDTH = 32,
					 parameter ADDRESS_WIDTH = 32 )(
			  input writeEnable, clk,
			  input logic [ADDRESS_WIDTH-1:0] readAddress, writeAddress,
			  input logic [DATA_WIDTH-1:0] inputData,
			  output logic [DATA_WIDTH-1:0] outputData
			);

	logic [DATA_INTEGER_WIDTH-1:0] RAM[MEM_SIZE-1:0];
	logic [DATA_INTEGER_WIDTH-1:0] tempOutputData;
	
	initial
		$readmemb("C://Users//Alejandro//Documents//Development//VectorizedCPU//microarquitectura//Memory//data.txt", RAM);
	
	always_comb begin
		tempOutputData = RAM[readAddress];
		outputData = {1'b0,tempOutputData[47:40],{11{1'b0}}, tempOutputData[39:32],{11{1'b0}},tempOutputData[31:24],{11{1'b0}},tempOutputData[23:16],{11{1'b0}},tempOutputData[15:8],{11{1'b0}},tempOutputData[7:0], {10{1'b0}}};
	end
	
	always_ff @(posedge clk)
		if (writeEnable) RAM[writeAddress] <= {inputData[112:105], inputData[93:86], inputData[74:67], inputData[55:48], inputData[36:29], inputData[17:10]};
endmodule 