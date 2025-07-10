`timescale 1ns / 1ps
`include "defines.vh"


module IFETCH(
    input  wire         clk_i,
    input  wire         rstn_i,
    input  wire  [1:0]  npc_op_i,
    input  wire      mux_sel_i,
    input  wire      br_i,   //是否分支跳转
    input  wire [31:0]  ext_i,  //立即数输�??
    input  wire [31:0]  alu_pc_i, //jalr计算指令地址
    output reg  [31:0]  pc4_o,   //PC+4指令地址
    output reg  [31:0] current_pc_o
);

reg [31:0] next_pc;     //PC下一条指令地�??
reg [31:0] current_pc;  //PC当前指令地址
reg [31:0] npc_pc;  //NPC计算得指令地�??

PC U_pc(
    .clk_i(clk_i),
    .rstn_i(rstn_i),
    .din_i(next_pc),
    .pc_o(current_pc_o)
);

NPC U_npc(
    .npc_op_i(npc_op_i),
    .pc_i(current_pc_o),
    .br_i(br_i),
    .offset_i(ext_i),
    .npc_o(npc_pc),
    .pc4_o(pc4_o)
);

MUX U_mux(
    .adr_npc_i(npc_pc),
    .adr_alu_i(alu_pc_i),
    .mux_sel_i(mux_sel_i),
    .npc_o(next_pc)
);




endmodule