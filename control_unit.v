module control_unit (clock, reset, instr, status, k, controlWord); 

input clock; 
input reset; 
input [31:0] instr; 
output [63:0] k; 
output [31:0] controlWord; 

//I-type 
//addi                 DA           SA           IMM       FS      WR    WM   EN_EM  EN_ALU  EN_B  EN_PC    PS     SL   SELB   PCSEL
assign ADDi  = {instr [4:0], instr [9:5], instr [21:10], 5'b10000, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b0, 1'b1,  1'b0 };
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
// D-type              DA           SA             IMM               
//store register 
assign STUR  =        
//Load Register 
assign LDUR  = 

















