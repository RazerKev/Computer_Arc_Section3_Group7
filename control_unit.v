module control_unit (clock, reset, instruction, status, k, controlWord); 

input clock; 
input reset; 
input [31:0] op; 
output [63:0] k; 
output [31:0] controlWord; 

//addi              DA        SA        IMM        FS      WR    WM  EN_EM  EN_ALU  EN_B  EN_PC    PS     SL   SELB   PCSEL
assign addi = {op [4:0], op [9:5], op [21:10], 5'b10000, 1'b1, 1'b0, 1'b0,   1'b1,  1'b0, 1'b0  , 2'b01, 1'b0, 1'b1,  1'b0 }  