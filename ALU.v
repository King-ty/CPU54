`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/16 19:05:11
// Design Name: 
// Module Name: alu
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


module alu(
	input [31:0] a,		//ALU输入a
	input [31:0] b,		//ALU输入b
	input [3:0] aluc,	//ALU控制信号
	output [31:0] r,//ALU运算结果
	output zero,	//zero标志位
	output carry,	//carry标志位
	output negative,//negative标志位
	output overflow	//overflow标志位
	);

	parameter ADD	= 4'b0010;
	parameter ADDU	= 4'b0000;
	parameter SUB	= 4'b0011;
	parameter SUBU	= 4'b0001;
	parameter AND	= 4'b0100;
	parameter OR	= 4'b0101;
	parameter XOR	= 4'b0110;
	parameter NOR	= 4'b0111;
	parameter LUI	= 4'b100x;//4'b1000;//
	parameter SLT	= 4'b1011;
	parameter SLTU	= 4'b1010;
	parameter SRA	= 4'b1100;
	parameter SLL	= 4'b111x;//4'b1110;//
	parameter SRL	= 4'b1101;

	reg [32:0] temp;
	wire signed [31:0] sign_a = a;
	wire signed [31:0] sign_b = b;
	always@(*)
	begin
		casex(aluc)
			ADD:	temp <= sign_a + sign_b;
			ADDU:	temp <= a + b;
			SUB:	temp <= sign_a - sign_b;
			SUBU:	temp <= a - b;
			AND:	temp <= a & b;
			OR:		temp <= a | b;
			XOR:	temp <= a ^ b;
			NOR:	temp <= ~(a | b);
			
			LUI:	temp <= {b[15:0], 16'b0};

			SLT:	temp <= (sign_a < sign_b);//sign_a < sign_b ? 1 : 0;
			SLTU:	temp <= (a < b);//a < b ? 1 : 0;
			SRA:	temp <= sign_b >>> sign_a;
			SLL:	temp <= b << a;
			SRL:	temp <= b >> a;
			SRL:	temp <= b >> a;
			
			default;
		endcase
	end
	assign r		= temp[31:0];
	assign zero		= temp==32'b0 ? 1'b1 : 1'b0;
	assign carry	= temp[32];
	assign overflow	= temp[32];//
	assign negative	= (aluc == SLT || aluc == SLTU) ? temp[0] : temp[31];//
endmodule
