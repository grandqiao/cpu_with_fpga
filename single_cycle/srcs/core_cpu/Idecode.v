`timescale 1ns / 1ps
`include "defines.vh"

module IDECODE(
    input wire WE_i,    //寄存器写使能
    input wire clk_i,
    input wire [1:0] we_op_i, //寄存器写操作选择
    input wire [31:0] alu_c_i,  //alu计算结果输入
    input wire [31:0] dram_rdo_i, //DRAM读数据输�?
    input wire [31:0] npc_pc4_i, //PC+4指令
    input wire [3:0] sext_op_i,
    input wire [31:0] inst_i, //指令输入
    output wire [31:0] rD1_o, //寄存�?1输出
    output wire [31:0] rD2_o, //寄存�?2输出
    output wire [31:0] imm_o, //立即数输�?
    output wire [31:0] debug_wd_o
);

reg [31:0] Wd; //写寄存器数据

assign debug_wd_o = Wd; //调试输出

always @(*) begin
    case (we_op_i)
        `WE_ALU: begin
            Wd = alu_c_i; //ALU计算结果
        end
        `WE_DRAM: begin
            Wd = dram_rdo_i; //DRAM读数�?
        end
        `WE_PC4: begin
            Wd = npc_pc4_i; //PC+4指令地址
        end
        `WE_SEXT: begin
            Wd = imm_o; //立即数扩展结�?
        end
        default: begin
            Wd = 32'b0; //默认�?
        end
    endcase
end

RF U_rf(
    .rR1_i(inst_i[19:15]),
    .rR2_i(inst_i[24:20]),
    .wR_i(inst_i[11:7]),
    .WE_i(WE_i),
    .Wd_i(Wd),
    .clk_i(clk_i),
    .rD1_o(rD1_o),
    .rD2_o(rD2_o)
);

SEXT U_ext(
    .din_i(inst_i),
    .sext_op_i(sext_op_i),
    .ext_o(imm_o)
);


endmodule