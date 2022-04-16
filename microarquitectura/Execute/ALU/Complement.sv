module Complement #(parameter WIDTH = 4)  (A,SUBS, S);
//El parámetro WIDTH define la cantidad de bits de entrada

input [WIDTH-1:0] A;
input  SUBS;
output [WIDTH-1:0] S;

genvar i;

//Se aplica la lógica en el generate de manera tal que el circuito se genere al compilar

generate


//Se agrega un circuito combinacional que generó el inverso de
// todos los bits de entrada de manera tal que si él la bandera substract está encendida sacar al complemento

for ( i  = 0 ; i <WIDTH ;i++ ) begin: ComplementCalc
		xor checkSubs (S[i],SUBS,A[i]);
		
end 
endgenerate
endmodule

