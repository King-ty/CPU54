`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/29 12:25:45
// Design Name: 
// Module Name: DMEM
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


module DMEM(
    input clk,	//时钟信号
    input CS,	//使能信号
    input DM_R,	//DMEM读取有效信号
    input DM_W,	//DMEM写入有效信号
    input [1:0] sel, //11 32bit; 01 16bit; 00 8bit;
    input [5:0] addr,		//DMDM数据地址
    input [31:0] data_in,	//输入数据
    output [31:0] data_out	//输出数据
    );

    reg [7:0] mem [0:512];//够大吗

    // 小字序
    always@(posedge clk)//posedge?
    begin
        if(DM_W && CS)
        begin
            mem[addr] <= data_in[7:0];
            if(sel[0])
            begin
                mem[addr+1] <= data_in[15:8];
            end
            if(sel[1])
            begin
                mem[addr+2] <= data_in[23:16];
                mem[addr+3] <= data_in[31:24];
            end
        end
    end

    assign data_out = (CS && DM_R) ? {(sel[1] ? {mem[addr+3],mem[addr+2]} : 16'b0), (sel[0] ? mem[addr+1] : 8'b0), mem[addr]} : 32'bz;
    
endmodule
