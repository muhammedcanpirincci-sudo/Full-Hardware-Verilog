module D_flipFlop(D,RW,Q);
input D; // Data input 
input RW; // clock input 
output reg Q; // output Q 
initial Q = 0;
always @(*) 
begin
if(RW == 1)
 Q <= D; 
end 
endmodule