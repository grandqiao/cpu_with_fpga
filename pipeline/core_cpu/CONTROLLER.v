`timescale 1ns / 1ps
`include "defines.vh"

module CONTROLLER(
    input wire [31:0] irom_i, //指令ROM输入
    output reg [2:0] npc_op_o, 
    output reg rf_we_o, //寄存器写使能
    output reg [1:0] rf_sel_o, //寄存器写数据选择
    output reg [3:0] ext_op_o, //立即数扩展操�?
    output reg [3:0] alu_op_o, //ALU操作�?
    output reg [1:0] alu_b_sel_o, //ALU操作数B
    output reg ram_op_o //RAM操作

);

wire [2:0] fun3;
wire [6:0] fun7;
wire [6:0] opcode;

assign fun3 = irom_i[14:12];
assign fun7 = irom_i[31:25];
assign opcode = irom_i[6:0];

always @(*) begin
    
    if (opcode == `OPCODE_R) begin
        alu_op_o = {fun7[5], fun3};
    end else if (opcode == `OPCODE_I) begin
        if (fun3 == `FUN3_SR | fun3 == `FUN3_SL)   alu_op_o = {fun7[5], fun3};
        else alu_op_o = {1'b0, fun3};
    end else if (opcode == `OPCODE_BRANCH) begin
        alu_op_o = `ALU_SUB;
    end else begin
        alu_op_o = 4'b0000;
    end 
    case (opcode)
        `OPCODE_R: begin
            npc_op_o = `NPC_PC4;
            rf_we_o = 1'b1;
            rf_sel_o = `WE_ALU;
            ext_op_o = `EXT_R;
            alu_b_sel_o = `ALU_B_R;
            ram_op_o = `RAM_NONE;
        end
        `OPCODE_I: begin
            npc_op_o = `NPC_PC4;
            rf_we_o = 1'b1;
            rf_sel_o = `WE_ALU;
            ext_op_o = `EXT_I;
            alu_b_sel_o = `ALU_B_I;
            ram_op_o = `RAM_NONE;
        end
        `OPCODE_LOAD: begin
            npc_op_o = `NPC_PC4;
            rf_we_o = 1'b1;
            rf_sel_o = `WE_DRAM;
            ext_op_o = `EXT_I;
            alu_b_sel_o = `ALU_B_I;
            ram_op_o = `RAM_READ;
        end
        `OPCODE_JALR: begin
            npc_op_o = `NPC_JALR;
            rf_we_o = 1'b1;
            rf_sel_o = `WE_PC4;
            ext_op_o = `EXT_I;
            alu_b_sel_o = `ALU_B_I;
            ram_op_o = `RAM_NONE;
        end
        `OPCODE_STORE: begin
            npc_op_o = `NPC_PC4;
            rf_we_o = 1'b0;
            rf_sel_o = `WE_NONE;
            ext_op_o = `EXT_S;
            alu_b_sel_o = `ALU_B_I;
            ram_op_o = `RAM_WRITE;
        end
        `OPCODE_BRANCH: begin
            case(fun3)
                `FUN3_BEQ: begin
                    npc_op_o = `NPC_BEQ;
                end
                `FUN3_BNE: begin
                    npc_op_o = `NPC_BNE;
                end
                `FUN3_BLT: begin
                    npc_op_o = `NPC_BLT;
                end
                `FUN3_BGE: begin
                    npc_op_o = `NPC_BGE;
                end
                default: begin
                    npc_op_o = `NPC_PC4;
                end
            endcase
            rf_we_o = 1'b0;
            rf_sel_o = `WE_NONE;
            ext_op_o = `EXT_B;
            alu_b_sel_o = `ALU_B_R;
            ram_op_o = `RAM_NONE;
        end
        `OPCODE_LUI: begin
            npc_op_o = `NPC_PC4;
            rf_we_o = 1'b1;
            rf_sel_o = `WE_SEXT;
            ext_op_o = `EXT_U;
            alu_b_sel_o = `ALU_B_I;
            ram_op_o = `RAM_NONE;
        end
        `OPCODE_JAL: begin
            npc_op_o = `NPC_JMP;
            rf_we_o = 1'b1;
            rf_sel_o = `WE_PC4;
            ext_op_o = `EXT_J;
            alu_b_sel_o = `ALU_B_I;
            ram_op_o = `RAM_NONE;
        end
        default: begin
            npc_op_o = `NPC_PC4;
            rf_we_o = 1'b0;
            rf_sel_o = `WE_NONE;
            ext_op_o = `EXT_R;
            alu_b_sel_o = `ALU_B_R;
            ram_op_o = `RAM_NONE;
        end
    endcase

    // if (opcode == `OPCODE_BRANCH) begin
    //     if (fun3 == `FUN3_BEQ) begin
    //         br_o = (zero_i == 1'b1) ? 1'b1 : 1'b0; //等于分支
    //     end else if (fun3 == `FUN3_BLT) begin
    //         br_o = (neg_i == 1'b1) ? 1'b1 : 1'b0; //小于分支
    //     end else begin
    //         br_o = 1'b0;
    //     end
    // end else begin
    //     br_o = 1'b0; //非分支指�?
    // end
end

endmodule