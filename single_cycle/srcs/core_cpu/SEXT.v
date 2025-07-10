`timescale 1ns / 1ps
`include "defines.vh"

module SEXT(
    input  wire [31:0]  din_i, //输入数据
    input  wire [3:0]   sext_op_i, 
    output reg  [31:0]  ext_o //输出数据
);

always @(*) begin
    case (sext_op_i)
        `EXT_I: begin
            ext_o = {{20{din_i[31]}}, din_i[31:20]}; //立即数扩�?
        end
        `EXT_S: begin
            ext_o = {{20{din_i[31]}}, din_i[31:25], din_i[11:7]}; //存储指令扩展
        end
        `EXT_B: begin
            ext_o = {{20{din_i[31]}},din_i[7],din_i[30:25], din_i[11:8], 1'b0}; //分支指令扩展
        end
        `EXT_U: begin
            ext_o = {din_i[31:12], 12'b0}; 
        end
        `EXT_J: begin
            ext_o = {{12{din_i[31]}}, din_i[19:12], din_i[20], din_i[30:21], 1'b0}; //跳转指令扩展
        end
        default: begin
            ext_o = 32'b0; //默认输出�?0
        end
    endcase
end
endmodule