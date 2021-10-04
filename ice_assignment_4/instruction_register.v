module instruction_register(clk,instruction, D, opCode, b, LR);

input [11:0] instruction;
input D, clk;

output reg [3:0] opCode;
output reg [7:0] b;
output reg LR;

always@(posedge D)
	begin
		if(clk == 1)
		begin
				LR = instruction[11];
				opCode = instruction[11:8];
				b = instruction[7:0];
		end
	end


endmodule