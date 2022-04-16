module test_ALU();

	parameter WIDTH = 4;  
	logic [WIDTH-1:0] A;
	logic [WIDTH-1:0] B;
	logic [3:0] sel;
	logic [WIDTH-1:0] Out;
	logic [WIDTH-1:0] OutExpected;
	logic C, Z,V, N, CExpected,ZExpected,VExpected,NExpected;
	
	ALU #(.WIDTH( WIDTH)) Test(
    .A(A),
    .B(B),
	 .sel(sel),
    .Out(Out),
    .C(C),
	 .N(N),
	 .Z(Z),
	 .V(V)
   );
	
	
	
	initial 
	begin
		
		
		$display ("=============SUMADOR=============");
		sel = 4'b0000;
		
		
		A = 4'b0001;
		B = 4'b0001;
		OutExpected=4'b0010;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b1111;
		B = 4'b1110;
		OutExpected = 4'b1101;
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		CExpected=1;
		
		#10
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b0000;
		B = 4'b1110;
		OutExpected = 4'b1110;
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		CExpected=0;
		
		#10
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b1111;
		B = 4'b1111;
		OutExpected = 4'b1110;
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		CExpected=1;
		
		#10
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		
		$display ("=============RESTADOR=============");
		sel = 4'b0001;
		
		
		A = 4'b0001;
		B = 4'b0001;
		OutExpected=4'b0000;
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		CExpected=1;

		#10;		
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b1111;
		B = 4'b1110;
		OutExpected=4'b0001;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=1;

		#10;		
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b0000;
		B = 4'b1110;
		OutExpected=4'b0010;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;

		#10;		
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b1111;
		B = 4'b1111;
		OutExpected=4'b0000;
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		CExpected=1;

		#10;		
		
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		
		$display ("=============MULTIPLICADOR=============");
		
		sel = 4'b0010;
		
		A = 4'b0011;
		B = 4'b0010;
		OutExpected = 4'b0110;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		A = 4'b0010;
		B = 4'b0001;
		OutExpected = 4'b0010;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b0011;
		B = 4'b0010;
		OutExpected = 4'b0110;
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		CExpected=0;
		
		#10
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		A = 4'b0010;
		B = 4'b1000;
		OutExpected = 4'b0000;
		ZExpected=1;
		VExpected=1;
		NExpected=0;
		CExpected=0;
		
		#10
		assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
		else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
		$display ("=============DIVISION=============");
		
			sel = 4'b0011;
		
			A = 4'b0011 ; 
			B = 4'b0101 ; 
			OutExpected = 4'b0000 ; 
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=1;

		  #10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				  $display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));


			A = 4'b0011 ; 
			B = 4'b1111 ; 
			OutExpected = 4'b1101 ; 
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;
				  
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				  $display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));



			A = 4'b1101 ; 
			B = 4'b0111 ; 
			OutExpected = 4'b0000 ; 
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=1;

			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				  $display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));


			A = 4'b1000 ; 
			B = 4'b1111 ; 
			OutExpected = 4'b1000 ;  
			VExpected = 1 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;

			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				  $display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));
	
	
			$display ("=============MODULO=============");
			
			sel = 4'b0100;

			A = 4'b0000 ; 
			B = 4'b1100 ; 
			OutExpected = 4'b0000 ; 
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=1;

			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				 $display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));


			A = 4'b0011 ; 
			B = 4'b0010 ; 
			OutExpected = 4'b0001 ;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;

			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				 $display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			A = 4'b0100 ; 
			B = 4'b1000 ; 
			OutExpected = 4'b0100 ;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;

			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				 $display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			A = 4'b0111 ; 
			B = 4'b0110 ; 
			OutExpected = 4'b0001 ;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;

			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				 $display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			A = 4'b1101 ; 
			B = 4'b1010 ; 
			OutExpected = 4'b1101 ;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;

			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
			
			$display ("=============AND=============");
			
			
			
			A = 4'b0011; 
			B = 4'b0000; 
			OutExpected = 4'b0000;
			sel = 4'b0101;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=1;

			#10
    	   assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
                	$display ($sformatf("exito para A = %b, B = %b", A, B));
        	else $error($sformatf("fallo para A = %b, B = %b", A, B));
	
	
			A = 4'b0110; 
			B = 4'b1001; 
			OutExpected = 4'b0000;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=1;
			#10
    	   assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
                	$display ($sformatf("exito para A = %b, B = %b", A, B));
        	else $error($sformatf("fallo para A = %b, B = %b", A, B));

		
			A = 4'b1100; 
			B = 4'b1110; 
			OutExpected = 4'b1100;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			
			A = 4'b1111; 
			B = 4'b0001; 
			OutExpected = 4'b0001;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			
			$display ("=============OR=============");
			
			A = 4'b1011; 
			B = 4'b0000; 
			OutExpected = 4'b1011;
			sel = 4'b0110;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;

			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
			A = 4'b0010; 
			B = 4'b1000; 
			OutExpected = 4'b1010;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;

			#10
		   assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			
			A = 4'b0100; 
			B = 4'b1010; 
			OutExpected = 4'b1110;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;

			#10
		   assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			
			A = 4'b1111; 
			B = 4'b0001; 
			OutExpected = 4'b1111;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;

			#10
		   assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
				$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			
			$display ("=============XOR=============");
			
			A = 4'b0111; 
			B = 4'b1100; 
			OutExpected = 4'b1011;
			sel = 4'b0111;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));
		
		
			A = 4'b0010; 
			B = 4'b0110; 
			OutExpected = 4'b0100;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));
			
			A = 4'b0101; 
			B = 4'b0011; 
			OutExpected = 4'b0110;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));

			
			A = 4'b1111; 
			B = 4'b1011; 
			OutExpected = 4'b0100;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b, B = %b", A, B));
			else $error($sformatf("fallo para A = %b, B = %b", A, B));
			
			
			$display ("=============SHIFT-L=============");
			
			A = 4'b0101; 
			OutExpected = 4'b1010;
			sel = 4'b1000;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b", A));
			else $error($sformatf("fallo para A = %b", A));
		
			A = 4'b1100; 
			OutExpected = 4'b1000;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b", A));
			else $error($sformatf("fallo para A = %b", A));
			
			A = 4'b0100; 
			OutExpected = 4'b1000;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b", A));
			else $error($sformatf("fallo para A = %b", A));
			
			A = 4'b0110; 
			OutExpected = 4'b1100;
			VExpected = 0 ; 
			NExpected=1; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b", A));
			else $error($sformatf("fallo para A = %b", A));
		
			$display ("=============SHIFT-R=============");
			
			A = 4'b0101; 
			OutExpected = 4'b0010;
			sel = 4'b1001;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b", A));
			else $error($sformatf("fallo para A = %b", A));
		
			A = 4'b1100; 
			OutExpected = 4'b0110;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b", A));
			else $error($sformatf("fallo para A = %b", A));
			
			A = 4'b0100; 
			OutExpected = 4'b0010;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b", A));
			else $error($sformatf("fallo para A = %b", A));
			
			A = 4'b0110; 
			OutExpected = 4'b0011;
			VExpected = 0 ; 
			NExpected=0; 
			CExpected=0;
			ZExpected=0;
			#10
			assert (Out == OutExpected && CExpected == C && ZExpected == Z && VExpected == V && NExpected == N) 
					$display ($sformatf("exito para A = %b", A));
			else $error($sformatf("fallo para A = %b", A));
	end	
	
	
endmodule