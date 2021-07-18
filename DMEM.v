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
    input clk,	//ʱ���ź�
    input CS,	//ʹ���ź�
    input DM_R,	//DMEM��ȡ��Ч�ź�
    input DM_W,	//DMEMд����Ч�ź�
    input [1:0] sel, //11 32bit; 01 16bit; 00 8bit;
    input [5:0] addr,		//DMDM���ݵ�ַ
    input [31:0] data_in,	//��������
    output [31:0] data_out	//�������
    );

    reg [7:0] mem [0:512];//������

    // С����
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
