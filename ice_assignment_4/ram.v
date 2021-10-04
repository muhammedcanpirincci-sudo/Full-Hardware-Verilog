module ram(out, in, address,enRAM, RW);
input [7:0] in, address;
input RW, enRAM;
output [7:0] out;
wire [255:0] select, o0, o1, o2, o3, o4, o5, o6, o7;
wire [2048:0] outOfBC;

 decoder8bit decoder(enRAM,address,select);

genvar i,j;
  generate
    for(i = 0; i< 256; i = i + 1)begin : gen_loop1
			for(j = 0; j< 8; j = j + 1)begin  : gen_loop2
				binaryCell bc(outOfBC[(i* 8) + j], in[j], select[i], RW);
	case(j)
					0: assign o0[i] = outOfBC[(i* 8) + j];
					1: assign o1[i] = outOfBC[(i* 8) + j];
					2: assign o2[i] = outOfBC[(i* 8) + j];
					3: assign o3[i] = outOfBC[(i* 8) + j];
					4: assign o4[i] = outOfBC[(i* 8) + j];
					5: assign o5[i] = outOfBC[(i* 8) + j];
					6: assign o6[i] = outOfBC[(i* 8) + j];
					7: assign o7[i] = outOfBC[(i* 8) + j];
				endcase
			
			end
	end
	for(j = 0; j< 8; j = j + 1)begin  : gen_loop3
				case(j)
					0: assign out[0] = |o0 ;
					1: assign out[1] = |o1;
					2: assign out[2] = |o2;
					3: assign out[3] = |o3;
					4: assign out[4] = |o4;
					5: assign out[5] = |o5;
					6: assign out[6] = |o6;
					7: assign out[7] = |o7;
				endcase
	end
  endgenerate
  
endmodule
