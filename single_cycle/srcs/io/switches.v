`timescale 1ns / 1ps

`include "defines.vh"

module SWITCHES(
    input wire  clk_i,
    input wire  rst_i,
    input wire [31:0] data_i,
    output wire [31:0] data_o
);

assign data_o = data_i;

endmodule
