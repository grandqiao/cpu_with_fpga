`timescale 1ns / 1ps

`include "defines.vh"

module myCPU (
    input  wire         cpu_rst,
    input  wire         cpu_clk,

    // Interface to IROM
`ifdef RUN_TRACE
    output wire [15:0]  inst_addr,
`else
    output wire [13:0]  inst_addr,
`endif
    input  wire [31:0]  inst,
    
    // Interface to Bridge
    output wire [31:0]  Bus_addr,
    input  wire [31:0]  Bus_rdata,
    output wire         Bus_we,
    output wire [31:0]  Bus_wdata

`ifdef RUN_TRACE
    ,// Debug Interface
    output wire         debug_wb_have_inst,
    output wire [31:0]  debug_wb_pc,
    output              debug_wb_ena,
    output wire [ 4:0]  debug_wb_reg,
    output wire [31:0]  debug_wb_value
`endif
);

    // TODO: 完成你自己的单周期CPU设计
    //


wire [31:0] IF_pc;
wire [31:0] IF_inst;
wire back;
wire [31:0] npc;
wire [31:0] IF_pc4;
wire keep;

wire [31:0] ID_pc4;
wire [31:0] ID_inst;
wire [1:0] ID_rf_sel;
wire ID_rf_we;
wire ID_dram_we;
wire [3:0] ID_alu_op;
wire [4:0] ID_wR;
wire [31:0] ID_rA;
wire [31:0] ID_rB;
wire [31:0] ID_rD2;
wire [31:0] ID_imm;
wire [2:0] ID_npc_op;



wire [31:0] EX_pc4;
wire [1:0] EX_rf_sel;
wire EX_rf_we;
wire EX_dram_we;
wire [3:0] EX_alu_op;
wire [4:0] EX_wR;
wire [31:0] EX_rA;
wire [31:0] EX_rB;
wire [31:0] EX_rD2;
wire [31:0] EX_imm;
wire [2:0] EX_npc_op;
wire [31:0] Ex_alu_c;


wire [31:0] MEM_pc4;
wire [1:0] MEM_rf_sel;
wire MEM_rf_we;
wire MEM_dram_we;
wire [31:0] MEM_alu_c;
wire [31:0] MEM_rD2;
wire [31:0] MEM_imm;
wire [4:0] MEM_wR;
wire [31:0] MEM_rdata;

wire [31:0]  WB_pc4;
wire [1:0] WB_rf_sel;
wire WB_rf_we;
wire [31:0] WB_dram_rdata;
wire [31:0] WB_alu_c;
wire [31:0] WB_imm;
wire [4:0] WB_wR;
wire [31:0] WB_data;



wire [1:0]    IF_ID_data_ctrl;
wire [1:0]    ID_EX_data_ctrl;
wire [1:0]    EX_MEM_data_ctrl;
wire [1:0]    MEM_WB_data_ctrl;


// `ifdef RUN_TRACE
//     assign inst_addr = current_pc[15:0];
// `else
//     assign inst_addr = current_pc[15:2]; //指令地址
// `endif
// assign inst_addr = IF_pc[15:2];

//need to be updated

assign IF_inst = inst;
assign inst_addr = IF_pc[15:2]; // 指令地址
assign Bus_addr = MEM_alu_c;
assign Bus_wdata = MEM_rD2;
assign Bus_we = MEM_dram_we;
assign MEM_rdata = Bus_rdata;


IFETCH U_ifetch(
    .clk_i(cpu_clk),
    .rst_i(cpu_rst),
    .npc_i(npc),
    .back_i(back),
    .keep_i(keep),
    .pc4_if_o(IF_pc4),
    .pc_if_o(IF_pc)
);


IF_ID U_if_id(
    .clk_i(cpu_clk),
    .rst_i(cpu_rst),
    .data_ctrl_i(IF_ID_data_ctrl),
    .pc4_i(IF_pc4),
    .inst_i(IF_inst),
    .inst_o(ID_inst),
    .pc4_o(ID_pc4)
);


IDECODE U_idecode(
    .WE_i(WB_rf_we),
    .clk_i(cpu_clk),
    .inst_i(ID_inst),
    .Wd_i(WB_data),
    .wR_i(WB_wR),
    .rA_o(ID_rA),
    .rB_o(ID_rB),
    .imm_o(ID_imm),
    .rf_sel_o(ID_rf_sel),
    .rf_we_o(ID_rf_we),
    .dram_we_o(ID_dram_we),
    .alu_op_i(ID_alu_op),
    .wR_o(ID_wR),
    .rD2_o(ID_rD2),
    .npc_op_o(ID_npc_op)
);

ID_EX U_id_ex(
    .clk_i(cpu_clk),
    .rst_i(cpu_rst),
    .data_ctrl_i(ID_EX_data_ctrl),
    .pc4_i(ID_pc4),
    .rf_sel_i(ID_rf_sel),
    .rf_we_i(ID_rf_we),
    .dram_we_i(ID_dram_we),
    .alu_op_i(ID_alu_op),
    .rA_i(ID_rA),
    .rB_i(ID_rB),
    .rD2_i(ID_rD2),
    .imm_i(ID_imm),
    .wR_i(ID_wR),
    .npc_op_i(ID_npc_op),

    .pc4_o(EX_pc4),
    .rf_sel_o(EX_rf_sel),
    .rf_we_o(EX_rf_we),
    .dram_we_o(EX_dram_we),
    .alu_op_o(EX_alu_op),
    .rA_o(EX_rA),
    .rB_o(EX_rB),
    .rD2_o(EX_rD2),
    .imm_o(EX_imm),
    .wR_o(EX_wR),
    .npc_op_o(EX_npc_op)
);


EX U_ex(
    .rA_i(EX_rA),
    .rB_i(EX_rB),
    .npc_op_i(EX_npc_op),
    .alu_op_i(EX_alu_op),
    .pc4_i(EX_pc4),
    .imm_i(EX_imm),

    .npc_o(npc),
    .back_o(back),
    .alu_c_o(Ex_alu_c)
);

EX_MEM U_ex_mem(
    .clk_i(cpu_clk),
    .rst_i(cpu_rst),
    .data_ctrl_i(EX_MEM_data_ctrl),
    
    .pc4_i(EX_pc4),
    .rf_sel_i(EX_rf_sel),
    .rf_we_i(EX_rf_we),
    .dram_we_i(EX_dram_we),
    .alu_c_i(Ex_alu_c),
    .rD2_i(EX_rD2),
    .imm_i(EX_imm),
    .wR_i(EX_wR),

    .pc4_o(MEM_pc4),
    .rf_sel_o(MEM_rf_sel),
    .rf_we_o(MEM_rf_we),
    .dram_we_o(MEM_dram_we),
    .alu_c_o(MEM_alu_c),
    .rD2_o(MEM_rD2),
    .imm_o(MEM_imm),
    .wR_o(MEM_wR)
);


MEM_WB U_mem_wb(
    .clk_i(cpu_clk),
    .rst_i(cpu_rst),
    .data_ctrl_i(MEM_WB_data_ctrl),

    .pc4_i(MEM_pc4),
    .rf_sel_i(MEM_rf_sel),
    .rf_we_i(MEM_rf_we),
    .dram_rdata_i(MEM_rdata),
    .alu_c_i(MEM_alu_c),
    .imm_i(MEM_imm),
    .wR_i(MEM_wR),

    .pc4_o(WB_pc4),
    .rf_sel_o(WB_rf_sel),
    .rf_we_o(WB_rf_we),
    .dram_rdata_o(WB_dram_rdata),
    .alu_c_o(WB_alu_c),
    .imm_o(WB_imm),
    .wR_o(WB_wR)
);


WB U_wb(
    .rf_sel_i(WB_rf_sel),
    .pc4_i(WB_pc4),
    .dram_rdata_i(WB_dram_rdata),
    .alu_c_i(WB_alu_c),
    .imm_i(WB_imm),
    .rf_we_i(WB_rf_we),

    .we_data_o(WB_data)
);

PIPE_CTRL U_pipe_ctrl(
    .WB_wR_i(WB_wR),
    .WB_rf_we_i(WB_rf_we),
    .EX_wR_i(EX_wR),
    .EX_rf_we_i(EX_rf_we),
    .MEM_wR_i(MEM_wR),
    .MEM_rf_we_i(MEM_rf_we),
    .back_i(back),
    .ID_irom_i(ID_inst),

    .IF_ID_data_ctrl_o(IF_ID_data_ctrl),
    .ID_EX_data_ctrl_o(ID_EX_data_ctrl),
    .EX_MEM_data_ctrl_o(EX_MEM_data_ctrl),
    .MEM_WB_data_ctrl_o(MEM_WB_data_ctrl),
    .keep_o(keep)
);


`ifdef RUN_TRACE
    // Debug Interface
    assign debug_wb_have_inst = (WB_pc4 == 32'b0) ? ((WB_wR == 5'b0) ? 1'b0 : 1'b1) : 1'b1;
    assign debug_wb_pc        = WB_pc4-4;
    assign debug_wb_ena       = WB_rf_we;
    assign debug_wb_reg       = WB_wR;
    assign debug_wb_value     = WB_data;
`endif

endmodule
