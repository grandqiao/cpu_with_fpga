`timescale 1ns / 1ps

`include "defines.vh"

module BUTTON (
    input wire clk_i,
    input wire rst_i,
    input wire button_i,
    output reg button_o 
);

reg [31:0] counter;
reg button_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
            button_reg <= 1'b0;
            button_o <= 1'b0;
        end
        else begin
            if (button_reg != button_i) begin 
                button_reg <= button_i;
                counter <= 0;
            end
            else if (counter < `DEBOUNCE_TIME) begin
                counter <= counter + 1;
            end
            else begin
                button_o <= button_reg;
            end
        end
    end

endmodule