module alu8(result, a, b, zFlag, nFlag, cFlag, oFlag, aluContIn);

	input [7:0] a,b; 
	input [2:0] aluContIn; 		
	output [7:0] result;
	reg[7:0] result;
	reg[8:0] cofResult;									// Carry and Overflow result
	output zFlag, nFlag, cFlag, oFlag;
	reg zFlag, nFlag;

	always @(*)
	begin
	
		cofResult <= 8'bx;
		
		case(aluContIn)
				3'b000:  begin 
								cofResult <= a+b; 		// ALU control line=000, ADD (function code 2,1,0 bits)
								result <= a+b;
							end
				3'b001:  result <= a; 					// ALU control line=001, MOV
				3'b010:  begin 
								result <= a+1+(~b);		// ALU control line=010, SUB (function code 2,1,0 bits)
								cofResult <= a+1+(~b);
							end
				3'b011:  result <= a>>1;				// ALU control line=011, SHFR
				3'b100:  result <= a&b;					// ALU control line=100, AND (function code 2,1,0 bits)
				3'b101:  result <= a|b;					// ALU control line=101, OR  (function code 2,1,0 bits)
				3'b111:  result <= a<<1;				// ALU control line=111, SHFL

		default: begin
			  result<=7'bx;	
			 end
		endcase
		
		zFlag <= ~(|result);
		nFlag <= result[7];
	
	end
		carry_overFlow_flag_control control(cFlag, oFlag, a[7], b[7], cofResult, aluContIn);


endmodule