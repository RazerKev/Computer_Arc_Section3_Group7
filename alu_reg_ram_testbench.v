`timescale 1ns / 1ns
module alu_reg_ram_testbench ();
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
wire [63:0] ramOut; 
wire Cout; 
wire [3:0] status;
wire [63:0] aluOut;  
wire [63:0]READA;
wire [63:0]READB;

alu_reg_ram dut(READA,READB,clock,write, reset, writeReg, data, readA, readB, sel,muxSel, cin, writeRam, ramOut, Cout, status, aluOut); 

initial

    begin
        reset     <=   1'b1; 
        clock     <=   1'b1;
        write     <=   1'b1;
        data      <=   64'b0;
        readA     <=   5'd30;                          
        readB     <=   5'd29;  
        #20 reset   <=   1'b0;
        #320 write  <=   1'b0;
		  #320 $stop; 		  
    end
	 
always #10 clock <= ~clock;

	always begin
	     #10// load in data into regfile, write it to reg 29 
		  data <= 64'd14;
		  writeReg <= 5'd29;
		  #10
        data <= 64'd14;
		  writeReg <= 5'd30; // load in the same value onto reg 30
        #10
		  write <= 1'b0; //disable write, the value in regfile will not write
		  #10// now we have to select what goes into alu on a side, operation, and enable writeram 
		  muxSel <= 1'b0; 
		  sel <= 5'b10000;//a+b
		  cin <= 1'b0;
		  writeRam = 1'b1; 
		  #10 //a-b
		  muxSel <= 1'b0; 
		  sel <= 5'b10010;
		  cin <= 1'b1;
		  writeRam = 1'b1;
		  #10 // shift right 
		  muxSel <= 1'b0; 
		  sel <= 5'b10100;
		  cin <= 1'b0;
		  writeRam = 1'b1;
		 
        //#20 reset   <=   1'b0;
        //#320 write  <=   1'b0;
        
    end  
    
/*always 
begin
    
        #5 data <= {$random,$random};
        writeReg   <=       writeReg + 5'b1;
        readA <= readA+5'b1;
        readB <= readB+5'b1;
        #5;
        end 
always 
    begin 
        write      <=      1'b1;                               
        writeRam   <=      1'b1;                               
        readA      <=      5'b1;                           
        readB      <=      5'b1;                       
        writeReg   <=      5'b00110;                           
        reset      <=      1'b0;
        clock      <=      1'b1;
        sel        <=      5'b10000;                       //A+B
        cin        <=      1'b0;
        muxSel     <=      1'b0;                   
        
        //writeregister     <=       5'b00010;
        #5;
        #500 $stop;
    end
*/
endmodule