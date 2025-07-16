`timescale 1ns / 1ps
`include "defines.vh"

module IDECODE(
    input wire WE_i,
    input wire clk_i,
    input wire [31:0] inst_i,
    input wire [31:0] Wd_i,
    input wire [4:0] wR_i,

    output wire [31:0] rA_o,
    output wire [31:0] rB_o,
    output wire [31:0] imm_o,
    output wire [1:0] rf_sel_o,
    output wire [2:0] npc_op_o,
    output wire rf_we_o,
    output wire dram_we_o,
    output wire [3:0] alu_op_i,
    output wire [4:0] wR_o,
    output wire [31:0] rD2_o
);

wire [1:0] alu_b_sel;
wire [3:0] sext_op;



assign wR_o = inst_i[11:7];
assign rB_o = (alu_b_sel == `ALU_B_R) ? rD2_o : imm_o;

CONTROLLER U_CTRL(
    .irom_i(inst_i),
    .alu_b_sel_o(alu_b_sel),
    .rf_we_o(rf_we_o),
    .rf_sel_o(rf_sel_o),
    .ram_op_o(dram_we_o),
    .alu_op_o(alu_op_i),
    .ext_op_o(sext_op),
    .npc_op_o(npc_op_o)
);

RF U_rf(
    .rR1_i(inst_i[19:15]),
    .rR2_i(inst_i[24:20]),
    .wR_i(wR_i),
    .WE_i(WE_i),
    .Wd_i(Wd_i),
    .clk_i(clk_i),
    .rD1_o(rA_o),
    .rD2_o(rD2_o)
);

SEXT U_ext(
    .din_i(inst_i),
    .sext_op_i(sext_op),
    .ext_o(imm_o)
);


endmodule