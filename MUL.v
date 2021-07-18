`timescale 1ns / 1ps
module MUL(
    input clk, 
    input reset,
    input [31:0] a,
    input [31:0] b,
    output [31:0] out
);
    wire [31:0] aa = a[31] ? -a : a;
    wire [31:0] bb = b[31] ? -b : b;
    wire [31:0] temp = aa * bb;
    assign out = a[31]==b[31] ? temp : -temp;

endmodule

// reg [31:0] aa,bb;
// reg [63:0] temp;
// wire [63:0] stored0;
// wire [63:0] stored1;
// wire [63:0] stored2;
// wire [63:0] stored3;
// wire [63:0] stored4;
// wire [63:0] stored5;
// wire [63:0] stored6;
// wire [63:0] stored7;
// wire [63:0] stored8;
// wire [63:0] stored9;
// wire [63:0] stored10;
// wire [63:0] stored11;
// wire [63:0] stored12;
// wire [63:0] stored13;
// wire [63:0] stored14;
// wire [63:0] stored15;
// wire [63:0] stored16;
// wire [63:0] stored17;
// wire [63:0] stored18;
// wire [63:0] stored19;
// wire [63:0] stored20;
// wire [63:0] stored21;
// wire [63:0] stored22;
// wire [63:0] stored23;
// wire [63:0] stored24;
// wire [63:0] stored25;
// wire [63:0] stored26;
// wire [63:0] stored27;
// wire [63:0] stored28;
// wire [63:0] stored29;
// wire [63:0] stored30;
// wire [63:0] stored31;

// wire [63:0] add0_1;
// wire [63:0] add2_3;
// wire [63:0] add4_5;
// wire [63:0] add6_7;  
// wire [63:0] add8_9;  
// wire [63:0] add10_11;
// wire [63:0] add12_13;
// wire [63:0] add14_15;
// wire [63:0] add16_17;
// wire [63:0] add18_19;
// wire [63:0] add20_21;
// wire [63:0] add22_23;
// wire [63:0] add24_25;
// wire [63:0] add26_27;
// wire [63:0] add28_29;
// wire [63:0] add30_31;

// wire [63:0] add0t1_2t3;
// wire [63:0] add4t5_6t7;
// wire [63:0] add8t9_10t11;
// wire [63:0] add12t13_14t15;
// wire [63:0] add16t17_18t19;
// wire [63:0] add20t21_22t23;
// wire [63:0] add24t25_26t27;
// wire [63:0] add28t29_30t31;

// wire [63:0] add0t3_4t7;
// wire [63:0] add8t11_12t15;
// wire [63:0] add16t19_20t23;
// wire [63:0] add24t27_28t31;

// wire [63:0] add0t7_8t15;
// wire [63:0] add16t23_24t31;

// reg tag;

// always @(a,b)
// begin
//     if(b[31]==1)
//     begin
//         aa<=~a+1;
//         bb<=~b+1;
//     end
//     else begin
//         aa <= a;
//         bb <= b;
//     end
//     if(a==0||b==0||a[31]==b[31])
//     begin
//         tag <= 0;
//     end
//     else
//     begin
//         tag<=1;
//     end
// end

// assign stored0 = bb[0] && (!reset) ? {{32{tag}}, aa} : 64'b0;
// assign stored1 = bb[1] && (!reset) ? {{31{tag}}, aa, 1'b0} : 64'b0;
// assign stored2 = bb[2] && (!reset) ? {{30{tag}}, aa, 2'b0} : 64'b0;
// assign stored3 = bb[3] && (!reset) ? {{29{tag}}, aa, 3'b0} : 64'b0;
// assign stored4 = bb[4] && (!reset) ? {{28{tag}}, aa, 4'b0} : 64'b0;
// assign stored5 = bb[5] && (!reset) ? {{27{tag}}, aa, 5'b0} : 64'b0;
// assign stored6 = bb[6] && (!reset) ? {{26{tag}}, aa, 6'b0} : 64'b0;
// assign stored7 = bb[7] && (!reset) ? {{25{tag}}, aa, 7'b0} : 64'b0;
// assign stored8 = bb[8] && (!reset) ? {{24{tag}}, aa, 8'b0} : 64'b0;
// assign stored9 = bb[9] && (!reset) ? {{23{tag}}, aa, 9'b0} : 64'b0;
// assign stored10 = bb[10] && (!reset) ? {{22{tag}}, aa, 10'b0} : 64'b0;
// assign stored11 = bb[11] && (!reset) ? {{21{tag}}, aa, 11'b0} : 64'b0;
// assign stored12 = bb[12] && (!reset) ? {{20{tag}}, aa, 12'b0} : 64'b0;
// assign stored13 = bb[13] && (!reset) ? {{19{tag}}, aa, 13'b0} : 64'b0;
// assign stored14 = bb[14] && (!reset) ? {{18{tag}}, aa, 14'b0} : 64'b0;
// assign stored15 = bb[15] && (!reset) ? {{17{tag}}, aa, 15'b0} : 64'b0;
// assign stored16 = bb[16] && (!reset) ? {{16{tag}}, aa, 16'b0} : 64'b0;
// assign stored17 = bb[17] && (!reset) ? {{15{tag}}, aa, 17'b0} : 64'b0;
// assign stored18 = bb[18] && (!reset) ? {{14{tag}}, aa, 18'b0} : 64'b0;
// assign stored19 = bb[19] && (!reset) ? {{13{tag}}, aa, 19'b0} : 64'b0;
// assign stored20 = bb[20] && (!reset) ? {{12{tag}}, aa, 20'b0} : 64'b0;
// assign stored21 = bb[21] && (!reset) ? {{11{tag}}, aa, 21'b0} : 64'b0;
// assign stored22 = bb[22] && (!reset) ? {{10{tag}}, aa, 22'b0} : 64'b0;
// assign stored23 = bb[23] && (!reset) ? {{9{tag}}, aa, 23'b0} : 64'b0;
// assign stored24 = bb[24] && (!reset) ? {{8{tag}}, aa, 24'b0} : 64'b0;
// assign stored25 = bb[25] && (!reset) ? {{7{tag}}, aa, 25'b0} : 64'b0;
// assign stored26 = bb[26] && (!reset) ? {{6{tag}}, aa, 26'b0} : 64'b0;
// assign stored27 = bb[27] && (!reset) ? {{5{tag}}, aa, 27'b0} : 64'b0;
// assign stored28 = bb[28] && (!reset) ? {{4{tag}}, aa, 28'b0} : 64'b0;
// assign stored29 = bb[29] && (!reset) ? {{3{tag}}, aa, 29'b0} : 64'b0;
// assign stored30 = bb[30] && (!reset) ? {{2{tag}}, aa, 30'b0} : 64'b0;
// assign stored31 = bb[31] && (!reset) ? {{1{tag}}, aa, 31'b0} : 64'b0;

// assign add0_1 = stored0 + stored1;
// assign add2_3 = stored2 + stored3;
// assign add4_5 = stored4 + stored5;
// assign add6_7 = stored6 + stored7;
// assign add8_9 = stored8 + stored9;
// assign add10_11 = stored10 + stored11;
// assign add12_13 = stored12 + stored13;
// assign add14_15 = stored14 + stored15;
// assign add16_17 = stored16 + stored17;
// assign add18_19 = stored18 + stored19;
// assign add20_21 = stored20 + stored21;
// assign add22_23 = stored22 + stored23;
// assign add24_25 = stored24 + stored25;
// assign add26_27 = stored26 + stored27;
// assign add28_29 = stored28 + stored29;
// assign add30_31 = stored30 + stored31;

// assign add0t1_2t3 = add0_1 + add2_3;
// assign add4t5_6t7 = add4_5 + add6_7;
// assign add8t9_10t11 = add8_9 + add10_11;
// assign add12t13_14t15 = add12_13 + add14_15;
// assign add16t17_18t19 = add16_17 + add18_19;
// assign add20t21_22t23 = add20_21 + add22_23;
// assign add24t25_26t27 = add24_25 + add26_27;
// assign add28t29_30t31 = add28_29 + add30_31;

// assign add0t3_4t7 = add0t1_2t3 + add4t5_6t7;
// assign add8t11_12t15 = add8t9_10t11 + add12t13_14t15;
// assign add16t19_20t23 = add16t17_18t19 + add20t21_22t23;
// assign add24t27_28t31 = add24t25_26t27 + add28t29_30t31;

// assign add0t7_8t15 = add0t3_4t7 + add8t11_12t15;
// assign add16t23_24t31 = add16t19_20t23 + add24t27_28t31;

// always @(posedge clk or negedge reset)
// if(reset)
//     temp <= 0;
// else
//     temp <= add0t7_8t15 + add16t23_24t31;

// assign z = temp;
