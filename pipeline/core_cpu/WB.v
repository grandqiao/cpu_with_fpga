`timescale 1ns / 1ps

module WB(
    input wire [1:0] rf_sel_i,
    input wire       rf_we_i,
    input wire [31:0] pc4_i,
    input wire [31:0] dram_rdata_i,
    input wire [31:0] alu_c_i,
    input wire [31:0] imm_i,
    
    output wire [31:0] we_data_o
);

assign we_data_o = (rf_sel_i == `WE_ALU) ? alu_c_i :
                   (rf_sel_i == `WE_DRAM) ? dram_rdata_i :
                   (rf_sel_i == `WE_PC4) ? pc4_i :
                   (rf_sel_i == `WE_SEXT) ? imm_i : 32'b0;

endmodule