`timescale 1ns / 1ps
`include "defines.vh"

module NPC(
    input wire [3:0] npc_op_i,
    input wire [31:0] pc4_i,
    input wire [31:0] jalr_i,
    input wire [31:0] offset_i,
    input wire zero_i,
    input wire neg_i,

    output wire [31:0] npc_o,
    output wire back_o
);

wire [31:0] pc;
assign pc = pc4_i - 4;

assign back_o = (npc_op_i == `NPC_JALR) ? 1'b1 :
                 (npc_op_i == `NPC_JMP) ? 1'b1 : 
                 (npc_op_i == `NPC_BEQ && zero_i) ? 1'b1 :
                 (npc_op_i == `NPC_BNE && !zero_i) ? 1'b1 :
                 (npc_op_i == `NPC_BLT && neg_i) ? 1'b1 :
                 (npc_op_i == `NPC_BGE && !neg_i) ? 1'b1 : 1'b0;

assign npc_o = (npc_op_i == `NPC_JALR) ? jalr_i :
                (npc_op_i == `NPC_JMP) ? offset_i+pc :
                (npc_op_i == `NPC_BEQ && zero_i) ? offset_i+pc :
                (npc_op_i == `NPC_BNE && !zero_i) ? offset_i+pc :
                (npc_op_i == `NPC_BLT && neg_i) ? offset_i+pc :
                (npc_op_i == `NPC_BGE && !neg_i) ? offset_i+pc :
                32'b0;

endmodule