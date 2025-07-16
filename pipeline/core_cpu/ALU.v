`timescale 1ns / 1ps
`include "defines.vh"

module ALU(
    input wire [31:0] alu_a_i,
    input wire [31:0] alu_b_i,
    input wire [3:0] alu_op_i,
    
    output reg [31:0] alu_c_o,
    output reg zero_o,  //零标志位
    output reg neg_o    //负标志位
);


always @(*) begin
    

    case (alu_op_i)
        `ALU_ADD: begin
            alu_c_o = alu_a_i + alu_b_i; //加法
        end
        `ALU_SUB: begin
            alu_c_o = alu_a_i - alu_b_i; //减法
        end
        `ALU_AND: begin
            alu_c_o = alu_a_i & alu_b_i; //按位�?
        end
        `ALU_OR: begin
            alu_c_o = alu_a_i | alu_b_i; //按位�?
        end
        `ALU_XOR: begin
            alu_c_o = alu_a_i ^ alu_b_i; //按位异或
        end
        `ALU_SLL: begin
            alu_c_o = alu_a_i << alu_b_i[4:0]; //逻辑左移
        end
        `ALU_SRL: begin
            alu_c_o = alu_a_i >> alu_b_i[4:0]; //逻辑右移
        end
        `ALU_SRA:begin
            alu_c_o = ($signed(alu_a_i)) >>> alu_b_i[4:0]; //算术右移
        end
        default: begin
            alu_c_o = 32'b0; //默认值为0
        end
    endcase
    zero_o = (alu_c_o == 32'b0); //零标志位
    neg_o = alu_c_o[31]; //负标志位
end



endmodule