module alu_test (a, b, Cin, sel,out, cOut, status);

input [63:0] a, b;
input [4:0] sel;
input [1:0] Cin; 
output [63:0] out; 
output [1:0] cOut; 


//Flags declaration - 4 bits, either true or false
output [3:0] status; 
wire flagC = status[0]; // Don't know if "reg" should be added (output reg...)
wire flagZ = status[1]; // Declare "output reg" if it is being assigned in sequential code, such as "always" block. 
wire flagO = status[2];
wire flagN = status[3];

assign flagZ = (out == 64'b0);
//assign flagC = (Cout >= S[64]); //Check if there's a carry out that equals to a size greater than 64 bit sum value. If so, then there's a carry value and Carry flag should cut on.
assign flagC = cOut; //Checks if the result > width.
//assign flagO = ({Cin,Cout[63]} == 64'd64); // Checks if the Carry input and last index (bit) of the carry out, combined, is equal to an overflow bit. (Overflow value may need to be changed)
assign flagO = ~(a_or_a_invert ^ b_or_b_invert) & (a_or_a_invert ^ adderOut);  
//({Cin,Cout} < 64'd64); //Checks if the maximum vale of the 64 bit value that can be stored is > than width. If not, then the width is greater which means an overflow.
//assign flagN = (Cout[63] == 1 && (~A || ~B)); //Checks if the last bit of Cout is 1 and if the operation is subtraction. Can add subtraction (1000 - 1111 = 0111) so check if it contains a 1 and then it a negative number. ~A or ~B is -A or -B
assign flagN = out[63];//((A+B) < 0);

wire [63:0] a_or_a_invert, a_or_b_invert; 
wire [63:0] orOut, andOut, xorOut, adderOut, shiftRight, shiftLeft;

shift_right rightShift_op (a, b[5:0], shiftRight);
shift_left leftShift_op (a, b[5:0], shiftLeft);  
mux_A_2_to_1 muxA (a,sel[0], a_or_a_invert); 
mux_B_2_to_1 muxB (b, sel[1], b_or_b_invert); 
mux_6_1 result_mux (orOut, andOut, xorOut, adderOut, shifRight, shiftLeft, sel[4:2], out);  
orOp or_op (a_or_b_invert, b_or_b_invert, orOut); 
andOp and_Op (a_or_b_invert, b_or_b_invert, andOut); 
xorOp xor_Op (a_or_b_invert, b_or_b_invert, xorOut);
Adder adder_sub (adderOut, cOut, a, b_or_b_invert, Cin);

 
endmodule 

module shift_right (A_or_B, shift_amount, right_shift);

input [63:0] A_or_B; 
input [5:0] shift_amount; 
output [63:0] right_shift; 

assign right_shift = A_or_B >> shift_amount;
  

endmodule

module shift_left (A_or_B, shift_amount, left_shift);

input [63:0] A_or_B; 
input [5:0] shift_amount; 
output [63:0] left_shift; 

assign left_shift = A_or_B << shift_amount;
  

endmodule


module mux_A_2_to_1 (A, fsel, R);
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
 
module mux_6_1 (a0, b0, c0, d0, e0, f0, fsel, R); 
input [63:0] a0, b0, c0, d0, e0, f0;
input [2:0] fsel; 
output reg [63:0] R; 

always @ (a0 or b0 or c0 or d0 or e0 or f0 or fsel)
begin 
  case (fsel) 
   3'b001: R = a0; 
	3'b010: R = b0; 
	3'b011: R = c0;
	3'b100: R = d0;
	3'b101: R = e0;
	3'b110: R = f0; 
	
	default: R = 64'bx; 
  endcase 
end
endmodule

module orOp ( A, B, result);
input [63:0] A , B; 
output [63:0] result;

assign result = A | B; 

//Flags
 //Checks if the reuslt is = to 0 that is 64 bit value in binary.

endmodule

module andOp ( A, B, result); 
input [63:0] A, B ; 
output [63:0] result;

assign result = A & B; 

//Flags


endmodule 

module xorOp (A, B, result); 
input [63:0] A, B; 
output [63:0] result; 

assign result = A ^ B;

//Flags


endmodule 

module full_adder (A, B, Cin, S, Cout); 

input  A, B, Cin;
output S, Cout;

assign S = A^(B&Cin);
assign Cout = (A^B)&Cin | A&B; 

 //Checks and see if 0 is greater than the sum of A+B. If so, then the sum of A+B is must be negative.

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