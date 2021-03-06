module binaryCell(out, in, select, RW);
output out;
input in, select, RW;
wire Q;

D_flipFlop ff(in, (~RW & select), Q);
assign out = RW & Q & select;

endmodule