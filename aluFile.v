module aluFile (a, b, Cin, sel,out, cOut, status);
input [63:0] a, b;
input  Cin;
input [4:0] sel; 
output [63:0] out; 
output  cOut; 
//-Flags declaration - 4 bits, either true or false
output [3:0] status;
wire [63:0] orOut, andOut, xorOut, adderOut, shiftRight, shiftLeft, a_or_a_invert, b_or_b_invert; 
 
assign status[0] = (out == 64'b0);// zero flag 
//assign flagC = (cOut >= sum[64]); //Check if there's a carry out that equals to a size greater than 64 bit sum value. If so, then there's a carry value and Carry flag should cut on.
assign status[1]= cOut; //Carry out flag.
//assign flagO = ({Cin,Cout[63]} == 64'd64); // Checks if the Carry input and last index (bit) of the carry out, combined, is equal to an overflow bit. (Overflow value may need to be changed)
assign status[2] = ~(a_or_a_invert ^ b_or_b_invert) & (a_or_a_invert ^ adderOut);//overflow flag   
//({Cin,Cout} < 64'd64); //Checks if the maximum vale of the 64 bit value that can be stored is > than width. If not, then the width is greater which means an overflow.
//assign flagN = (Cout[63] == 1 && (~A || ~B)); //Checks if the last bit of Cout is 1 and if the operation is subtraction. Can add subtraction (1000 - 1111 = 0111) so check if it contains a 1 and then it a negative number. ~A or ~B is -A or -B
assign status[3] = out[63];//((A+B) < 0);, negative flag 

mux_A_2_to_1 u1 (a, ~a, sel[0], a_or_a_invert); 
mux_B_2_to_1 u2 (b, ~b, sel[1], b_or_b_invert);  
orOp u3 (a_or_a_invert, b_or_b_invert, orOut); 
andOp u4 (a_or_a_invert, b_or_b_invert, andOut); 
xorOp u5 (a_or_a_invert, b_or_b_invert, xorOut);
//Adder u6 (adderOut, cOut, a, b_or_b_invert, Cin);
adder u6 (a_or_a_invert, b_or_b_invert, Cin, adderOut, cOut);
shift_right u7 (a, b[5:0], shiftRight);
shift_left u8 (a, b[5:0], shiftLeft);  
mux_6_1 u9 (64'b0, orOut, andOut, xorOut, adderOut, shiftRight, shiftLeft, 64'b0, sel[4:2], out);  
endmodule 
////////////////////////////////////////-------------------------------
module mux_A_2_to_1 (A, notA, fsel, R);
input [63:0] A, notA; 
input fsel; 
output reg [63:0] R;
always @ (A or notA or fsel) 
    begin 
        case (fsel) 
		  0: R = A;
        1: R = notA; 
		  default: R = 1'bx;
        endcase
    end
endmodule 

module mux_B_2_to_1 (B, notB, fsel, R);
input [63:0] B, notB; 
input fsel;
output reg [63:0] R; 
always @ (B or notB or fsel)
    begin 
        case (fsel)
		  0: R = B;
        1: R = notB;
		  default: R = 1'bx;
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
//This is the Adder that Adds A, B and cin

module adder(addA, addB, nic, sum, cout); //by Muhammad
input [63:0] addA, addB;
input nic;
output [63:0] sum;
output cout;
assign {cout, sum} = addA + addB + nic;
endmodule

//imodule full_adder (A, B, Cin, S, Cout); 
//input  A, B, Cin;
//output S, Cout;
//assign S = A^(B&Cin);
//assign Cout = (A^B)&Cin | A&B; 

//endmodule 
//module Adder(A, B, Cin, S, Cout);
//    input [63:0] A, B;
//   input Cin;
//    output [63:0] S;
//    output  Cout;
//    wire [64:0]carry;
//    assign carry[0] = Cin;
//    assign Cout = carry[64];
//    // use generate block to instantiate 64 full adders
//    genvar i;
//    generate
//   for (i=0; i<64; i=i+1) begin: full_adders // blocks within a generate block need to be named
//        full_adder adder_inst (S[i], carry[i+1], A[i], B[i], carry[i]); 
//    end
//    endgenerate
//   // this will generate the following code:
//    // FullAdder full_adders[0].adder_inst (S[0], carry[1], A[0], B[0], carry[0]);
//    // FullAdder full_adders[1].adder_inst (S[1], carry[2], A[1], B[1], carry[1]);
//    // ...
    // FullAdder full_adders[63].adder_inst (S[63], carry[64], A[63], B[63], carry[63]);
//endmodule


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

module mux_6_1 (nothing, a0, b0, c0, d0, e0, f0, none, fsel, R); 
input [63:0] nothing, a0, b0, c0, d0, e0, f0, none;
input [2:0] fsel; 
output reg [63:0] R; 
always @ (nothing or a0 or b0 or c0 or d0 or e0 or f0 or none or fsel)
begin 
  case (fsel) 
	0: R = nothing;//0
	1: R = a0; 
    2: R = b0; 
    3: R = c0;
    4: R = d0;
    5: R = e0;
    6: R = f0; 
    7: R = none; //7
	 
    default: R = 1'bx; 
  endcase 
end
endmodule