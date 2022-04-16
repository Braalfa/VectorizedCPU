/*
	hazardsUnit
	Inputs:
	-
	Outputs:
	-
*/

		
module hazardsUnit #(parameter ADDRESSWIDTH = 4)
	(input logic writeEnableScalarWBD, writeEnableVectorWBD, writeToMemoryEnableMD, resultSelectorWBE, takeBranchE,
	input logic isScalarInstructionED, isScalarInstructionEE, isScalarInstructionEM, isScalarInstructionEWB,
	input logic isVectorScalarOperationDD, isVectorScalarOperationDE,
	input logic [ADDRESSWIDTH-1:0] writeAddressM, writeAddressWB, writeAddressE,
	reg1ReadAddressE, reg2ReadAddressE, reg1ReadAddressD, reg2ReadAddressD,
	output logic [1:0] data1ScalarForwardSelectorE, data2ScalarForwardSelectorE,
	output logic [1:0] data1VectorForwardSelectorE, data2VectorForwardSelectorE,
	output logic stallF, stallD, flushE, flushD);
	
	logic LDRstall;
	logic Match_12D_E_Scalar;
	logic Match_12D_E_Vector;
	
	always_comb begin
		// Forwarding
		
		// Scalar forwarding
		data1ScalarForwardSelectorE = 2'b00;
		data2ScalarForwardSelectorE = 2'b00;
		if(writeEnableScalarWBD) begin 
			if (reg1ReadAddressE == writeAddressWB && isScalarInstructionEE && isScalarInstructionEWB) begin
				data1ScalarForwardSelectorE = 2'b01;
			end
			if (reg2ReadAddressE == writeAddressWB 
				&& (isScalarInstructionEE || isVectorScalarOperationDE)
				&& isScalarInstructionEWB) begin
				data2ScalarForwardSelectorE = 2'b01;
			end
		end 
		
		if(writeToMemoryEnableMD) begin 
			if(reg1ReadAddressE == writeAddressM && isScalarInstructionEE && isScalarInstructionEM) begin
			data1ScalarForwardSelectorE = 2'b10;
			end 
			if (reg2ReadAddressE == writeAddressM 
				&& (isScalarInstructionEE || isVectorScalarOperationDE)
				&& isScalarInstructionEM) begin
			data2ScalarForwardSelectorE = 2'b10;
			end
		end 
		
		// Vector forwarding
		data1VectorForwardSelectorE = 2'b00;
		data2VectorForwardSelectorE = 2'b00;
		if(writeEnableVectorWBD) begin 
			if (reg1ReadAddressE == writeAddressWB && !isScalarInstructionEE && !isScalarInstructionEWB) begin
				data1VectorForwardSelectorE = 2'b01;
			end
			if (reg2ReadAddressE == writeAddressWB 
				&& (!isScalarInstructionEE && !isVectorScalarOperationDE)
				&& !isScalarInstructionEWB) begin
				data2VectorForwardSelectorE = 2'b01;
			end
		end 
		
		if(writeToMemoryEnableMD) begin 
			if(reg1ReadAddressE == writeAddressM && !isScalarInstructionEE && !isScalarInstructionEM) begin
			data1VectorForwardSelectorE = 2'b10;
			end 
			if (reg2ReadAddressE == writeAddressM 
				&& (!isScalarInstructionEE && !isVectorScalarOperationDE)
				&& !isScalarInstructionEM) begin
			data2VectorForwardSelectorE = 2'b10;
			end
		end 
		
		
		// Stalls on Load and Branching
		
		Match_12D_E_Scalar = (reg1ReadAddressD == writeAddressE && isScalarInstructionED && isScalarInstructionEE) 
									|| (reg2ReadAddressD == writeAddressE && (isScalarInstructionED || isVectorScalarOperationDD) && isScalarInstructionEE);
		
		Match_12D_E_Vector = (reg1ReadAddressD == writeAddressE && !isScalarInstructionED && !isScalarInstructionEE) 
								    || (reg2ReadAddressD == writeAddressE && (!isScalarInstructionED && !isVectorScalarOperationDD) && !isScalarInstructionEE);

		LDRstall = (Match_12D_E_Scalar || Match_12D_E_Vector) && resultSelectorWBE;
		
		stallD = LDRstall;
		stallF = LDRstall;
		flushE = LDRstall || takeBranchE;
		flushD = takeBranchE;
	end
	
endmodule