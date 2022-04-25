/*
	Fetch  Module
	Inputs: 
	- NewPC: nuevo pc cuando se hace branch
	- PCSelector: indica si tomar nuevo pc o pc+1
	- clock
	- reset
	- enable
	Outputs:
	- instruction : next instruction
*/

module Fetch #(parameter PC_WIDTH = 32, parameter INSTRUCTION_WIDTH = 30)
	(input logic [PC_WIDTH-1:0] NewPC,
	 input logic PCSelector, clock, reset, enable,
	 output logic [INSTRUCTION_WIDTH-1:0] instruction
	 );
	
	logic [PC_WIDTH-1:0] PC, PCPlus1, TempPC;
	
	adder  #(.WIDTH(PC_WIDTH)) pcAdder (.a(PC), .b(32'b1), .out(PCPlus1));	
	mux2  #(.WIDTH(PC_WIDTH)) pcmux (.d0(PCPlus1), .d1(NewPC), .s(PCSelector), .y(TempPC));
	flipflop #(.WIDTH(PC_WIDTH)) pcFlipFlop(.clk(clock), .reset(reset), .enable(enable), .in(TempPC), .out(PC));	
	instructionMemory #(.PC_WIDTH(PC_WIDTH), .INSTRUCTION_WIDTH(INSTRUCTION_WIDTH)) instructionMemory(.PC(PC), .instruction(instruction));
		
endmodule


