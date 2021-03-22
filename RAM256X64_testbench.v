module RAM256X64_testbench (); 

reg [63:0] address;
reg clock; 
reg [63:0] in; 
reg write; 
wire [63:0] out;  

RAM256X64 dut ( address,
				clock, 
				in,
				write, 
				out); 
				

initial begin 
	address <= 64'b0;
	clock <= 1'b1;
	in <= 63'b0;
	write <= 1'b1;
	#320 write <= 1'b0; 
	#320 $stop; 
end 	
	
always 

		#5 clock <= ~clock; 
always begin 

		#5 in <= {$random, $random}; 
		address = address + 64'b1;
		
		end

endmodule 








	