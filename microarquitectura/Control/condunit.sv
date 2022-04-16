module condunit #(parameter OPCODEWIDTH = 4)
	(input logic [OPCODEWIDTH-1:0] opcodeE,
	input logic N, Z, V, C,
	output logic takeBranchE
	);
		
	always_comb
		case(opcodeE)
			4'b1011: takeBranchE = Z; // EQ
			4'b1101: takeBranchE = N!=V; // LT
			4'b1100: takeBranchE = 1'b1; // ??
			4'b1111: takeBranchE = 1'b1; // ??
			default: takeBranchE = 1'b0; // 0
		endcase
	
endmodule 
					