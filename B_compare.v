module B_compare (status, instruction, state, controlword, nextState, K); 
	output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] instruction;  
	input [1:0] state; 
	input [4:0] status; 
	
	wire Z, C, N, V, ZI;

	assign V = status[4]; 
	assign C = status[3]; 
	assign Z = status[2]; 
	assign N = status[1]; 
	assign ZI = status[0];
	
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = {instruction[24] ^ ZI, 1'b1}; // either PC <- PC + 4 + in * 4 (OR) PC <- PC + 4
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
	assign Bsel = 1'b0; // dont care 
	assign PCsel = 1'b1; //send K to PC
	assign SL = 1'b0; //dont change status bits 
	
   assign K = {{45 {1'b0}}, instruction [23:5]};
	assign controlword = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
endmodule 