module regController(clk, controlSignal, dataIn, dataOut);
input clk, controlSignal;
input [7:0] dataIn;
output reg [7:0] dataOut;
initial dataOut = 8'b0;

always@(posedge clk)
begin
dataOut = controlSignal ? dataIn: dataOut;
end

endmodule