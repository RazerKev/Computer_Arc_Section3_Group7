module Datapath( clock, reset, instruction, controlword, ALU_out, RAM_out, STATUS, PC_OUT, K);
input clock, reset; 
output [32:0] instruction; 
output [31:0] controlword; 
output [63:0] ALU_out, RAM_out, K;
output [4:0] STATUS;  

wire [3:0] STATUS_out; 
wire [1:0] Psel;
wire [4:0] DA, SA, SB, Fsel;
wire regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL; 
assign {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL} = controlword;
assign data = EN_MEM ? RAM_out : 64'bz;
assign data = EN_ALU ? ALU_out : 64'bz;
assign data = EN_B ? B : 64'bz;
assign data = EN_PC ? PC4 : 64'bz;

RegisterNbit inst1 ( STATUS[3:0], STATUS_out, SL, reset, clock); 
assign STATUS[4] = STATUS_out[0]; 
//PC

//ROM

//Control unit 

//Reg file 

//mux 2 to 1 

//alu

//RAM 

endmodule 

module ROM(out, address);
    output reg [31:0] out;
    input [15:0] address; // address - 16 deep memory
    always @(address) begin
   	 case (address)
   		 // n = 100;
   		 // a = &array1[0];
   		 // b = &array2[0];
   		 // while(n--) {
   		 //     *b++ = *a++;
   		 // }
   		 // where n -> X4, a -> X8, b -> X9, X10 is temp value
   		 16'h0000: out = 32'b1001000100_000001100100_11111_00100;  // ADDI X4, XZR, 100
   		 16'h0001: out = 32'b110100101_00_0000000110010000_01000;  // MOVZ X8, 400
   		 16'h0002: out = 32'b110100101_00_0000010010110000_01001;  // MOVZ X9, 1200
   		 16'h0003: out = 32'b10110100_0000000000000000110_00100;   // CBZ X4, 6
   		 16'h0004: out = 32'b1101000100_000000000001_00100_00100;  // SUBI X4, X4, 1
   		 16'h0005: out = 32'b11111000010_000000000_00_01000_01010; // LDUR X10, [X8, 0]
   		 16'h0006: out = 32'b1001000100_000000001000_01000_01000;  // ADDI X8, X8, 8
   		 16'h0007: out = 32'b11111000000_000000000_00_01001_01010; // STUR X10, [X9, 0]
   		 16'h0008: out = 32'b1001000100_000000001000_01001_01001;  // ADDI X9, X9, 8
   		 16'h0009: out = 32'b000101_11111111111111111111111001;	// B -7
   		 default:  out = 32'hD60003E0; // BR XZR
   	 endcase
    end
endmodule

module RegisterNbit(Q, D, load, reset, clock);
	parameter N = 4;
	
	input load; // 1b load enable
	input reset; // 1b async positive edge reset
	input clock; // 1b positve edge clock
	input [N-1:0] D; // data input
	
	output reg [N-1:0] Q; //Nb output
	
	always @(posedge clock or posedge reset) begin
		if(reset)
			Q <= 0; //reset if reset is true
		else if(load)
			Q <= D; //load if load is true
		else
			Q <= Q; //hold otherwise
	end
endmodule




























