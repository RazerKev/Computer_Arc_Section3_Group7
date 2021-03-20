module ramFile ( clock, write, reset, writeReg, data, readA, readB, sel, muxSel, cin, writeRam, ramOut, Cout, status, aluOut);
input clock;
input write; 
input reset; 
input [4:0] writeReg; 
input [63:0] data; 
input [4:0] readA, readB;
input [5:0] sel; 
input muxSel; 
input cin;
input writeRam; 

output [63:0] ramOut; 
output Cout; 
output status;
output [63:0] aluOut;  

wire [63:0] A_out, B_out, mux_2_1_out, alu_out, mux2_to_1_out; 

regfile_32x64 u1  ( clock, write, reset, writeReg, data, readA, A_out, readB, B_out); 
mux_Aout_2to1 u2  ( A_out, writeRegister, muxSel,  mux2_to_1_out);
aluFile 		  u3	( mux2_to_1_out, B_out, cin, sel, alu_out, cout, status);  
RAM256X64     u4 	( alu_out, clock, A_out, writeRam, ramOut); 

endmodule 

module RAM256X64(address, clock, in, write, out);
    parameter RAMAddress = 8'b00000000;
    input [63:0] address; //8b address
    input clock; //1b clock
    input [63:0] in; //64b input
    input write; //1b write enable
    output [63:0] out;
    reg [63:0] outReg; //64b output
    reg [63:0]mem[0:255]; //reserve memory
    wire correctAddress;
    assign correctAddress = (address[63:56] == RAMAddress) ? 1'b1 : 1'b0;
    assign out = correctAddress ? outReg : 64'bz;
    always @(negedge clock) begin
   	 if (write & correctAddress) begin
   		 mem[address[63:56]] <= in; //write to RAM when write is enabled
   	 end
    end
    always @(negedge clock) begin
   	 outReg <= mem[address[63:56]]; //access RAM
    end
endmodule

module mux_Aout_2to1 (A_reg_out, Writeregister , Sel, out);//writeresgister is 4bit, and RegAout is 64 bit

input [63:0] A_reg_out;
input [5:0]Writeregister; 
input Sel; 
output reg [63:0] out;
always @ (A_reg_out or Writeregister or Sel) 
    begin 
        case (Sel) 
         0: out = A_reg_out;
         1: out = Writeregister; 
          default: out = 1'bx;
        endcase
    end
	 
endmodule 