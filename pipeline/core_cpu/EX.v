`timescale 1ns / 1ps
`include "defines.vh"

module EX(
    input wire [31:0] rA_i,
    input wire [31:0] rB_i,
    input wire [2:0] npc_op_i,
    input wire [3:0] alu_op_i,
    input wire [31:0] pc4_i,
    input wire [31:0] imm_i,

    output wire [31:0] npc_o,
    output wire back_o,
    output wire [31:0] alu_c_o
);

wire zero;
wire neg;

NPC U_npc(
    .npc_op_i(npc_op_i),
    .pc4_i(pc4_i),
    .jalr_i(alu_c_o),
    .offset_i(imm_i),
    .zero_i(zero),
    .neg_i(neg),
    .npc_o(npc_o),
    .back_o(back_o)
);

ALU U_alu(
    .alu_a_i(rA_i),
    .alu_b_i(rB_i),
    .alu_op_i(alu_op_i),
    .alu_c_o(alu_c_o),
    .zero_o(zero),
    .neg_o(neg)
);




endmodule