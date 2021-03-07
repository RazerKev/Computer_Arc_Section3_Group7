module alu_file (a, b, Cin, sel, Cout, out);
input [63:0] a, b;
input [7:0] sel;
input [1:0] Cin;
output [1:0] Cout; 
output [63:0] out; 

wire [63:0] a_or_a_invert, a_or_b_invert; 
wire [63:0] orOut, andOut, xorOut, adderOut;
 

mux_A_2_to_1 muxA (a,sel[0], a_or_a_invert); 
mux_B_2_to_1 muxB (b, sel[1], b_or_b_invert); 
orOp or_op (mux1, mux2, orOut); 
andOp and_Op (mux1, mux2, andOut); 
xorOp xor_Op (mux1, mux2, xorOut);
Adder adder_sub (Cout, Cin, a, mux2, );
mux_4_1 result_mux (orOut, andOut, xorOut, adderOut, sel[5:2], out);  
shifter shift_op (mux1, mux2, a, b[5:0]); 

endmodule 

module shifter (A_or_B, shift_amount, left_shift, right_shift)

input [63:0] A_or_B; 
input [5:0] shift_amount; 
output [63:0] left_shift, right_shift; 

out1 = input1 << input2;
out2 = input1 >> input2;  

endmodule


module mux_A_2_to_1 ( A, fsel, R);
input [63:0] A; 
input fsel; 
output reg [63:0] R;

always @ (A or fsel) 
	begin 
		case (fsel) 
	 
		1'd1: R <= ~A; 
		endcase
	end
endmodule 
		
module mux_B_2_to_1 (B, fsel, R);
input [63:0] B; 
input fsel;
output reg [63:0] R; 

always @ (B or fsel)
	begin 
		case (fsel)
	
		1'd1: R <= ~B;
	endcase
 end 	
endmodule  
 
module mux_4_1 (a0, b0, c0, d0, e0, f0, fsel, R); 
input [63:0] a0, b0, c0, d0;
input [2:0] fsel; 
output [63:0] R; 
reg [63:0] R; 

always @ (a0 or b0 or c0 or d0 or fsel)
begin 
  case (fsel) 
   3'd2: R = a0; 
	3'd4: R = b0; 
	3'd5: R = c0;
	3'd6: R = d0;
	3'd7: R = e0;
	3'd8: R = f0; 
	
	default: R = 64'bx; 
  endcase 
end
endmodule

module orOp ( A, B, result);
input [63:0] A , B; 
output [63:0] result;

assign result = A | B; 

endmodule

module andOp ( A, B, result); 
input [63:0] A, B ; 
output [63:0] result;

assign result = A & B; 

endmodule 

module xorOp (A, B, result); 
input [63:0] A, B; 
output [63:0] result; 

assign result = A ^ B;

endmodule 

module full_adder (A, B, Cin, S, Cout); 

input  A, B, Cin;
output S, Cout;

assign S = A^(B&Cin);
assign Cout = (A^B)&Cin | A&B; 

endmodule 

module Adder(S, Cout, A, B, Cin);
	input [63:0] A, B;
	input Cin;
	output [63:0] S;
	output Cout;
	
	wire [64:0]carry;
	assign carry[0] = Cin;
	assign Cout = carry[64];
	// use generate block to instantiate 64 full adders
	genvar i;
	generate
	for (i=0; i<64; i=i+1) begin: full_adders // blocks within a generate block need to be named
		full_adder adder_inst (S[i], carry[i+1], A[i], B[i], carry[i]);	
	end
	endgenerate
	// this will generate the following code:
	// FullAdder full_adders[0].adder_inst (S[0], carry[1], A[0], B[0], carry[0]);
	// FullAdder full_adders[1].adder_inst (S[1], carry[2], A[1], B[1], carry[1]);
	// ...
	// FullAdder full_adders[63].adder_inst (S[63], carry[64], A[63], B[63], carry[63]);
endmodule


