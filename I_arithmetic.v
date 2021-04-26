module I_arithmetic ( instruction, state, controlword, nextState, K); 
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
	assign SB = 5'b11111;  
	assign Fsel =  5'b10010 == instruction[31:27] ? 5'b01000://addi
                5'b11010 == instruction[31:27] ? 5'b01000: 5'b00000//subi
						; 
	assign regW = 1'b1;  
	assign ramW = 1'b0; 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0; 
	assign Bsel = 1'b0;  
	assign PCsel = 1'b0; 
	assign SL = instruction[29];  
	
   assign K = {{52 {1'b0}}, instruction [21:10]}; // this is for the 12 bit immediate 
	assign controlword = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
	
endmodule 	