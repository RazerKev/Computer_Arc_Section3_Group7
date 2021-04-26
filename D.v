module D (instruction, state, controlword, nextState, K);
	output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] instruction;  
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b01; 
	assign DA = instruction [4:0];
	assign SA = instruction [9:5];  
	assign SB = instruction [4:0]; 
	assign Fsel = 5'b01000;  
	assign regW = instruction [22]; 
	assign ramW = ~instruction [22]; 
	assign EN_MEM = instruction [22]; 
	assign EN_ALU = 1'b0; //?
	assign EN_B = 1'b0;   //?
	assign EN_PC = 1'b0; 
	assign Bsel = 1'b0; // dont care  
	assign PCsel = 1'b1; // output SA
	assign SL = 1'b0;  
	
   assign K = {{55 {1'b0}}, instruction [20:12]}; // this is for the 9 bit immediate 
	assign controlword = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
	
endmodule 	