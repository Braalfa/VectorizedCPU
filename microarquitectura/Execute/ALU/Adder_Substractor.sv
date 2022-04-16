module Adder_Substractor #(parameter WIDTH = 4)  ( A, B, S,SUBS, Cout,V);
//El parámetro WIDTH define la cantidad de bits de entrada

input [WIDTH-1:0] A;// Primer numero binario de entrada
input [WIDTH-1:0] B;//segundo numero binario de entrada, se le aplica el complemento si la bandera SUBS es 1
input SUBS; //Bandera que corresponde aal funcionamieto del sumador, en caso de ser 1 resta
output [WIDTH-1:0] S;
output V;
output Cout; //V method
genvar i;
genvar j;

logic [WIDTH:0] AuxCarry;
logic [WIDTH-1:0] AuxB;
logic [WIDTH-1:0] AuxZero;



generate


//Se genera el complemento a la base del numero B

Complement  #(.WIDTH( WIDTH)) FullComplement (B,SUBS,AuxB);

//Se genera el sumador en la etapa de generate
for ( i  = 0 ; i <WIDTH ;i++ ) begin: generate_Adder_Substractor

    if (i==0) begin
	 //En casi de ser uno se suma SUBS como el carryIn y se asigan las salidads a variables logicas auxiliates
	 
        FullAdder bitAdder(A[i],AuxB[i],SUBS,S[i],AuxCarry[i]);
		  //Se agrega una compuerta OR al final para crear la compuerta Z
		  or (AuxZero[i],S[i],0);
    end
    else begin
	 
	 //Se toman los valores de la iteracion anterior y se aliementan al circuito 
        FullAdder bitAdder(A[i],AuxB[i],AuxCarry[i-1],S[i],AuxCarry[i]);
		  or (AuxZero[i],S[i],AuxZero[i-1]);
    end	

		
end
	//Se asigna Cout a la variable auxiliar de carry
	 assign Cout = AuxCarry[WIDTH-1];
	 
	 // La bandera de overflow corresponde a (MSB A XNOR MSB B) AND MSB (B XOR MSB S)
	 // se da cuando MSB A y MSB B son 1 ambos o cuando el MSB S es 1 
	 assign V = ~(A[WIDTH-1] ^ B[WIDTH-1] ^ SUBS) && (A[WIDTH-1] ^ S[WIDTH-1]);
	 
	 //El negativo se da si se tiene 0 como carry y está en modo de resta
//	 and Negative (N,SUBS,~Cout);
	 
	 //Overflow se da cuando está en modo de sum y tenemos un carryOut
	 
	// and Overflow(V,~SUBS,Cout);
 
endgenerate

endmodule


