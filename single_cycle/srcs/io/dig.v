`timescale 1ns / 1ps

`include "defines.vh"

module DIG(
    input wire  clk_i,
    input wire  rst_i,
    input wire [31:0] data_i,
    input wire we_i,    //access to DIG
    output wire [3:0] D0_o,
    output wire [3:0] D1_o,
    output wire [7:0] dig1_o,
    output wire [7:0] dig2_o
);

reg [31:0]  cnt_clk;
reg [1:0]   cnt_show;
reg [31:0]  dig_data;
reg [3:0] show_data1;
reg [3:0] show_data2;

assign D

always @ (posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        cnt_clk <= 0;
        cnt_show <= 0;
        dig_data <= 0;
    end else begin
        if (cnt_clk == `DIG_MAX) begin
            cnt_clk <= 0;
            cnt_show <= cnt_show + 1;
        end else begin
            cnt_clk <= cnt_clk + 1;
        end
        if (we_i) begin
            dig_data <= data_i;
        end
    end
end

always @(*) begin
    case (cnt_show)
        2'b00: begin
            D0_o = 4'b0001;
            D1_o = 4'b0001;
            show_data1 = dig_data[3:0];
            show_data2 = dig_data[19:16];
        end
        2'b01: begin
            D0_o = 4'b0010;
            D1_o = 4'b0010;
            show_data1 = dig_data[7:4];
            show_data2 = dig_data[23:20];
        end
        2'b10: begin
            D0_o = 4'b0100;
            D1_o = 4'b0100;
            show_data1 = dig_data[11:8];
            show_data2 = dig_data[27:24];
        end
        2'b11: begin
            D0_o = 4'b1000;
            D1_o = 4'b1000;
            show_data1 = dig_data[15:12];
            show_data2 = dig_data[31:28];
        end
        default: begin
            D0_o = 4'b0000;
            D1_o = 4'b0000;
            show_data1 = 4'b0000;
            show_data2 = 4'b0000;
        end
    endcase

    case(show_data1)
        4'h0: dig1_o = 8'b1111110;
        4'h1: dig1_o = 8'b0110000;
        4'h2: dig1_o = 8'b1101101;
        4'h3: dig1_o = 8'b1111001;
        4'h4: dig1_o = 8'b0110011;
        4'h5: dig1_o = 8'b1011011;
        4'h6: dig1_o = 8'b1011111;
        4'h7: dig1_o = 8'b1110000;
        4'h8: dig1_o = 8'b1111111;
        4'h9: dig1_o = 8'b1111011;
        4'hA: dig1_o = 8'b1110111;
        4'hB: dig1_o = 8'b0011111;
        4'hC: dig1_o = 8'b1001110;
        4'hD: dig1_o = 8'b0111101;
        4'hE: dig1_o = 8'b1001111;
        default: dig1_o = 8'b1000111; // F
    endcase

    case(show_data2)
        4'h0: dig2_o = 8'b1111110;
        4'h1: dig2_o = 8'b0110000;
        4'h2: dig2_o = 8'b1101101;
        4'h3: dig2_o = 8'b1111001;
        4'h4: dig2_o = 8'b0110011;
        4'h5: dig2_o = 8'b1011011;
        4'h6: dig2_o = 8'b1011111;
        4'h7: dig2_o = 8'b1110000;
        4'h8: dig2_o = 8'b1111111;
        4'h9: dig2_o = 8'b1111011;
        4'hA: dig2_o = 8'b1110111;
        4'hB: dig2_o = 8'b0011111;
        4'hC: dig2_o = 8'b1001110;
        4'hD: dig2_o = 8'b0111101;
        4'hE: dig2_o = 8'b1001111;
        default: dig2_o = 8'b1000111; // F
    endcase
end

endmodule
