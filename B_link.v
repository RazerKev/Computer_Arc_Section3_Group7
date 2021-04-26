module B_link (status,instruction, state, controlword, nextState, K); 
	output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] instruction;  
	input [1:0] state; 
	input [4:0] status; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b10; 
	assign DA = 5'b11111;
	assign SA = 5'b11111; 
	assign SB = 5'b11111; 
	assign Fsel = 5'b0000;
	assign regW = 1'b0;
	assign ramW = 1'b0; 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0; 
	assign Bsel = 1'b0; 
	assign PCsel = 1'b1; 
	assign SL = 1'b1;
	
   assign K = {{38 {1'b0}}, instruction [25:0]}; 
	assign controlword = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
endmodule 
	
	
	
	
	
	
	
	
	
	