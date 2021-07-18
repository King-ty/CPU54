`timescale 1ns / 1ps
module DIV(
    input [31:0]dividend, //被除数
    input [31:0]divisor, //除数
    input start, //启动除法运算//start = is_div & ~busy
    input clock,
    input reset,
    output [31:0]q, //商
    output [31:0]r, //余数
    output reg busy //除法器忙标志位
);
reg[4:0] count;
reg [31:0] reg_q;
reg [31:0] reg_r;
reg [31:0] reg_b;
reg r_sign,sign_q,sign_r;
wire [32:0] sub_add = r_sign?({reg_r,reg_q[31]} + {1'b0,reg_b}):({reg_r,reg_q[31]} - {1'b0,reg_b}); //加、减法器
//wire temp_r = r_sign? reg_r + reg_b : reg_r;
assign r = r_sign==1 ? (sign_r==1 ? -(reg_r + reg_b):(reg_r + reg_b)) : (sign_r==1 ? -reg_r:reg_r);//r_sign? reg_r + reg_b : reg_r;
//sign_r==1 ? (r_sign==1 ? -(reg_r + reg_b) : -reg_r) : (r_sign==1 ? reg_r + reg_b : reg_r);
assign q = sign_q==1 ? -reg_q : reg_q;//reg_q;
always @ (posedge clock or posedge reset)begin
    if (reset == 1) begin //重置
        count <=5'b0;
        busy <= 0;
    end
    else begin
        if (start) begin //开始除法运算，初始化
            reg_r <= 32'b0;
            r_sign <= 0;
            reg_q <= dividend[31]==0 ? dividend : -dividend;
            reg_b <= divisor[31]==0 ? divisor : -divisor;
            sign_q <= dividend[31]^divisor[31];
            sign_r <= dividend[31];
            count <= 5'b0;
            busy <= 1'b1;
        end
        else if (busy) begin //循环操作
            reg_r <= sub_add[31:0]; //部分余数
            r_sign <= sub_add[32]; //如果为负，下次相加
            reg_q <= {reg_q[30:0],~sub_add[32]};//商上情况与部分商符号位相反
            count <= count +5'b1; //计数器加一
            if (count == 5'b11111) busy <= 0; //结束除法运算
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
