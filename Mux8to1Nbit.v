module Mux8to1Nbit(S, I00, I01, I02, I03, I04, I05, I06, I07, F);
	parameter N = 8;
	
	input [2:0] S; //3b select
	input [N-1:0] I00, I01, I02, I03, I04, I05, I06, I07;//Nb inputs
	
	output reg [N-1:0] F; //Nb output
	
	always @(*) begin
		case(S)
			3'b000: F <= I00; //pass selected input specified by select
			3'b001: F <= I01;
			3'b010: F <= I02;
			3'b011: F <= I03;
			3'b100: F <= I04;
			3'b101: F <= I05;
			3'b110: F <= I06;
			3'b111: F <= I07;
		endcase
	end
	
endmodule
