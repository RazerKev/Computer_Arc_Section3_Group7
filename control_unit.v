module control_unit (clock, reset, instr, status, k, controlWord); 

input clock; 
input reset; 
input [31:0] instr; 
output [63:0] k; 
output [31:0] controlWord; 

//I-type            //We need to set SB to 0 or ground 
//addi                 DA           SA           IMM       FS      WR    WM   EN_EM  EN_ALU  EN_B  EN_PC    PS     SL   SELB   PCSEL
assign ADDI  = {instr [4:0], instr [9:5], instr [21:10], 5'b10000, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b0, 1'b1,  1'b0 };
assign SUBI  = {instr [4:0], instr [9:5], instr [21:10], 5'b10010, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b0, 1'b1,  1'b0 };
assign ADDIS = {instr [4:0], instr [9:5], instr [21:10], 5'b10000, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b1, 1'b1,  1'b0 };
assign SUBIS = {instr [4:0], instr [9:5], instr [21:10], 5'b10010, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b1, 1'b1,  1'b0 };
assign ANDI  = {instr [4:0], instr [9:5], instr [21:10], 5'b01000, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b0, 1'b1,  1'b0 };
assign ORRI  = {instr [4:0], instr [9:5], instr [21:10], 5'b00010, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b0, 1'b1,  1'b0 };
//XOR and immediate 
assign EORI  = {instr [4:0], instr [9:5], instr [21:10], 5'b01100, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b0, 1'b1,  1'b0 };
//AND with immediate
assign ANDIS = {instr [4:0], instr [9:5], instr [21:10], 5'b01000, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b1, 1'b1,  1'b0 }; 

//R-type               DA           SA           SHAMT       SB           FS      WR    WM   EN_MEM  EN_ALU EN_B  EN_PC   PS    SELB   PCSEL    SL  
assign ADD   = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b10000, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b0};
assign SUB   = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b10010, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b0};
// add with flags 
assign ADDS  = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b10000, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b1};
// subtract with flags 
assign SUBS  = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b10000, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b1};
assign AND   = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b01000, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b0};
assign ORR   = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b00100, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b0};          
//XOR
assign EOR   = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b01100, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b0};     
//AND with flags
assign ANDS  = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b01000, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b1};       
//right shift 
assign LSR   = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b10100, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b0};        
//left shift  
assign LSL   = {instr [4:0], instr [9:5], instr [15:10], instr[20:16], 5'b11000, 1'b1, 1'b0,  1'b0,   1'b1, 1'b0, 1'b0, 2'b01,  1'b0,   1'b0,  1'b0};
                          
//Data transfer 
// D-type              DA           SA       9bit- IMM       op2           SB           FS      WR    WM   EN_MEM  EN_ALU  EN_B  EN_PC   PS    SELB  PCSEL  SL         
//store register  
assign STUR  = {instr [4:0], instr [9:5], instr [18:10], instr[20:19], instr[25:21], 5'b10000, 1'b0, 1'b1,  1'b1,  1'b0,   1'b0, 1'b0, 2'b01, 2'b1,  1'b0, 1'b0};             
//Load Register 
assign LDUR  = {instr [4:0], instr [9:5], instr [18:10], instr[20:19], instr[25:21], 5'b10000, 1'b1, 1'b0,  1'b1,  1'b0,   1'b0, 1'b0, 2'b01, 2'b1,  1'b0, 1'b0}; 

assign B_cond = { 5'b

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
	
module R (instruction, state, controlword, nextState, K); 

   output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] insruction:  
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b01; 
	assign DA = controlword [29:25];
	assign SA = controlword [24:20];  
	assign SB = controlword [19:15]; 
	assign Fsel = controlword [14:10];  
	assign regW = 1'b1;  
	assign ramW = 1'b0; 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0; 
	assign selB = 1'b0;  
	assign PCsel = 1'b0; 
	assign SL = controlword[0];  
	
   assign K = {58 {1'b0}, instruction [15:10]}; // this is for 6 bit SHMT 
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
	
endmodule 		
	
module I_arithmetic ( instruction, state, controlword, nextState, K); 
   output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] insruction:  
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b01; 
	assign DA = controlword [29:25];
	assign SA = controlword [24:20];  
	assign SB = controlword [19:15]; 
	assign Fsel = controlword [14:10];  
	assign regW = 1'b1;  
	assign ramW = 1'b0; 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0; 
	assign selB = 1'b0;  
	assign PCsel = 1'b0; 
	assign SL = 1'b0;  
	
   assign K = {52 {1'b0}, instruction [21:10]}; // this is for the 12 bit immediate 
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
	
endmodule 	
	
module I_logic ( instruction, state, controlword, nextState, K); 
   output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] insruction:  
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b01; 
	assign DA = controlword [29:25];
	assign SA = controlword [24:20];  
	assign SB = controlword [19:15]; 
	assign Fsel = controlword [14:10];  
	assign regW = 1'b1;  
	assign ramW = 1'b0; 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0; 
	assign selB = 1'b0;  
	assign PCsel = 1'b0; 
	assign SL = 1'b0;  
	
   assign K = {52 {1'b0}, instruction [21:10]}; 
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
	
endmodule 		
	
module WI (instruction, state, controlword, nextState, K);
	output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] insruction:  
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b01; 
	assign DA = controlword [28:24];
	assign SA = controlword [23:19];  
	assign SB = controlword [18:14]; 
	assign Fsel = controlword [13:9];  
	assign regW = 1'b1;  
	assign ramW = 1'b0; 
	assign EN_MEM = 1'b0; 
	assign EN_ALU = 1'b1; 
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0; 
	assign selB = 1'b0;  
	assign PCsel = 1'b0; 
	assign SL = controlword[0];  
	
   assign K = {52 {1'b0}, instruction [21:10]}; // this is for the 12 bit immediate 
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
	
endmodule 		
	
module D (instruction, state, controlword, nextState, K);
	output [30:0] controlword;
	output [1:0] nextState; 
	output [63:0] K;
	input [31:0] insruction:  
	input [1:0] state; 
	
	wire [1:0] Psel;
   wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
	
	assign Psel = 2'b01; 
	assign DA = controlword [29:25];
	assign SA = controlword [24:20];  
	assign SB = 5'b1111; // we dont care about second Source reg  
	assign Fsel = controlword [14:10];  
	assign regW = controlword[15]; 
	assign ramW = controlword[16]; 
	assign EN_MEM = 1'b1; 
	assign EN_ALU = 1'b0; //?
	assign EN_B = 1'b0;   //?
	assign EN_PC = 1'b0; 
	assign selB = 1'b0; // dont care  
	assign PCsel = 1'b1; // output SA
	assign SL = 1'b0;  
	
   assign K = {53 {1'b0}, instruction [20:10]}; // this is for the 11 bit immediate 
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;  
	
endmodule 		

module B_link ((instruction, state, controlword, nextState, K); 
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
	
	assign nextState = 2'b01;  
endmodule 

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
	








