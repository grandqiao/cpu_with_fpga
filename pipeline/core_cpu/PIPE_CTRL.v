`timescale 1ns / 1ps

module PIPE_CTRL(
    input  wire [4:0]   WB_wR_i,
    input  wire [4:0]   EX_wR_i,
    input  wire [4:0]   MEM_wR_i,
    input  wire [31:0]  ID_irom_i,
    input  wire         back_i,
    input  wire         WB_rf_we_i,
    input  wire         EX_rf_we_i,
    input  wire         MEM_rf_we_i,


    output reg  [1:0]  IF_ID_data_ctrl_o,
    output reg  [1:0]  ID_EX_data_ctrl_o,
    output reg  [1:0]  EX_MEM_data_ctrl_o,
    output reg  [1:0]  MEM_WB_data_ctrl_o,
    output reg         keep_o
);


wire [4:0] rR1 , rR2;

assign rR1 = ID_irom_i[19:15];
assign rR2 = ID_irom_i[24:20];

always @(*) begin
    if (back_i) begin
        keep_o = 1'b0;
        IF_ID_data_ctrl_o = `DATA_CTRL_FLUSH;
        ID_EX_data_ctrl_o = `DATA_CTRL_FLUSH;
        EX_MEM_data_ctrl_o = `DATA_CTRL_NORMAL;
        MEM_WB_data_ctrl_o = `DATA_CTRL_NORMAL;
    end else if ((rR1 == WB_wR_i || rR2 == WB_wR_i) && WB_wR_i != 5'b0 && WB_rf_we_i) begin
        keep_o = 1'b1;
        IF_ID_data_ctrl_o = `DATA_CTRL_STOP;
        ID_EX_data_ctrl_o = `DATA_CTRL_STOP;
        EX_MEM_data_ctrl_o = `DATA_CTRL_STOP;
        MEM_WB_data_ctrl_o = `DATA_CTRL_FLUSH;
    end else if ((rR1 == MEM_wR_i || rR2 == MEM_wR_i) && MEM_wR_i != 5'b0 && MEM_rf_we_i) begin
        keep_o = 1'b1;
        IF_ID_data_ctrl_o = `DATA_CTRL_STOP;
        ID_EX_data_ctrl_o = `DATA_CTRL_STOP;
        EX_MEM_data_ctrl_o = `DATA_CTRL_FLUSH;
        MEM_WB_data_ctrl_o = `DATA_CTRL_NORMAL;
    end else if ((rR1 == EX_wR_i || rR2 == EX_wR_i) && EX_wR_i != 5'b0 && EX_rf_we_i) begin
        keep_o = 1'b1;
        IF_ID_data_ctrl_o = `DATA_CTRL_STOP;
        ID_EX_data_ctrl_o = `DATA_CTRL_FLUSH;
        EX_MEM_data_ctrl_o = `DATA_CTRL_NORMAL;
        MEM_WB_data_ctrl_o = `DATA_CTRL_NORMAL;
    end else begin
        keep_o = 1'b0;
        IF_ID_data_ctrl_o = `DATA_CTRL_NORMAL;
        ID_EX_data_ctrl_o = `DATA_CTRL_NORMAL;
        EX_MEM_data_ctrl_o = `DATA_CTRL_NORMAL;
        MEM_WB_data_ctrl_o = `DATA_CTRL_NORMAL;
    end
end

endmodule