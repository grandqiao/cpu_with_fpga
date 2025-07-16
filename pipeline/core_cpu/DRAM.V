`timescale 1ns / 1ps

module my_DRAM(
    input wire [31:0]  adr_i, //地址输入
    input wire [31:0]  wdin_i, //写数据输�?
    input wire         ram_op_i, //写使能信�?
    input wire         clk_i, //时钟信号
    output reg [31:0]  rdo_o //读数据输�?
);

// 64KB DRAM
DRAM Mem_DRAM (
    .clk    (clk_i),
    .a      (adr_i[15:2]),
    .spo    (rdo_o),
    .we     (ram_op_i),
    .d      (wdin_i)
);

endmodule