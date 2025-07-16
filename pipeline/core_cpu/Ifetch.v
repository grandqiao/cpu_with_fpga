`timescale 1ns / 1ps
`include "defines.vh"


module IFETCH(
    input  wire         clk_i,
    input  wire         rst_i,
    input  wire [31:0]  npc_i,
    input  wire         back_i,
    input  wire         keep_i,
    output wire [31:0]  pc4_if_o,
    output wire [31:0]  pc_if_o
);


PC U_pc(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .npc_i(npc_i),
    .back_i(back_i),
    .keep_i(keep_i),
    .pc_o(pc_if_o),
    .pc4_o(pc4_if_o)
);




endmodule