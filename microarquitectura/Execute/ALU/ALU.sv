module ALU #(parameter WIDTH = 48)( 
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
	

	always_comb begin  
	
      case (sel)  
         3'b000,
			3'b001 : begin
				Out = OutSumador;
				C <= CSumador;
				V <= VSumador;
				
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