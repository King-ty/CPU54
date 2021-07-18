`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 15:58:54
// Design Name: 
// Module Name: pcreg
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


module pc_reg(
	input clk,
	input rst,
	input ena,
	input [31:0] data_in,
	output reg [31:0] data_out
    );

	always@(negedge clk or posedge rst)//negedge
	begin
		if(rst)
		begin
			data_out <= 32'b0;
		end
		else if(ena)
		begin
			data_out <= data_in;
		end
	end

endmodule
