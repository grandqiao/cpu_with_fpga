`timescale 1ns / 1ps

`include "defines.vh"

module Counter(
    input wire  clk_i,
    input wire  rst_i,
    input wire  we_i,
    input wire [31:0] data_i,
    input wire [31:0] addr_i,
    output reg [31:0] data_o
);

reg [31:0] cnt1;
reg [31:0] cnt_max;

always @ (posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        data_o <= 0;
        cnt1 <= 0;
    end else begin
        if (we_i && {addr_i[31:4] , 4'b000} == `PERI_ADDR_CNT) begin
            cnt_max <= data_i;
            cnt1 <= 0; // Reset cnt1 when we write a new max value
        end else begin
            if (cnt1 < cnt_max) begin
                cnt1 <= cnt1 + 1;
            end else begin
                data_o <= data_o + 1;
                cnt1 <= 0;
            end
        end
    end

end
    

endmodule
