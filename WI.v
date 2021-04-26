module WI (instruction, state, controlword, nextState, K);
	output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] instruction;
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	// ~(instruction[29] ^ state[0])
	// 00	:	1
	// 01 :	X (this condition will never happen
	// 10 :	0
	// 11 :	1
	
	assign Psel = {1'b0, ~(instruction[29] ^ state[0])}; // movz = instr 0, movk = instr 1   
	assign DA = instruction [4:0]; // DA reg
	assign SA = instruction[29] ? instruction [4:0] : 5'b11111; // DA reg 
	assign SB = 5'b11111; // dont care about SB  
	assign Fsel = instruction[29] ? {2'b00,state[0],2'b00} : 5'b00100;  //OR function 
	assign regW = 1'b1;  
	assign ramW = 1'b0; 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; //pass alu result 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0; 
	assign Bsel = 1'b1;  // pass constnt 
	assign PCsel = 1'b0; // pass SA
	assign SL = 1'b0; // dont change status bits  
	
   assign K = ~(instruction[29] ^ state[0]) ? {{48 {1'b0}}, instruction [20:5]} : {{48{1'b1}}, 16'b0}; 
   // this is for the 16 bit immediate 
	assign controlword = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = {{1'b0}, instruction[29] & ~state[0]};
 
	
endmodule 	