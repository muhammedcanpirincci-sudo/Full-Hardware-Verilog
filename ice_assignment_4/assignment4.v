module assignment4(clk);

input clk;
wire[7:0] addrLiteral, acIn, acOut, dataB, RDR_Out, WDR_Out, MAR_Out, RAM_Out ;
wire[2:0] opCode;
wire[11:0] instruction;
wire  MA, WD, RD, enRAM, RW, LR, F, D, E, zFlag, nFlag, cFlag, ofFlag;


instruction_register IR(clk, instruction, D, opCode, addrLiteral, LR);
control_unit control(clk,opCode, F , D, E,  MA, WD, RD, enRAM, RW);
counter PC( clk, F, nextInstrAdd);
rom ROM(nextInstrAdd,instruction);
ram RAM(RAM_Out, WDR_Out, MAR_Out,enRAM, RW);
regController MAR(clk, MA, addrLiteral, MAR_Out);
regController WDR(clk, WD, acOut, WDR_Out);
regController RDR(clk, RD, RAM_Out, RDR_Out);
assign dataB = LR ? RDR_Out: addrLiteral;/////////////////////////

alu8 alu( acIn, dataB, acOut, zFlag, nFlag, cFlag, ofFlag, opCode );
acc Acc(clk, acIn, E, acOut); 



endmodule