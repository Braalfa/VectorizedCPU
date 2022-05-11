module testCondUnit();
	parameter OPCODE_WIDTH = 5;
	logic [OPCODE_WIDTH-1:0] opcodeE;
	logic N, Z, V, C;
	logic takeBranchE;
	
	logic expected_takeBranchE;
	
	condunit #(.OPCODEWIDTH(OPCODE_WIDTH)) condunit
	(	.opcodeE(opcodeE),
		.N(N),
		.Z(Z),
		.V(V),
		.C(C),
		.takeBranchE(takeBranchE)
		);
	
	initial begin
		$display ("=============CONDITIONAL UNIT TEST=============");
		
		$display ("=============EQ=============");
		opcodeE = 5'b01111;
		
		Z = 1;
		expected_takeBranchE = 1;
		
		#10
		
		assert (expected_takeBranchE == takeBranchE) 
			begin
				$display ("=============EQ TEST 1 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST EQ 1 FAIL -!=!=!=!=!=!=!"));
		
		Z = 0;
		expected_takeBranchE = 0;
		
		#10
		
		assert (expected_takeBranchE == takeBranchE) 
			begin
				$display ("=============EQ TEST 2 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST EQ 2 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============GEQ=============");
		opcodeE = 5'b01110;
		
		N = 1;
		V = 1;
		expected_takeBranchE = 1;
		
		#10
		
		assert (expected_takeBranchE == takeBranchE) 
			begin
				$display ("=============GEQ TEST 1 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST GEQ 1 FAIL -!=!=!=!=!=!=!"));
		
		N = 0;
		V = 0;
		expected_takeBranchE = 1;
		
		#10
		
		assert (expected_takeBranchE == takeBranchE) 
			begin
				$display ("=============GEQ TEST 2 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST GEQ 2 FAIL -!=!=!=!=!=!=!"));
		
		N = 1;
		V = 0;
		expected_takeBranchE = 0;
		
		#10
		
		assert (expected_takeBranchE == takeBranchE) 
			begin
				$display ("=============GEQ TEST 3 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST GEQ 3 FAIL -!=!=!=!=!=!=!"));
		
		N = 0;
		V = 1;
		expected_takeBranchE = 0;
		
		#10
		
		assert (expected_takeBranchE == takeBranchE) 
			begin
				$display ("=============GEQ TEST 4 SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST GEQ 4 FAIL -!=!=!=!=!=!=!"));
		
		$display ("=============JMP=============");
		opcodeE = 5'b10000;
		
		expected_takeBranchE = 1;
		
		#10
		
		assert (expected_takeBranchE == takeBranchE) 
			begin
				$display ("=============JMP TEST SUCCESS=============");
			end
		else $error($sformatf("-!=!=!=!=!=!=! TEST JMP FAIL -!=!=!=!=!=!=!"));
		
	end


endmodule