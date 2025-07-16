`timescale 1ns / 1ps


module MUX(
    input  wire [31:0]   adr_npc_i,
    input  wire [31:0]   adr_alu_i,
    input  wire  mux_sel_i,
    output wire  [31:0]   npc_o
    
);

assign npc_o = (mux_sel_i == `MUX_COM) ? adr_npc_i : {adr_alu_i[31:2],2'b00};


endmodule