`timescale 1ns / 1ns
module Lab4_tb(); 

//Inputs
reg clock;
reg write; 
reg reset; 
reg [4:0] writeReg;
reg [63:0] data; 
reg [4:0] readA, readB;
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

ramFile dut (clock, write, reset, writeReg, data, readA, readB, sel, muxSel, cin, writeRam, ramOut, Cout, status, aluOut);

initial begin 

$monitor("sel=%d clock=%d, write=%d, reset=%d, writeReg=%d, data=%d, readA=%d, readB=%d, sel=%d, muxSel=%d, cin=%d, writeRam=%d, ramOut=%d, Cout=%d, status=%d, aluOut=%d", 
clock, write, reset, writeReg, data, readA, readB, sel, muxSel, cin, writeRam, ramOut, Cout, status, aluOut);

clock <=  1'b1; 
write <= 1'b1;
reset <= 1'b1;
data <= 64'b0; 
writeReg <= 5'd31;
readA <= 5'd30; 
readB <= 5'd29; 
#5 reset <= 1'b0; 
#320 write <= 1'b0; 
#320 $stop;  
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

always begin 

//ALU Operation
readA = readA; readB = 64'd1; sel = 5'b10000; cin = 1'd0; //A+1...
readA = readA; readB = readB; sel = 5'b10000; cin = 1'd0; //A + B... 3+3=6
readA = readA; readB = readB; sel = 5'b10010; cin = 1'd1; //A - B... 4-3=1

end

wire [63:0] R00, R01, R02, R03, R04, R05, R06, R07, R08, R09; 
wire [63:0] R10, R11, R12, R13, R14, R15, R16, R17, R18, R19; 
wire [63:0] R20, R21, R22, R23, R24, R25, R26, R27, R28, R29; 	  
wire [63:0] R30, R31; 

assign R00 = dut.reg0; 
assign R01 = dut.reg1; 
assign R02 = dut.reg2; 
assign R03 = dut.reg3; 
assign R04 = dut.reg4;
assign R05 = dut.reg5; 
assign R06 = dut.reg6; 
assign R07 = dut.reg7; 
assign R08 = dut.reg8; 
assign R09 = dut.reg9; 
assign R10 = dut.reg10;
assign R11 = dut.reg11; 
assign R12 = dut.reg12; 
assign R13 = dut.reg13; 
assign R14 = dut.reg14; 
assign R15 = dut.reg15; 
assign R16 = dut.reg16; 
assign R17 = dut.reg17; 
assign R18 = dut.reg18; 
assign R19 = dut.reg19; 
assign R20 = dut.reg20;
assign R21 = dut.reg21;
assign R22 = dut.reg22;
assign R23 = dut.reg23;
assign R24 = dut.reg24;
assign R25 = dut.reg25;
assign R26 = dut.reg26;
assign R27 = dut.reg27;
assign R28 = dut.reg28;
assign R29 = dut.reg29;
assign R30 = dut.reg30;
assign R31 = dut.reg31;

endmodule 