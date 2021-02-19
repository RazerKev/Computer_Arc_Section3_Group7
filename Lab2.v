module Lab2
	(input clk, 
	 input write, 
	 input reset, 
	 input [4:0] wrAddr,
	 input [63:0] wrData,
	 input [4:0] rdAddrA, 
	 output [63:0] rdDataA, 
	 input [4:0] rdAddrB, 
	 output [63:0] rdDataB);
	 
	 reg [63:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14,
					reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28,
					reg29, reg30, reg31; //extend to 32
	 
assign rdDataA  = rdAddrA == 5'd0 ? reg0: 
			         rdAddrA == 5'd1 ? reg1: 
			         rdAddrA == 5'd2 ? reg2: 
			         rdAddrA == 5'd3 ? reg3: 
			         rdAddrA == 5'd4 ? reg4: 
			         rdAddrA == 5'd6 ? reg6:
						rdAddrA == 5'd7 ? reg7:
						rdAddrA == 5'd8 ? reg8:
						rdAddrA == 5'd9 ? reg9:
					   rdAddrA == 5'd10 ? reg10:
						rdAddrA == 5'd11 ? reg11:
						rdAddrA == 5'd12 ? reg12:
						rdAddrA == 5'd13 ? reg13:
						rdAddrA == 5'd14 ? reg14: 
						rdAddrA == 5'd15 ? reg15: 
						rdAddrA == 5'd16 ? reg16:	 
						rdAddrA == 5'd17 ? reg17:
						rdAddrA == 5'd18 ? reg18:
						rdAddrA == 5'd19 ? reg19:
						rdAddrA == 5'd20 ? reg20:
						rdAddrA == 5'd21 ? reg21: 
						rdAddrA == 5'd22 ? reg22: 
						rdAddrA == 5'd23 ? reg23:	 
				      rdAddrA == 5'd24 ? reg24:
						rdAddrA == 5'd25 ? reg25:
						rdAddrA == 5'd26 ? reg26:
						rdAddrA == 5'd27 ? reg27:
						rdAddrA == 5'd28 ? reg28: 
						rdAddrA == 5'd29 ? reg29: 
						rdAddrA == 5'd30 ? reg30:	 
					   rdAddrA == 5'd31 ? reg31: 0; 
				
assign rdDataB =  rdAddrB == 5'd0 ? reg0: 
			         rdAddrB == 5'd1 ? reg1: 
			         rdAddrB == 5'd2 ? reg2: 
			         rdAddrB == 5'd3 ? reg3: 
			         rdAddrB == 5'd4 ? reg4: 
			         rdAddrB == 5'd6 ? reg6:
						rdAddrB == 5'd7 ? reg7:
						rdAddrB == 5'd8 ? reg8:
						rdAddrB == 5'd9 ? reg9:
					   rdAddrB == 5'd10 ? reg10:
						rdAddrB == 5'd11 ? reg11:
						rdAddrB == 5'd12 ? reg12:
						rdAddrB == 5'd13 ? reg13:
						rdAddrB == 5'd14 ? reg14: 
						rdAddrB == 5'd15 ? reg15: 
						rdAddrB == 5'd16 ? reg16:	 
						rdAddrB == 5'd17 ? reg17:
						rdAddrB == 5'd18 ? reg18:
						rdAddrB == 5'd19 ? reg19:
						rdAddrB == 5'd20 ? reg20:
						rdAddrB == 5'd21 ? reg21: 
						rdAddrB == 5'd22 ? reg22: 
						rdAddrB == 5'd23 ? reg23:	 
				      rdAddrB == 5'd24 ? reg24:
						rdAddrB == 5'd25 ? reg25:
						rdAddrB == 5'd26 ? reg26:
						rdAddrB == 5'd27 ? reg27:
						rdAddrB == 5'd28 ? reg28: 
						rdAddrB == 5'd29 ? reg29: 
						rdAddrB == 5'd30 ? reg30:	 
					   rdAddrB == 5'd31 ? reg31: 0; 

always @(posedge clk) begin
	if (reset) begin 
		reg0 <= 64'b0;
		reg1 <= 64'b0;
		reg2 <= 64'b0;
		reg3 <= 64'b0;
		reg4 <= 64'b0;
		reg5 <= 64'b0;
		reg6 <= 64'b0;
		reg7 <= 64'b0;
		reg8 <= 64'b0;
		reg9 <= 64'b0;
		reg10 <= 64'b0;
		reg11 <= 64'b0;
		reg12 <= 64'b0;
		reg13 <= 64'b0;
		reg14 <= 64'b0;
		reg15 <= 64'b0;
		reg16 <= 64'b0;
		reg17 <= 64'b0;
		reg18 <= 64'b0;
		reg19 <= 64'b0;
		reg20 <= 64'b0;
		reg21 <= 64'b0;
		reg22 <= 64'b0;
		reg23 <= 64'b0;
		reg24 <= 64'b0;
		reg25 <= 64'b0;
		reg25 <= 64'b0;
		reg27 <= 64'b0;
		reg28 <= 64'b0;
		reg29 <= 64'b0;
		reg30 <= 64'b0;
		reg31 <= 64'b0;
end	
		

	if (write) 
		case (wrAddr) 
			5'd0:  reg1 <= wrData; 
			5'd1:  reg2 <= wrData; 
			5'd2:  reg3 <= wrData; 
			5'd3:  reg4 <= wrData; 
			5'd4:  reg5 <= wrData; 
			5'd5:  reg6 <= wrData; 
			5'd6:  reg7 <= wrData; 
			5'd7:  reg8 <= wrData; 
			5'd8:  reg9 <= wrData; 
			5'd9:  reg10 <= wrData; 
			5'd10:  reg11 <= wrData; 
			5'd11:  reg12 <= wrData; 
			5'd12:  reg13 <= wrData; 
			5'd13:  reg14 <= wrData; 
			5'd14:  reg15 <= wrData; 
			5'd15:  reg16 <= wrData; 
			5'd17:  reg17 <= wrData; 
			5'd18:  reg18 <= wrData; 
			5'd19:  reg19 <= wrData; 
			5'd20:  reg20 <= wrData; 
			5'd21:  reg21 <= wrData; 
			5'd22:  reg22 <= wrData; 
			5'd23:  reg23 <= wrData; 
			5'd24:  reg24 <= wrData; 
			5'd25:  reg25 <= wrData; 
			5'd26:  reg26 <= wrData; 
			5'd27:  reg27 <= wrData; 
			5'd28:  reg28 <= wrData; 
			5'd29:  reg29 <= wrData; 
			5'd30:  reg30 <= wrData; 
			5'd31:  reg31 <= wrData;  		
			
			 
		endcase 
	end 
endmodule 