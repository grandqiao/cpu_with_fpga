`timescale 1ns / 1ps

`include "defines.vh"

module DIG(
    input wire  clk_i,
    input wire  rst_i,
    input wire [31:0] data_i,
    input wire [31:0] addr_i, //address to DIG
    input wire we_i,    //access to DIG
    output reg [7:0] D0_o,
    output reg [7:0] dig1_o
);

reg [31:0]  cnt_clk;
reg [2:0]   cnt_show;
reg [31:0]  dig_data;
reg [3:0] show_data;

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
        if (we_i && addr_i == `PERI_ADDR_DIG) begin
            dig_data <= data_i;
        end
    end
end

always @(*) begin
    case (cnt_show)
        3'b000: begin
            D0_o = 8'b00000001;
            show_data = dig_data[3:0];
        end
        3'b001: begin
            D0_o = 8'b00000010;
            show_data = dig_data[7:4];
        end
        3'b010: begin
            D0_o = 8'b00000100;
            show_data = dig_data[11:8];
        end
        3'b011: begin
            D0_o = 8'b00001000;
            show_data = dig_data[15:12];
        end
        3'b100: begin
            D0_o = 8'b00010000;
            show_data = dig_data[19:16];
        end
        3'b101: begin
            D0_o = 8'b00100000;
            show_data = dig_data[23:20];
        end
        3'b110: begin
            D0_o = 8'b01000000;
            show_data = dig_data[27:24];
        end
        3'b111: begin
            D0_o = 8'b10000000;
            show_data = dig_data[31:28];
        end
        default: begin
            D0_o = 8'b00000000;
            show_data = 4'h0;
        end
    endcase

// 0x0.U -> "b11111100".U,
// 0x1.U -> "b01100000".U,
// 0x2.U -> "b11011010".U,
// 0x3.U -> "b11110010".U,
// 0x4.U -> "b01100110".U,
// 0x5.U -> "b10110110".U,
// 0x6.U -> "b10111110".U,
// 0x7.U -> "b11100000".U,
// 0x8.U -> "b11111110".U,
// 0x9.U -> "b11110110".U,
// 0xA.U -> "b11101110".U,
// 0xB.U -> "b00111110".U,
// 0xC.U -> "b10011100".U,
// 0xD.U -> "b01111010".U,
// 0xE.U -> "b10011110".U,
// 0xF.U -> "b10001110".U

    case(show_data)
        4'h0: dig1_o = 8'b11111100;
        4'h1: dig1_o = 8'b01100000;
        4'h2: dig1_o = 8'b11011010;
        4'h3: dig1_o = 8'b11110010;
        4'h4: dig1_o = 8'b01100110;
        4'h5: dig1_o = 8'b10110110;
        4'h6: dig1_o = 8'b10111110;
        4'h7: dig1_o = 8'b11100000;
        4'h8: dig1_o = 8'b11111110;
        4'h9: dig1_o = 8'b11110110;
        4'hA: dig1_o = 8'b11101110;
        4'hB: dig1_o = 8'b00111110;
        4'hC: dig1_o = 8'b10011100;
        4'hD: dig1_o = 8'b01111010;
        4'hE: dig1_o = 8'b10011110;
    endcase

end

endmodule
