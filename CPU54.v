`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/28 21:38:21
// Design Name: 
// Module Name: cpu
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


module cpu(
	input clk,		//时钟信号
	input ena,		//使能信号
	input rst,		//置位信号
	output DM_ena,	//输出DMEM使能信号
	output DM_R,	//输出DMEM read信号
	output DM_W,	//输出DMEM write信号
	input [31:0] IM_instr,	//输入IMEM指令
	input [31:0] DM_rdata,	//输入DMEM读取的数据
	output [1:0] DM_sel,
	output [31:0] DM_wdata,	//输出要写入DMEM的数据
	output [31:0] PC_OUT,	//输出PC寄存器
	output [31:0] ALU_OUT	//输出ALU运算结果
	);

	parameter PC_START = 32'h0040_0000;

	parameter	CAUSE_SYSCALL	= 5'b01000,
				CAUSE_BREAK		= 5'b01001,
				CAUSE_TEQ		= 5'b01101;

	/*
		parameter ALU_ADD	= 4'b0010;
		parameter ALU_ADDU	= 4'b0000;
		parameter ALU_SUB	= 4'b0011;
		parameter ALU_SUBU	= 4'b0001;
		parameter ALU_AND	= 4'b0100;
		parameter ALU_OR	= 4'b0101;
		parameter ALU_XOR	= 4'b0110;
		parameter ALU_NOR	= 4'b0111;
		parameter ALU_LUI	= 4'b1000;//4'b100x
		parameter ALU_SLT	= 4'b1011;
		parameter ALU_SLTU	= 4'b1010;
		parameter ALU_SRA	= 4'b1100;
		parameter ALU_SLL	= 4'b1110;//4'b111x
		parameter ALU_SRL	= 4'b1101;
	*/

	// 拆分指令
	wire [5:0] _op		= IM_instr[31:26];
	wire [4:0] _rs		= IM_instr[25:21];
	wire [4:0] _rt		= IM_instr[20:16];
	wire [4:0] _rd		= IM_instr[15:11];
	wire [4:0] _shamt	= IM_instr[10:6];
	wire [5:0] _func	= IM_instr[5:0];
	wire [15:0] _immediate	= IM_instr[15:0];
	wire [25:0] _address	= IM_instr[25:0];

	// R-type
	wire ADD	= _op == 6'b0 && _func == 6'b100000;
	wire ADDU   = _op == 6'b0 && _func == 6'b100001;
	wire SUB	= _op == 6'b0 && _func == 6'b100010;
	wire SUBU   = _op == 6'b0 && _func == 6'b100011;
	wire AND	= _op == 6'b0 && _func == 6'b100100;
	wire OR		= _op == 6'b0 && _func == 6'b100101;
	wire XOR	= _op == 6'b0 && _func == 6'b100110;
	wire NOR	= _op == 6'b0 && _func == 6'b100111;
	wire SLT	= _op == 6'b0 && _func == 6'b101010;
	wire SLTU	= _op == 6'b0 && _func == 6'b101011;
	wire SLL	= _op == 6'b0 && _func == 6'b000000;
	wire SRL	= _op == 6'b0 && _func == 6'b000010;
	wire SRA	= _op == 6'b0 && _func == 6'b000011;
	wire SLLV	= _op == 6'b0 && _func == 6'b000100;
	wire SRLV	= _op == 6'b0 && _func == 6'b000110;
	wire SRAV	= _op == 6'b0 && _func == 6'b000111;
	wire JR		= _op == 6'b0 && _func == 6'b001000;

	// I-type
	wire ADDI	= _op == 6'b001000;
	wire ADDIU	= _op == 6'b001001;
	wire ANDI	= _op == 6'b001100;
	wire ORI	= _op == 6'b001101;
	wire XORI	= _op == 6'b001110;
	wire LUI	= _op == 6'b001111;
	wire LW		= _op == 6'b100011;
	wire SW		= _op == 6'b101011;
	wire BEQ	= _op == 6'b000100;
	wire BNE	= _op == 6'b000101;
	wire SLTI	= _op == 6'b001010;
	wire SLTIU	= _op == 6'b001011;

	// J-type
	wire J		= _op == 6'b000010;
	wire JAL	= _op == 6'b000011;

	// 23New
	wire DIV	= _op == 6'b000000 && _func == 6'b011010;
	wire DIVU	= _op == 6'b000000 && _func == 6'b011011;
	wire MUL	= _op == 6'b011100 && _func == 6'b000010;
	wire MULTU	= _op == 6'b000000 && _func == 6'b011001;
	wire BGEZ	= _op == 6'b000001;
	wire JALR	= _op == 6'b000000 && _func == 6'b001001;
	wire LBU	= _op == 6'b100100;
	wire LHU	= _op == 6'b100101;
	wire LB		= _op == 6'b100000;
	wire LH		= _op == 6'b100001;
	wire SB		= _op == 6'b101000;
	wire SH		= _op == 6'b101001;
	wire BREAK	= _op == 6'b000000 && _func == 6'b001101;
	wire SYSCALL= _op == 6'b000000 && _func == 6'b001100;
	wire ERET	= _op == 6'b010000 && _func == 6'b011000;
	wire MFHI	= _op == 6'b000000 && _func == 6'b010000;
	wire MFLO	= _op == 6'b000000 && _func == 6'b010010;
	wire MTHI	= _op == 6'b000000 && _func == 6'b010001;
	wire MTLO	= _op == 6'b000000 && _func == 6'b010011;
	wire MFC0	= _op == 6'b010000 && _rs == 5'b00000;// && _func == 6'b000000;
	wire MTC0	= _op == 6'b010000 && _rs == 5'b00100;// && _func == 6'b000000;
	wire CLZ	= _op == 6'b011100 && _func == 6'b100000;
	wire TEQ	= _op == 6'b000000 && _func == 6'b110100;

	// ALU标志位
	wire _zero, _carry, _negative, _overflow;

	// 数据选择器信号
	wire M1		= (BEQ && _zero) || (BNE && !_zero) || (BGEZ && !_negative);
	wire M2		= J || JAL;
	wire M3		= JR || JALR;
	wire M4		= JAL || JALR;//
	wire M5		= LW;
	wire M6		= SLL || SRL || SRA || SLLV || SRLV || SRAV;
	wire M7		= ADDI || ADDIU || ANDI || ORI || XORI || LW || SW || SLTI || SLTIU || LUI || LB || LBU || LH || LHU || SB || SH;
	wire M8		= ADDI || ADDIU || LW || SW || SLTI || SLTIU || LB || LBU || LH || LHU || SB || SH;//sign ext
	wire M9		= ADDI || ADDIU || ANDI || ORI || XORI || LUI || LW || SLTI || SLTIU || LBU || LHU || LB || LH || MFC0;
	wire M10	= SLL || SRL || SRA;
	wire M11	= ERET || BREAK;//图中M12
	wire M12	= MFHI;//图中M8，选择HI
	wire M13	= MUL;//图中M9，选择MUL
	// wire M14	= MUL || MULU;//M13 in pic
	wire M15	= MFHI || MFLO;
	wire M16	= LW || LB || LH || LBU || LHU;//else CLZ
	wire M17	= LBU || LHU;//zero ext
	wire M18	= LH || LHU;//load half
	// wire M19	= LB || LBU;//load byte
	wire M20	= CLZ;
	wire M21	= MFC0;

	wire [3:0] ALUC;
	assign ALUC[3] = SLT || SLTI || SLTU || SLTIU || SLL || SLLV || SRL || SRLV || SRA || SRAV || LUI;
	assign ALUC[2] = AND || ANDI || OR || ORI || XOR || XORI || NOR || SLL || SLLV || SRL || SRLV || SRA || SRAV;
	assign ALUC[1] = ADD || ADDI || SUB || BEQ || BNE || XOR || XORI || NOR || SLT || SLTI || SLTU || SLTIU || SLL || SLLV || BGEZ || TEQ || LW || SW || LBU || LHU || LB || LH || SB || SH;//
	assign ALUC[0] = SUB || BEQ || BNE || SUBU || OR || ORI || NOR || SLT || SLTI || SRL || SRLV || BGEZ || TEQ;

	// PC
	reg [31:0] PC;
	wire [31:0] NPC	= PC + 4;
	assign PC_OUT = PC;

	// regs
	wire [4:0] RsC = _rs;
	wire [4:0] RtC = _rt;
	wire [4:0] RdC = JAL ? 5'd31 : (M9 ? _rt : _rd);
	wire [31:0] Rd;
	wire [31:0] Rs;
	wire [31:0] Rt;
	wire RF_W = !(JR || SW || BEQ || BNE || J || DIV || DIVU || BGEZ || SB || SH || BREAK || SYSCALL || ERET || MTHI || MTLO || MTC0 || TEQ);//因为基本上都需要往RF中写东西，故采用取反的方式简化代码
	
	// CP0
	wire exception		= BREAK || SYSCALL || TEQ;
	wire [4:0] cause	= BREAK ? CAUSE_BREAK : (SYSCALL ? CAUSE_SYSCALL : (TEQ ? CAUSE_TEQ : 5'bz) );///是否是z？
	wire [31:0] CP0_wdata	= Rt;
	wire [31:0] CP0_rdata;
	wire [31:0] status;
	wire [31:0] EPC;

	// ALU
	wire [31:0] ALU_A = M6 ? {27'b0,(M10 ? _shamt : Rs[4:0])} : Rs;
	wire [31:0] ALU_B = M7 ? (M8 ? {{16{_immediate[15]}},_immediate} : {16'b0,_immediate}) : (BGEZ ? 32'b0 : Rt);

	// div
	wire [31:0] div_lo, div_hi, divu_lo, divu_hi;
	wire div_busy, divu_busy;
	wire busy = div_busy | divu_busy;

	// mul, multu
	wire [31:0] mul_out;
	wire [31:0] multu_hi, multu_lo;

	// lo, hi
	wire [31:0] lo_in = MTLO ? Rs : (MULTU ? multu_lo : (DIV ? div_lo : divu_lo));
	wire [31:0] hi_in = MTHI ? Rs : (MULTU ? multu_hi : (DIV ? div_hi : divu_hi));
	wire [31:0] lo_out, hi_out;
	wire HI_ENA = MULTU | DIV | DIVU | MTHI;
	wire LO_ENA = MULTU | DIV | DIVU | MTLO;

	// CLZ
	wire [31:0] clz_out;
	
	regfile cpu_ref(
		.RF_ena(ena),
		.RF_rst(rst),
		.RF_clk(clk),
		.RF_W(RF_W),
		.RdC(RdC),
		.RsC(RsC),
		.RtC(RtC),
		.Rd(Rd),
		.Rs(Rs),
		.Rt(Rt)
	);

	CP0 _cp0(
		.clk(clk),
		.rst(rst),
		.mfc0(MFC0), // CPU instruction is Mfc0
		.mtc0(MTC0), // CPU instruction is Mtc0
		.pc(PC),
		.Rd(_rd), // Specifies Cp0 register
		.wdata(CP0_wdata), // Data from GP register to replace CP0 register
		.exception(exception),
		.eret(ERET), // Instruction is ERET (Exception Return)
		.cause(cause),
		.rdata(CP0_rdata), // Data from CP0 register for GP register
		.status(status),
		.exc_addr(EPC)
	);

	alu _alu(
		.a(ALU_A),
		.b(ALU_B),
		.aluc(ALUC),
		.r(ALU_OUT),
		.zero(_zero),
		.carry(_carry),
		.negative(_negative),
		.overflow(_overflow)
	);

	pc_reg _lo(
		.clk(clk),
		.rst(rst),
		.ena(LO_ENA),
		.data_in(lo_in),
		.data_out(lo_out)
	);

	pc_reg _hi(
		.clk(clk),
		.rst(rst),
		.ena(HI_ENA),
		.data_in(hi_in),
		.data_out(hi_out)
	);

	DIV _div(
		.dividend(Rs), //被除数
		.divisor(Rt), //除数
		.start(DIV & ~busy), //启动除法运算//start = is_div & ~busy
		.clock(clk),
		.reset(rst),
		.q(div_lo), //商
		.r(div_hi), //余数
		.busy(div_busy) //除法器忙标志位
	);

	DIVU _divu(
		.dividend(Rs), //被除数
		.divisor(Rt), //除数
		.start(DIVU & ~busy), //启动除法运算//start = is_div & ~busy
		.clock(clk),
		.reset(rst),
		.q(divu_lo), //商
		.r(divu_hi), //余数
		.busy(divu_busy) //除法器忙标志位
	);

	MUL _mul(
		.clk(clk), 
		.reset(rst),
		.a(Rs),
		.b(Rt),
		.out(mul_out)
	);

	MULTU _multu(
		.clk(clk), 
		.reset(rst),
		.a(Rs),
		.b(Rt),
		.hi(multu_hi),
		.lo(multu_lo)
	);

	_CLZ _clz(
		.in(Rs),
		.out(clz_out)
	);

	assign DM_ena	= LW || SW || LBU || LHU || LB || LH || SB || SH;
	assign DM_R		= LW || LBU || LHU || LB || LH;
	assign DM_W		= SW || SB || SH;
	assign DM_wdata	= Rt;
	wire DM_32		= LW | SW;
	wire DM_16		= LW | SW | LH | LHU | SH;
	assign DM_sel	= {DM_32, DM_16};

	always@(negedge clk or posedge rst)//negedge
	begin
		if(ena && rst)
			PC <= PC_START;
		else if(ena)
		begin
			PC <= busy ? PC : (M3 ? Rs : (M2 ? {PC[31:28],_address,2'b0} : (M1 ? NPC + {{14{_immediate[15]}},_immediate,2'b00} : (M11 ? EPC : NPC))));
		end
	end

	assign Rd = M4 ? NPC :
				// (M14 ? (M13 ? mul_out : mulu_out) : 
				(M13 ? mul_out : 
				(M15 ? (M12 ? hi_out : lo_out) : 
				(M16 ? (M5 ? DM_rdata : 
				(M18 ? {M17 ? 16'b0 : {16{DM_rdata[15]}},DM_rdata[15:0]} : 
				{M17 ? 24'b0 : {24{DM_rdata[7]}},DM_rdata[7:0]})) : 
				(M20 ? clz_out :
				(M21 ? CP0_rdata :
				ALU_OUT)))));

endmodule
