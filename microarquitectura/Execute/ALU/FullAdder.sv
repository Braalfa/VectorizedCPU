module  FullAdder (input A, B, Cin, output  S, Cout);

//Se agregan cables extra para conectar las salidas de las compuertas del sumador 
logic w_1; //salida del primero xor
logic w_2; //salida del los ands
logic w_3;
  
   //Sumador completo diseñado reforma estructural 

	xor AxorB	(w_1,A,B);
	xor W_1xorCin	(S,w_1,Cin);
	and W_1andCin	(w_2,w_1,Cin);
	and AandB	(w_3,A,B);
	or	W_1orW_2	(Cout,w_2,w_3);
	
	//Se sigue el modelo usual de un sumador 
	
endmodule
