`timescale 1ns / 1ps
`include "defines.vh"

module ALU(
    input wire [31:0] alu_a_i,
    input wire [31:0] imm_i,
    input wire [31:0] rD2_i,
    input wire [3:0] alu_op_i,
    input wire [1:0] alu_sel_i,
    output reg [31:0] alu_c_o,
    output reg zero_o,  //零标志位
    output reg neg_o    //负标志位
);

reg [31:0] alu_b;
reg [31:0] alu_comp;    //补码

always @(*) begin
    case (alu_sel_i)
        `ALU_B_R: begin
            alu_b = rD2_i;
        end
        `ALU_B_I: begin
            alu_b = imm_i;
        end
        default: begin
            alu_b = rD2_i;
        end
    endcase

    alu_comp = (~alu_b)+1'b1;

    case (alu_op_i)
        `ALU_ADD: begin
            alu_c_o = alu_a_i + alu_b; //加法
        end
        `ALU_SUB: begin
            alu_c_o = alu_a_i + alu_comp; //减法
        end
        `ALU_AND: begin
            alu_c_o = alu_a_i & alu_b; //按位�?
        end
        `ALU_OR: begin
            alu_c_o = alu_a_i | alu_b; //按位�?
        end
        `ALU_XOR: begin
            alu_c_o = alu_a_i ^ alu_b; //按位异或
        end
        `ALU_SLL: begin
            alu_c_o = alu_a_i << alu_b[4:0]; //逻辑左移
        end
        `ALU_SRL: begin
            alu_c_o = alu_a_i >> alu_b[4:0]; //逻辑右移
        end
        `ALU_SRA:begin
            case (alu_b[4:0])
                5'd0:  alu_c_o = {{1{alu_a_i[31]}}, alu_a_i[30:0]};
                5'd1:  alu_c_o = {{2{alu_a_i[31]}}, alu_a_i[30:1]};
                5'd2:  alu_c_o = {{3{alu_a_i[31]}}, alu_a_i[30:2]};
                5'd3:  alu_c_o = {{4{alu_a_i[31]}}, alu_a_i[30:3]};
                5'd4:  alu_c_o = {{5{alu_a_i[31]}}, alu_a_i[30:4]};
                5'd5:  alu_c_o = {{6{alu_a_i[31]}}, alu_a_i[30:5]};
                5'd6:  alu_c_o = {{7{alu_a_i[31]}}, alu_a_i[30:6]};
                5'd7:  alu_c_o = {{8{alu_a_i[31]}}, alu_a_i[30:7]};
                5'd8:  alu_c_o = {{9{alu_a_i[31]}}, alu_a_i[30:8]};
                5'd9:  alu_c_o = {{10{alu_a_i[31]}}, alu_a_i[30:9]};
                5'd10: alu_c_o = {{11{alu_a_i[31]}}, alu_a_i[30:10]};
                5'd11: alu_c_o = {{12{alu_a_i[31]}}, alu_a_i[30:11]};
                5'd12: alu_c_o = {{13{alu_a_i[31]}}, alu_a_i[30:12]};
                5'd13: alu_c_o = {{14{alu_a_i[31]}}, alu_a_i[30:13]};
                5'd14: alu_c_o = {{15{alu_a_i[31]}}, alu_a_i[30:14]};
                5'd15: alu_c_o = {{16{alu_a_i[31]}}, alu_a_i[30:15]};
                5'd16: alu_c_o = {{17{alu_a_i[31]}}, alu_a_i[30:16]};
                5'd17: alu_c_o = {{18{alu_a_i[31]}}, alu_a_i[30:17]};
                5'd18: alu_c_o = {{19{alu_a_i[31]}}, alu_a_i[30:18]};
                5'd19: alu_c_o = {{20{alu_a_i[31]}}, alu_a_i[30:19]};
                5'd20: alu_c_o = {{21{alu_a_i[31]}}, alu_a_i[30:20]};
                5'd21: alu_c_o = {{22{alu_a_i[31]}}, alu_a_i[30:21]};
                5'd22: alu_c_o = {{23{alu_a_i[31]}}, alu_a_i[30:22]};
                5'd23: alu_c_o = {{24{alu_a_i[31]}}, alu_a_i[30:23]};
                5'd24: alu_c_o = {{25{alu_a_i[31]}}, alu_a_i[30:24]};
                5'd25: alu_c_o = {{26{alu_a_i[31]}}, alu_a_i[30:25]};
                5'd26: alu_c_o = {{27{alu_a_i[31]}}, alu_a_i[30:26]};
                5'd27: alu_c_o = {{28{alu_a_i[31]}}, alu_a_i[30:27]};
                5'd28: alu_c_o = {{29{alu_a_i[31]}}, alu_a_i[30:28]};
                5'd29: alu_c_o = {{30{alu_a_i[31]}}, alu_a_i[30:29]};
                5'd30: alu_c_o = {{31{alu_a_i[31]}}, alu_a_i[30]};
                5'd31: alu_c_o = {32{alu_a_i[31]}};
                default: alu_c_o = {32{alu_a_i[31]}};
            endcase

            // alu_c_o = alu_a_i >>> alu_b[4:0]; //算术右移
        end
        default: begin
            alu_c_o = 32'b0; //默认值为0
        end
    endcase
    zero_o = (alu_c_o == 32'b0); //零标志位
    neg_o = alu_c_o[31]; //负标志位
end



endmodule