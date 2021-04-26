module B_to_reg (instruction, state, controlword, nextState, K); 
	output [30:0] controlword;
	output [1:0] nextState; 
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	output [63:0] K;
	input [31:0] instruction;  
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b10; 
	assign DA = 5'b11111; //Dont care
	assign SA = instruction [4:0]; 
	assign SB = 5'b11111; //dont care
	assign Fsel = 5'b0000; //dont care, not being used 
	assign regW = 1'b0; //dont write 
	assign ramW = 1'b0; //dont write 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b0; 
	assign EN_B = 1'b1;
	assign EN_PC = 1'b0; 
	assign Bsel = 1'b0; // dont care 
	assign PCsel = 1'b0; //send A to PC
	assign SL = 1'b0; //dont change status bits 
	
   assign K = 64'b0; 
	assign controlword = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
endmodule 