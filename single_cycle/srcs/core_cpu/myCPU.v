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


wire [31:0] current_pc; //当前PC指令地址
wire [1:0] npc_op; //NPC操作选择
wire mux_sel; //MUX选择信号
wire br; //分支跳转信号
wire [31:0] alu_c;
reg [31:0] imm;
wire [31:0] pc4; //PC+4指令地址
wire zero;
wire neg;
wire rf_we; //寄存器写使能
wire [1:0] rf_wd_sel;
wire [3:0] ext_op;
wire [3:0] alu_op;
wire [1:0] alu_b_sel;
wire [1:0] ram_op;
wire [31:0] rD1;
wire [31:0] rD2;
wire [31:0] debug_wd;



// `ifdef RUN_TRACE
//     assign inst_addr = current_pc[15:0];
// `else
//     assign inst_addr = current_pc[15:2]; //指令地址
// `endif
assign inst_addr = current_pc[15:2]; //指令地址
assign Bus_addr = alu_c;
assign Bus_wdata = rD2;
assign Bus_we = ram_op[0];


IFETCH U_ifetch(
    .clk_i(cpu_clk),
    .rstn_i(cpu_rst),
    .npc_op_i(npc_op),
    .mux_sel_i(mux_sel),
    .br_i(br),
    .ext_i(imm),
    .alu_pc_i(alu_c),
    .pc4_o(pc4),
    .current_pc_o(current_pc)
);

CONTROLLER U_controller(
    .irom_i(inst),
    .zero_i(zero),
    .neg_i(neg),
    .npc_op_o(npc_op),
    .rf_we_o(rf_we),
    .rf_wd_sel_o(rf_wd_sel),
    .ext_op_o(ext_op),
    .alu_op_o(alu_op),
    .alu_b_sel_o(alu_b_sel),
    .ram_op_o(ram_op),
    .mux_sel_o(mux_sel),
    .br_o(br)
);

IDECODE U_idecode(
    .WE_i(rf_we),
    .clk_i(cpu_clk),
    .we_op_i(rf_wd_sel),
    .alu_c_i(alu_c),
    .dram_rdo_i(Bus_rdata),
    .npc_pc4_i(pc4),
    .sext_op_i(ext_op),
    .inst_i(inst),
    .rD1_o(rD1),
    .rD2_o(rD2),
    .imm_o(imm),
    .debug_wd_o(debug_wd)
);


ALU U_alu(
    .alu_a_i(rD1),
    .imm_i(imm),
    .rD2_i(rD2),
    .alu_op_i(alu_op),
    .alu_sel_i(alu_b_sel),
    .alu_c_o(alu_c),
    .zero_o(zero),
    .neg_o(neg)
);



`ifdef RUN_TRACE
    // Debug Interface
    assign debug_wb_have_inst = 1;
    assign debug_wb_pc        = current_pc[15:0];
    assign debug_wb_ena       = rf_we;
    assign debug_wb_reg       = inst[11:7];
    assign debug_wb_value     = debug_wd;
`endif

endmodule
