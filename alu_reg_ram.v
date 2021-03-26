module alu_reg_ram ( READA, READB, clock, write, reset, writeReg, data, readA, readB, sel, muxSel, cin, writeRam, ramOut, Cout, status, aluOut);
input clock;
input write; 
input reset; 
input [4:0] writeReg; 
input [63:0] data; 
input [4:0] readA;
input [4:0] readB;
input [4:0] sel; 
input muxSel; 
input cin;
input writeRam; 

output [63:0] ramOut; 
output Cout; 
output [3:0] status;
output [63:0] aluOut;  
output [63:0]READA;
output [63:0]READB;

wire [63:0] A_out, B_out, mux_2_1_out, alu_out, mux2_to_1_out; 
assign aluOut = alu_out; 
assign READA= A_out;
assign READB= B_out;

regfile_32x64 u1  ( clock, write, reset, writeReg, data, readA, A_out, readB, B_out); 
mux_Aout_2to1 u2  ( A_out, writeReg, muxSel,  mux2_to_1_out);
aluFile 		  u3	( mux2_to_1_out, B_out, cin, sel, alu_out, Cout, status);  
ram_test      u4  (alu_out[7:0], clock, A_out, writeRam, ramOut);
endmodule 

module mux_Aout_2to1 (A_reg_out, Writeregister , Sel, out);

input [63:0] A_reg_out;
input [4:0]Writeregister; 
input Sel; 
output wire [63:0] out;

assign out = Sel == 0 ? A_reg_out:
             Sel == 1 ? Writeregister : 1'bx;
  
	 
endmodule 