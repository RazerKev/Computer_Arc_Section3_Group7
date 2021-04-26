module R (instruction, state, controlword, nextState, K);

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
	assign SB = instruction [20:16]; 
	assign Fsel [4:2] = 5'b10001 == instruction [31:27] ? 3'b000:
											5'b10101 == instruction [31:27] ? 3'b001:
											5'b11001 == instruction [31:27] ? 3'b011:
											5'b10001 == instruction [31:27] ? 5'b11001:
											5'b11010 == instruction [31:27] ? 3'b101: 
											5'b11010 == instruction [31:27] ? 3'b100: 
											3'b000; 
	assign Fsel [1:0] = {1'b0, (instruction[30] & ~instruction[28] & instruction [24])}; 
	assign regW = 1'b1;  
	assign ramW = 1'b0; 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b1; 
	assign Bsel = 1'b0;  
	assign PCsel = 1'b1; 
	assign SL = instruction[20];  
	
   assign K = {{58 {1'b0}}, instruction [15:10]}; // this is for 6 bit SHMT 
	assign controlword = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
	
endmodule 	
	