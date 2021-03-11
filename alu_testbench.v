`timescale 1ns / 1ns
module alu_testbench(); 

reg [63:0] a,b; 
reg [4:0] sel; 
reg [1:0] Cin; 
wire [1:0] cOut; 
wire [63:0] out; 
wire [3:0] status;

alu dut (
				a, 
				b,
				sel,
				Cin,
				cOut, 
				out,
				status); 
				
initial begin 


#1 a = 64'd3; b = 64'd1; sel = 5'b10000; Cin = 1'd0; //A+1
#1 a = 64'd2; b = 64'd2; sel = 5'b10000; Cin = 1'd0; //A + B 
#1 a = 64'd3; b = 64'd2; sel = 5'b10001; Cin = 1'd1; //A - B
#1 a = 64'd3; b = 64'd1; sel = 5'b10001; Cin = 1'd1; //A -1
#1 a = 64'd2; b = 64'd4; sel = 5'b10001; Cin = 1'd1; //-A
#1 a = 64'd0; b = 64'd0; sel = 5'b10000; Cin = 1'd0; // F = 0, also the zero flag 
#1 a = 64'd1; b = 64'd0; sel = 5'b10000; Cin = 1'd0; // A 
#1 a = 64'd1; b = 64'd0; sel = 5'b01110; Cin = 1'd0; //A~
#1 a = 64'd2; b = 64'd1; sel = 5'b10100; Cin = 1'd0; // A&B
#1 a = 64'd3; b = 64'd4; sel = 5'b00100; Cin = 1'd0; //A|B
#1 a = 64'd2; b = 64'd5; sel = 5'b01100; Cin = 1'd0; //A^B
#1 a = 64'd2; b = 5'd3;  sel = 5'b10100; Cin = 1'd0; //shift right 
#1 a = 64'd2; b = 5'd3;  sel = 5'b10100; Cin = 1'd0; //shift left
#1 a = 64'd2; b = 64'd4; sel = 5'b10001; Cin = 1'd1; //Negative flag 
#1 a = 64'd4; b = 64'd6; sel = 5'b10000; Cin = 1'd1;//carry out
#1 a = 64'd7; b = 64'd2; sel = 5'b10001; Cin = 1'd1;//overflow 
end 
endmodule 