module B (instruction, state, controlword, nextState, K); 
	output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] insruction:  
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b11; 
	assign DA = 5'b11111; //Dont care
	assign SA = 5'b11111; //dont care
	assign SB = 5'b11111; //dont care
	assign Fsel = 5'b0000; //dont care, A and B are not inverted 
	assign regW = 1'b0; //dont write 
	assign ramW = 1'b0; //dont write 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0; 
	assign selB = 1'b0; // dont care 
	assign PCsel = 1'b1; //send K to PC
	assign SL = 1'b0; //dont change status bits 
	
   assign K = {38 {1'b0}, instruction [25:0]}; 
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
endmodule 
	
	
	
	
	
	
	
	
	
	