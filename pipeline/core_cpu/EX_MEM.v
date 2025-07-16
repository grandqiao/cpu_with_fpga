`timescale 1ns / 1ps

module EX_MEM(
    input  wire         clk_i  ,
    input  wire         rst_i ,
    input  wire [1:0]   data_ctrl_i,

    input  wire [31:0]  pc4_i,
    input  wire [1:0]   rf_sel_i,
    input  wire rf_we_i,
    input  wire         dram_we_i,
    input  wire [31:0]  alu_c_i,
    input  wire [31:0]  rD2_i,
    input  wire [31:0]  imm_i,
    input  wire [4:0]   wR_i,

    output reg  [31:0]  pc4_o,
    output reg  [1:0]   rf_sel_o,
    output reg          rf_we_o,
    output reg          dram_we_o,
    output reg [31:0]  alu_c_o,
    output reg [31:0]  rD2_o,
    output reg [31:0]  imm_o,
    output reg [4:0]   wR_o
);

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        pc4_o <= 32'b0;
        rf_sel_o <= 2'b0;
        rf_we_o <= 1'b0;
        dram_we_o <= 1'b0;
        alu_c_o <= 32'b0;
        rD2_o <= 32'b0;
        imm_o <= 32'b0;
        wR_o <= 5'b0;
    end else begin
        case(data_ctrl_i)
            `DATA_CTRL_NORMAL: begin
                pc4_o <= pc4_i;
                rf_sel_o <= rf_sel_i;
                rf_we_o <= rf_we_i;
                dram_we_o <= dram_we_i;
                alu_c_o <= alu_c_i;
                rD2_o <= rD2_i;
                imm_o <= imm_i;
                wR_o <= wR_i;
            end
            `DATA_CTRL_FLUSH: begin
                pc4_o <= 32'b0;
                rf_sel_o <= 2'b0;
                rf_we_o <= 1'b0;
                dram_we_o <= 1'b0;
                alu_c_o <= 32'b0;
                rD2_o <= 32'b0;
                imm_o <= 32'b0;
                wR_o <= 5'b0;
            end
            `DATA_CTRL_STOP: begin
            end
            default: begin
                pc4_o <= 32'b0;
                rf_sel_o <= 2'b0;
                rf_we_o <= 1'b0;
                dram_we_o <= 1'b0;
                alu_c_o <= 32'b0;
                rD2_o <= 32'b0;
                imm_o <= 32'b0;
                wR_o <= 5'b0;
            end
        endcase
    end
end
endmodule