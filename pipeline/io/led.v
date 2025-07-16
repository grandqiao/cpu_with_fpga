`timescale 1ns / 1ps

`include "defines.vh"

module LED(
    input wire  clk_i,
    input wire  rst_i,
    input wire [31:0] data_i,
    input wire [31:0] addr_i, //address to LED
    input wire we_i,    //access to LED
    output reg [31:0] led_o
);

always @ (posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        led_o <= 0;
    end else begin
        if (we_i && addr_i == `PERI_ADDR_LED) begin
            led_o <= data_i;
        end
    end
end

endmodule
