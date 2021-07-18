`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 15:07:21
// Design Name: 
// Module Name: CP0
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


module CP0(
	input clk,
	input rst,
	input mfc0, // CPU instruction is Mfc0
	input mtc0, // CPU instruction is Mtc0
	input [31:0] pc,
	input [4:0] Rd, // Specifies Cp0 register
	input [31:0] wdata, // Data from GP register to replace CP0 register
	input exception,
	input eret, // Instruction is ERET (Exception Return)
	input [4:0] cause,
	output [31:0] rdata, // Data from CP0 register for GP register
	output [31:0] status,
	output [31:0] exc_addr // Address for PC at the beginning of an exception
	);

	// parameter	SYSCALL	= 5'b01000,
	// 			BREAK	= 5'b01001,
	// 			TEQ		= 5'b01101;
	parameter	STATUS_ADDR	= 12,
				CAUSE_ADDR	= 13,
				EPC_ADDR	= 14;

	reg [31:0] cp0_reg[0:31];
	assign status=cp0_reg[STATUS_ADDR];
	always@(posedge clk or posedge rst)//
	begin
		if(rst==1)
		begin
			cp0_reg[0]<=32'b0;
			cp0_reg[1]<=32'b0;
			cp0_reg[2]<=32'b0;
			cp0_reg[3]<=32'b0;
			cp0_reg[4]<=32'b0;
			cp0_reg[5]<=32'b0;
			cp0_reg[6]<=32'b0;
			cp0_reg[7]<=32'b0;
			cp0_reg[8]<=32'b0;
			cp0_reg[9]<=32'b0;
			cp0_reg[10]<=32'b0;
			cp0_reg[11]<=32'b0;
			cp0_reg[12]<={27'b0,5'b11111};
			cp0_reg[13]<=32'b0;
			cp0_reg[14]<=32'b0;
			cp0_reg[15]<=32'b0;
			cp0_reg[16]<=32'b0;
			cp0_reg[17]<=32'b0;
			cp0_reg[18]<=32'b0;
			cp0_reg[19]<=32'b0;
			cp0_reg[20]<=32'b0;
			cp0_reg[21]<=32'b0;
			cp0_reg[22]<=32'b0;
			cp0_reg[23]<=32'b0;
			cp0_reg[24]<=32'b0;
			cp0_reg[25]<=32'b0;
			cp0_reg[26]<=32'b0;
			cp0_reg[27]<=32'b0;
			cp0_reg[28]<=32'b0;
			cp0_reg[29]<=32'b0;
			cp0_reg[30]<=32'b0;
			cp0_reg[31]<=32'b0;
		end
		else if(mtc0==1)
		begin
			cp0_reg[Rd]<=wdata;
		end
		else if(exception==1)
		begin
			cp0_reg[STATUS_ADDR]<=status<<5;
			cp0_reg[CAUSE_ADDR]<={25'b0,cause,2'b0};
			cp0_reg[EPC_ADDR]<=pc;
		end
		else if(eret==1)
		begin
			cp0_reg[STATUS_ADDR]<=status>>5;
		end
	end

	assign rdata=(mfc0==1) ? cp0_reg[Rd]:32'bz;
	assign exc_addr=(eret==1) ? cp0_reg[EPC_ADDR]:32'h00400004;
endmodule
