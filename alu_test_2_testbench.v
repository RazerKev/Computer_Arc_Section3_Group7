`timescale 1ns / 1ns
module alu_test2_testbench(); 

reg [63:0] a,b; 
reg  Cin;
reg [4:0] sel; 
wire [63:0] out;  
wire  cOut;  
wire [3:0] status;

alu_test2 dut (
				a, 
				b,
				Cin,
				sel,
				out, 
				cOut,
				status); 
				
initial begin 

$monitor("sel=%d a=%d b=%d out=%d Cin=%d cOut=%d status=%d", sel,a,b,out, Cin, cOut, status);
#1 a = 64'd3; b = 64'd1; sel = 5'b10000; Cin = 1'd0; //A+1
#1 a = 64'd2; b = 64'd2; sel = 5'b10000; Cin = 1'd0; //A + B 
#1 a = 64'd3; b = 64'd2; sel = 5'b10010; Cin = 1'd1; //A - B
#1 a = 64'd3; b = 64'd1; sel = 5'b10010; Cin = 1'd1; //A -1
#1 a = 64'd2; b = 64'd4; sel = 5'b10001; Cin = 1'd1; //-A
#1 a = 64'd0; b = 64'd0; sel = 5'b10000; Cin = 1'd0; // F = 0, also the zero flag 
#1 a = 64'd1; b = 64'd0; sel = 5'b10000; Cin = 1'd0; // A 
#1 a = 64'd1; b = 64'd0; sel = 5'b01110; Cin = 1'd0; //A~
#1 a = 64'd2; b = 64'd1; sel = 5'b10100; Cin = 1'd0; // A&B
#1 a = 64'd3; b = 64'd4; sel = 5'b00100; Cin = 1'd0; //A|B
#1 a = 64'd2; b = 64'd5; sel = 5'b01100; Cin = 1'd0; //A^B
#1 a = 64'd23; b = 5'd3;  sel = 5'b10100; Cin = 1'd0; //shift right 
#1 a = 64'd23; b = 5'd3;  sel = 5'b11000; Cin = 1'd0; //shift left
#1 a = 64'd2; b = 64'd4; sel = 5'b10010; Cin = 1'd1; //Negative flag 
#1 a = 64'd4; b = 64'd6; sel = 5'b10000; Cin = 1'd1;//carry out
#1 a = 64'd7; b = 64'd2; sel = 5'b10010; Cin = 1'd1;//overflow 

end 

endmodule

