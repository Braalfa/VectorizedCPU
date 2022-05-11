module testALU();
	parameter WIDTH = 48;
	logic [WIDTH-1:0] A;
	logic [WIDTH-1:0] B;
	logic [2:0] sel;
   logic [WIDTH-1:0] Out;
	
	logic [WIDTH-1:0] OutExpected;
	logic C, Z,V, N, CExpected,ZExpected,VExpected,NExpected;
	
	ALU #(.WIDTH(WIDTH)) ALU
	(	.A(A),
		.B(B),
		.sel(sel),
		.Out(Out),
		.N(N),
		.Z(Z),
		.V(V),
		.C(C)
		);
		
	initial begin
		$display ("=============ALU SUM=============");
		
		sel = 3'b000;
		
		
		A = 48'b1;
		B = 48'b1;
		OutExpected=48'b10;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("============= TEST 1 SUCCESS A = %b, B = %b =============", A, B));
		else $error($sformatf("=!=!=!=!=!=!== TEST 1 FAIL A = %b, B = %b. Result = %b =!=!=!=!=!=!", A, B, Out));
		
		
		A = 48'b1111;
		B = 48'b1110;
		OutExpected = 48'b11101;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("============= TEST 2 SUCCESS A = %b, B = %b =============", A, B));
		else $error($sformatf("=!=!=!=!=!=!== TEST 2 FAIL A = %b, B = %b. Result = %b =!=!=!=!=!=!", A, B, Out));
		
		
		A = 48'b0000;
		B = 48'b1110;
		OutExpected = 48'b1110;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("============= TEST 3 SUCCESS A = %b, B = %b =============", A, B));
		else $error($sformatf("=!=!=!=!=!=!== TEST 3 FAIL A = %b, B = %b. Result = %b =!=!=!=!=!=!", A, B, Out));
		
		
		A = 48'b1111;
		B = 48'b1111;
		OutExpected = 48'b11110;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("============= TEST 4 SUCCESS A = %b, B = %b =============", A, B));
		else $error($sformatf("=!=!=!=!=!=!== TEST 4 FAIL A = %b, B = %b. Result = %b =!=!=!=!=!=!", A, B, Out));
		
	end

endmodule