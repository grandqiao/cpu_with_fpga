`timescale 1ns / 1ps
`include "defines.vh"

module NPC(
    input  wire  [1:0]  npc_op_i,
    input  wire [31:0]  pc_i, 
    input  wire    br_i,  
    input  wire [31:0]  offset_i, 
    output reg [31:0]  npc_o, 
    output reg  [31:0]  pc4_o  
);


always @(*) begin
    pc4_o = pc_i + 32'd4; //PC+4指令地址
    case (npc_op_i)
        `NPC_PC4: begin
            npc_o = pc_i + 32'd4;
        end
        `NPC_JMP: begin
            npc_o = pc_i + offset_i; //跳转指令地址
        end
        `NPC_BRC: begin
            if (br_i) begin //分支跳转
                npc_o = pc_i + offset_i; //跳转指令地址
            end else begin //不分支跳�?
                npc_o = pc_i + 32'd4; //PC+4指令地址
            end
        end
        default: begin
            npc_o = pc_i + 32'd4; //默认PC+4指令地址
        end
    endcase
end

endmodule