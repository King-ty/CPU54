`timescale 1ns / 1ps
module DIV(
    input [31:0]dividend, //������
    input [31:0]divisor, //����
    input start, //������������//start = is_div & ~busy
    input clock,
    input reset,
    output [31:0]q, //��
    output [31:0]r, //����
    output reg busy //������æ��־λ
);
reg[4:0] count;
reg [31:0] reg_q;
reg [31:0] reg_r;
reg [31:0] reg_b;
reg r_sign,sign_q,sign_r;
wire [32:0] sub_add = r_sign?({reg_r,reg_q[31]} + {1'b0,reg_b}):({reg_r,reg_q[31]} - {1'b0,reg_b}); //�ӡ�������
//wire temp_r = r_sign? reg_r + reg_b : reg_r;
assign r = r_sign==1 ? (sign_r==1 ? -(reg_r + reg_b):(reg_r + reg_b)) : (sign_r==1 ? -reg_r:reg_r);//r_sign? reg_r + reg_b : reg_r;
//sign_r==1 ? (r_sign==1 ? -(reg_r + reg_b) : -reg_r) : (r_sign==1 ? reg_r + reg_b : reg_r);
assign q = sign_q==1 ? -reg_q : reg_q;//reg_q;
always @ (posedge clock or posedge reset)begin
    if (reset == 1) begin //����
        count <=5'b0;
        busy <= 0;
    end
    else begin
        if (start) begin //��ʼ�������㣬��ʼ��
            reg_r <= 32'b0;
            r_sign <= 0;
            reg_q <= dividend[31]==0 ? dividend : -dividend;
            reg_b <= divisor[31]==0 ? divisor : -divisor;
            sign_q <= dividend[31]^divisor[31];
            sign_r <= dividend[31];
            count <= 5'b0;
            busy <= 1'b1;
        end
        else if (busy) begin //ѭ������
            reg_r <= sub_add[31:0]; //��������
            r_sign <= sub_add[32]; //���Ϊ�����´����
            reg_q <= {reg_q[30:0],~sub_add[32]};//��������벿���̷���λ�෴
            count <= count +5'b1; //��������һ
            if (count == 5'b11111) busy <= 0; //������������
        end
    end
end
endmodule

// always @ (dividend or divisor)
// begin
//     if(dividend[31]==0&&divisor[31]==0)
//     begin
//         sign_q <= 0;
//         sign_r <= 0;
//         reg_q <= dividend;
//         reg_b <= divisor;
//     end
//     else if(dividend[31]==0&&divisor[31]==1)
//     begin
//         sign_q <= 1;
//         sign_r <= 0;
//         reg_q <= dividend;
//         reg_b <= -divisor;
//     end
//     else if(dividend[31]==1&&divisor[31]==0)
//     begin
//         sign_q <= 1;
//         sign_r <= 1;
//         reg_q <= -dividend;
//         reg_b <= divisor;
//     end
//     else
//     begin
//         sign_q <= 0;
//         sign_r <= 1;
//         reg_q <= -dividend;
//         reg_b <= -divisor;
//     end
// end
