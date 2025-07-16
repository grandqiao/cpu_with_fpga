// Annotate this macro before synthesis
`define RUN_TRACE

// TODO: 在此处定义你的宏
// 

`ifndef DEFINEVH
`define DEFINEVH

`define MUX_COM 2'b00
`define MUX_JALR 2'b01

`define DATA_CTRL_NORMAL 2'b00 //正常数据流控制
`define DATA_CTRL_STOP 2'b01
`define DATA_CTRL_FLUSH 2'b10

// NPC选择器的输入
`define NPC_PC4 3'b000
`define NPC_JMP 3'b001
`define NPC_JALR 3'b011
`define NPC_BEQ 3'b100
`define NPC_BNE 3'b101
`define NPC_BLT 3'b110
`define NPC_BGE 3'b111


//  立即数扩展
`define EXT_I 4'b0000
`define EXT_S 4'b0001
`define EXT_B 4'b0010
`define EXT_U 4'b0011
`define EXT_J 4'b0100
`define EXT_R 4'b1111

//RF写回输入
`define WE_ALU 2'b00
`define WE_DRAM 2'b01
`define WE_PC4 2'b10
`define WE_SEXT 2'b11
`define WE_NONE 2'b11

// RAM操作
`define RAM_READ 1'b0
`define RAM_NONE 1'b0
`define RAM_WRITE 1'b1


// ALU操作�??
`define ALU_ADD 4'b0000
`define ALU_SUB 4'b1000
`define ALU_AND 4'b0111
`define ALU_OR  4'b0110
`define ALU_XOR 4'b0100
`define ALU_SLL 4'b0001
`define ALU_SRL 4'b0101
`define ALU_SRA 4'b1101

// ALU_b选择信号
`define ALU_B_R 2'b00 //寄存�??
`define ALU_B_I 2'b01 //立即�??

// opcode 选择信号
`define OPCODE_R 7'b0110011 //R型指�??
`define OPCODE_I 7'b0010011 //I型指�??
`define OPCODE_LOAD 7'b0000011 //load
`define OPCODE_JAL 7'b1101111 //jal指令
`define OPCODE_JALR 7'b1100111 //jalr指令
`define OPCODE_STORE 7'b0100011 //store
`define OPCODE_BRANCH 7'b1100011 //branch指令
`define OPCODE_LUI 7'b0110111 //lui指令

// fun3
`define FUN3_ADD 3'b000 //加法
`define FUN3_AND 3'b111 //�??
`define FUN3_OR  3'b110 //�??
`define FUN3_XOR 3'b100 //异或
`define FUN3_SL 3'b001 //左移
`define FUN3_SR 3'b101 //右移
`define FUN3_BEQ 3'b000 //等于
`define FUN3_BNE 3'b001 //不等�?
`define FUN3_BLT 3'b100 //小于
`define FUN3_BGE 3'b101 //大于等于

// fun7
`define FUN7_SRL 7'b0000000 //逻辑右移
`define FUN7_SRA 7'b0100000 //算术右移


// 外设I/O接口电路的端口地
`define PERI_ADDR_DIG   32'hFFFF_F000
`define PERI_ADDR_LED   32'hFFFF_F060
`define PERI_ADDR_SW    32'hFFFF_F070
`define PERI_ADDR_BTN   32'hFFFF_F078
`define PERI_ADDR_CNT  32'hFFFF_F020

`define DEBOUNCE_TIME 32'd80000 // 按键消抖时间
`define DIG_MAX 32'd80000



`endif