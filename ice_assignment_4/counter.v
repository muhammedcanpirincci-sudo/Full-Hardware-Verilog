module counter( clk, F, address);
input clk, F;
output reg [3:0] address;

initial address = 4'b1111;

always@(posedge F)
begin
address = address + 1;
end

endmodule