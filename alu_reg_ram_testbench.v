`timescale 1ns / 1ns
module alu_reg_ram_testbench(); 

//Inputs
reg clock;
reg write; 
reg reset; 
reg [4:0] writeReg;
reg [63:0] data; 
reg [4:0] readA;
reg [4:0] readB;
reg [4:0] sel;
reg muxSel; 
reg cin;
reg writeRam;

//Outputs
wire [63:0] ramOut; 
wire Cout; 
wire [3:0] status;
wire [63:0] aluOut; 

//ramFile dut (.clock(clock), .write(write), .reset(reset), .writeReg(writeReg), .data(data), .readA(readA), .readB(readB), .sel(sel), .muxSel(muxSel), .cin(cin), .writeRam(writeRam), .ramOut(ramOut), .Cout(Cout), status(status), .aluOut(aluOut));

alu_reg_ram dut (clock, write, reset, writeReg, data, readA, readB, sel, muxSel, cin, writeRam, ramOut, Cout, status, aluOut);

initial begin 

//$monitor("sel=%d clock=%d, write=%d, reset=%d, writeReg=%d, data=%d, readA=%d, readB=%d, sel=%d, muxSel=%d, cin=%d, writeRam=%d, ramOut=%d, Cout=%d, status=%d, aluOut=%d", 
//clock, write, reset, writeReg, data, readA, readB, sel, muxSel, cin, writeRam, ramOut, Cout, status, aluOut);

clock <=  1'b1; 
write <= 1'b1;
reset <= 1'b1;
data <= 64'b0; 

readA <= 5'd30; 
readB <= 5'd29; 
#5 reset <= 1'b0; 
#320 write <= 1'b0; 
  
end

always  
	
	#5 clock <= ~clock; 

always begin
	#5 data <= {$random, $random}; 
	writeReg <= writeReg + 5'b1; 
	readA <= readA + 5'b1; 
	readB <= readB + 5'b1; 
	#5; 
end

always 
	begin 
		write <= 1'b1;
		writeRam <= 1'b1;
		readA <= 1'b1;
		readB <= 1'b1;
		writeReg <= 5'b00110;
		reset <= 1'b0;
		clock <= 1'b1;
		sel <= 5'b10000; 
		cin <=  1'b0;
		muxSel <= 1'b0;
		//writeReg <=1'b01100;
		#5 
		#500 $stop; 
	end
endmodule

