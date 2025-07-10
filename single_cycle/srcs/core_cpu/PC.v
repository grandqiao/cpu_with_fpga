`timescale 1ns / 1ps

module PC (
    input  wire         clk_i  ,
    input  wire         rstn_i ,
    input  wire [31:0]   din_i  ,        
    output reg  [31:0]   pc_o         
);

    always @ (posedge clk_i or posedge rstn_i) begin
        if (rstn_i) begin
            pc_o <= -4;
        end else begin
            pc_o <= din_i;
        end
    end

endmodule