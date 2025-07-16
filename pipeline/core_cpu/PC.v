`timescale 1ns / 1ps

module PC (
    input  wire         clk_i  ,
    input  wire         rst_i ,
    input  wire [31:0]  npc_i,
    input  wire         back_i,
    input  wire         keep_i,
    output reg  [31:0]   pc_o,
    output wire [31:0]   pc4_o
);

wire [31:0]   din;
assign  din = back_i ? npc_i : pc_o + 4;
assign  pc4_o = pc_o + 4;

    always @ (posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            pc_o <= -4;
        end else if (keep_i == 0) begin
            pc_o <= din;
        end
    end

endmodule