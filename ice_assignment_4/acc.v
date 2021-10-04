module acc(clk, D, E, Q);

input clk;
input [7:0] D;
output [7:0] Q;
reg [7:0] result;
input E; 
initial result = 8'b00000000;

always @(posedge E)
	begin
		if(clk == 1)
			result = D;
	end
	
assign Q = result;
	
endmodule