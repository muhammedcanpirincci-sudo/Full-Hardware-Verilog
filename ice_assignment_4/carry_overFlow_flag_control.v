module carry_overFlow_flag_control(carryFlag, overFlowFlag, a7thBit, b7thBit, result9bit, aluContIn);

output carryFlag, overFlowFlag;
reg carryFlag, overFlowFlag; 
input a7thBit, b7thBit;
input [8:0] result9bit;
input [2:0] aluContIn;
reg bit8; 

				always@(*)
				begin
				if(aluContIn == 3'b000 | aluContIn == 3'b010)
				begin
					//cf
					carryFlag <= (result9bit[8]) ? 1'b1: 1'b0;
							
					//d8
					bit8 <= (result9bit[7] != (a7thBit + b7thBit)) ? 1'b1: 1'b0;
							
					//overFlowFlag
					overFlowFlag <= (bit8 ^ carryFlag) ? 1'b1: 1'b0;
				end
				else begin
				carryFlag <= 1'bx;
 				overFlowFlag <= 1'bx;
				end
				end

endmodule