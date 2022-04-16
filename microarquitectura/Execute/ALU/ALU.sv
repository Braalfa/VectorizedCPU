module ALU #(parameter WIDTH = 16)( 
    input [WIDTH-1:0] A,
	 input [WIDTH-1:0] B,
	 input [2:0] sel,
    output logic [WIDTH-1:0] Out,
	 output logic N,
	 output logic Z,
	 output logic V,
	 output logic C 
);


	//=============SUMADOR=============

	logic [WIDTH-1:0] OutSumador;
	logic CSumador,VSumador;

	Adder_Substractor #(.WIDTH( WIDTH )) Sumador(A,B,OutSumador,sel[0],CSumador,VSumador);
	
	//=============AND=============
	
	logic [WIDTH-1:0] OutAND;
	logic CAND,VAND;

	and_modulo #( WIDTH ) AND(A,B,OutAND,VAND,CAND);
	
	//=============OR=============
	
	logic [WIDTH-1:0] OutOR;
	logic COR,VOR;

	or_modulo #( WIDTH ) OR(A,B,OutOR,VOR,COR);
	
	//=============XOR=============
	
	logic [WIDTH-1:0] OutXOR;
	logic CXOR,VXOR;

	xor_modulo #( WIDTH ) XOR(A,B,OutXOR,VXOR,CXOR);
	
	
	//=============SHIFTL=============
	
	logic [WIDTH-1:0] OutShiftL;
	logic CShiftL,VShiftL;

	shiftL_modulo #( WIDTH ) ShiftL(A, B, OutShiftL,VShiftL,CShiftL);
	

	

	always_comb begin  
	
      case (sel)  
         3'b000,
			3'b001 : begin
				Out = OutSumador;
				C <= CSumador;
				V <= VSumador;
				
			end
			3'b010 : begin
				Out = OutAND;
				C <= CAND;
				V <= VAND;
				
			end
			3'b011 :begin
				Out = OutOR;
				C <= COR;
				V <= VOR;
				
			end
			3'b100 : begin
				Out = OutXOR;
				C <= CXOR;
				V <= VXOR;
				
			end
			3'b101 : begin
				Out = OutShiftL;
				C <= CShiftL;
				V <= VShiftL;
				
			end
			3'b110 : begin
				Out = A;
				C <= 0;
				V <= 0;

			end
			3'b111 : begin
				Out = B;
				C <= 0;
				V <= 0;

			end
			default : begin
				Out = A;
				C <= 0;
				V <= 0;
				
			end
      endcase 
	
		N <= Out[WIDTH-1];
		Z <= ~|Out;
		
   end
	
endmodule