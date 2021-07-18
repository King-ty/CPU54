`timescale 1ns / 1ps
module MULTU(
    input clk, 
    input reset,
    input [31:0] a,
    input [31:0] b,
    output [31:0] hi,
    output [31:0] lo
);

    assign {hi, lo} = a*b;
    
endmodule

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

// assign stored0 = b[0] && (!reset) ? {32'b0, a} : 64'b0;
// assign stored1 = b[1] && (!reset) ? {31'b0, a, 1'b0} : 64'b0;
// assign stored2 = b[2] && (!reset) ? {30'b0, a, 2'b0} : 64'b0;
// assign stored3 = b[3] && (!reset) ? {29'b0, a, 3'b0} : 64'b0;
// assign stored4 = b[4] && (!reset) ? {28'b0, a, 4'b0} : 64'b0;
// assign stored5 = b[5] && (!reset) ? {27'b0, a, 5'b0} : 64'b0;
// assign stored6 = b[6] && (!reset) ? {26'b0, a, 6'b0} : 64'b0;
// assign stored7 = b[7] && (!reset) ? {25'b0, a, 7'b0} : 64'b0;
// assign stored8 = b[8] && (!reset) ? {24'b0, a, 8'b0} : 64'b0;
// assign stored9 = b[9] && (!reset) ? {23'b0, a, 9'b0} : 64'b0;
// assign stored10 = b[10] && (!reset) ? {22'b0, a, 10'b0} : 64'b0;
// assign stored11 = b[11] && (!reset) ? {21'b0, a, 11'b0} : 64'b0;
// assign stored12 = b[12] && (!reset) ? {20'b0, a, 12'b0} : 64'b0;
// assign stored13 = b[13] && (!reset) ? {19'b0, a, 13'b0} : 64'b0;
// assign stored14 = b[14] && (!reset) ? {18'b0, a, 14'b0} : 64'b0;
// assign stored15 = b[15] && (!reset) ? {17'b0, a, 15'b0} : 64'b0;
// assign stored16 = b[16] && (!reset) ? {16'b0, a, 16'b0} : 64'b0;
// assign stored17 = b[17] && (!reset) ? {15'b0, a, 17'b0} : 64'b0;
// assign stored18 = b[18] && (!reset) ? {14'b0, a, 18'b0} : 64'b0;
// assign stored19 = b[19] && (!reset) ? {13'b0, a, 19'b0} : 64'b0;
// assign stored20 = b[20] && (!reset) ? {12'b0, a, 20'b0} : 64'b0;
// assign stored21 = b[21] && (!reset) ? {11'b0, a, 21'b0} : 64'b0;
// assign stored22 = b[22] && (!reset) ? {10'b0, a, 22'b0} : 64'b0;
// assign stored23 = b[23] && (!reset) ? {9'b0, a, 23'b0} : 64'b0;
// assign stored24 = b[24] && (!reset) ? {8'b0, a, 24'b0} : 64'b0;
// assign stored25 = b[25] && (!reset) ? {7'b0, a, 25'b0} : 64'b0;
// assign stored26 = b[26] && (!reset) ? {6'b0, a, 26'b0} : 64'b0;
// assign stored27 = b[27] && (!reset) ? {5'b0, a, 27'b0} : 64'b0;
// assign stored28 = b[28] && (!reset) ? {4'b0, a, 28'b0} : 64'b0;
// assign stored29 = b[29] && (!reset) ? {3'b0, a, 29'b0} : 64'b0;
// assign stored30 = b[30] && (!reset) ? {2'b0, a, 30'b0} : 64'b0;
// assign stored31 = b[31] && (!reset) ? {1'b0, a, 31'b0} : 64'b0;

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
