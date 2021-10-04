module control_unit(clk, instrCode, F, D, E, MA, WD, RD, enRAM, RW);

input clk;
input [3:0] instrCode;
output reg F, D, E, MA, WD, RD, enRAM, RW;
reg [2:0] state;


initial 
begin
state = 3'b000;
F = 1;
D = 0;
E = 0;
MA = 0;
WD = 0;
RD = 0;
enRAM = 0;
RW = 0;
end

always @(state or clk )
begin 

	if((clk == 1) && (state == 3'b000)) // F state to D state
	begin
		D = 1;
		F = 0;
		MA = 0;
		WD = 0;
		RD = 0;
		enRAM = 0;
		RW = 0;
		state <= 3'b001;  // D state
		
	end
	
	// L type
	else if((state == 3'b001) && ~instrCode[3]) // D state to  E
	begin
		E = 1;
		D = 0;
		#30 state <= 3'b010; // E state - alu 
	end
	
	else if(state == 3'b010) // E state to F state
	begin
		E = 0;
		F = 1;
		#30 state <= 3'b000; // F state
	end
	
	// Write
	else if((state == 3'b001) & instrCode[3] & (instrCode[2] & instrCode[1] & ~instrCode[0])) // D state to  WR - storer (if we use fsr we have to add it)
	begin
		D = 0;
		WD = 1;
		MA = 1;
		enRAM = 1;
		#30 state <= 3'b011; // WR state
	end
	
	else if(state == 3'b011) // WR to Execute store state
	begin
		#30 state <= 3'b101; // Execute store state
	end
	
	else if(state == 3'b101) //  Execute store state to F state
	begin
		WD = 0;
		MA =  0;
		enRAM =0;
		F = 1;
		#30 state <= 3'b000; // F state
	end
	
	// Read Ram
	else if((state == 3'b001) & instrCode[3]) // D state to  RR 
	begin
		D = 0;
		RW = 1;
		MA = 1;
		enRAM = 1;
		#30 state <= 3'b100; //RR
	end
	
	else if(state == 3'b100) // RR to Execute load state
	begin
		RD = 1;
		#30 state <= 3'b110; // Execute store state
	end
	
	else if(state == 3'b110) //  Execute store state to F state
	begin
		RD = 0;
		MA = 0;
		RW = 0;
		enRAM = 0;
		F = 1;
		#30 state <= 3'b000; // F state
	end
	
	else
	begin
		F = 1;
		#30 state <= 3'b000; // F state
	end
end



endmodule