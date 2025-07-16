`timescale 1ns / 1ps

module IF_ID(
    input  wire         clk_i  ,
    input  wire         rst_i ,
    input  wire [1:0]   data_ctrl_i,
    input  wire [31:0]  pc4_i,
    input  wire [31:0]  inst_i,
    output reg  [31:0]  inst_o,
    output reg  [31:0]  pc4_o
);

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        inst_o <= 32'b0;
        pc4_o <= 32'b0;
    end else begin
        case(data_ctrl_i)
            `DATA_CTRL_NORMAL: begin
                inst_o <= inst_i;
                pc4_o <= pc4_i;
            end
            `DATA_CTRL_FLUSH: begin
                inst_o <= 32'b0;
                pc4_o <= 32'b0;
            end
            `DATA_CTRL_STOP: begin
            end
            default: begin
                inst_o <= 32'b0;
                pc4_o <= 32'b0;
            end
        endcase
    end
end
endmodule