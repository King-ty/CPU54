`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 16:37:13
// Design Name: 
// Module Name: CLZ
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module _CLZ(
	input [31:0] in,
	output [31:0] out
    );

	assign out =in[31] ? 32'd0 : 
				in[30] ? 32'd1 : 
				in[29] ? 32'd2 : 
				in[28] ? 32'd3 : 
				in[27] ? 32'd4 : 
				in[26] ? 32'd5 : 
				in[25] ? 32'd6 : 
				in[24] ? 32'd7 :
				in[23] ? 32'd8 :
				in[22] ? 32'd9 :
				in[21] ? 32'd10 :
				in[20] ? 32'd11 :
				in[19] ? 32'd12 :
				in[18] ? 32'd13 :
				in[17] ? 32'd14 :
				in[16] ? 32'd15 : 
				in[15] ? 32'd16 :
				in[14] ? 32'd17 :
				in[13] ? 32'd18 :
				in[12] ? 32'd19 :
				in[11] ? 32'd20 :
				in[10] ? 32'd21 :
				in[9] ? 32'd22 :
				in[8] ? 32'd23 :
				in[7] ? 32'd24 :
				in[6] ? 32'd25 :
				in[5] ? 32'd26 :
				in[4] ? 32'd27 :
				in[3] ? 32'd28 :
				in[2] ? 32'd29 :
				in[1] ? 32'd30 :
				in[0] ? 32'd31 :
				32'd32;

endmodule
