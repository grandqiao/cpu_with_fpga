`timescale 1ns / 1ps

module RF(
    input  wire  [4:0]  rR1_i,
    input  wire  [4:0]  rR2_i, 
    input  wire  [4:0]  wR_i,
    input  wire  WE_i,
    input  wire [31:0]  Wd_i,
    input  wire  clk_i,
    output reg [31:0]  rD1_o,
    output reg [31:0]  rD2_o
);

reg [31:0] rf [31:0]; //寄存器文�?

always @(*) begin
    case (rR1_i)
        5'b00000: rD1_o = 32'b0;
        5'b00001: rD1_o = rf[1];
        5'b00010: rD1_o = rf[2];
        5'b00011: rD1_o = rf[3];
        5'b00100: rD1_o = rf[4];
        5'b00101: rD1_o = rf[5];
        5'b00110: rD1_o = rf[6];
        5'b00111: rD1_o = rf[7];
        5'b01000: rD1_o = rf[8];
        5'b01001: rD1_o = rf[9];
        5'b01010: rD1_o = rf[10];
        5'b01011: rD1_o = rf[11];
        5'b01100: rD1_o = rf[12];
        5'b01101: rD1_o = rf[13];
        5'b01110: rD1_o = rf[14];
        5'b01111: rD1_o = rf[15];
        5'b10000: rD1_o = rf[16];
        5'b10001: rD1_o = rf[17];
        5'b10010: rD1_o = rf[18];
        5'b10011: rD1_o = rf[19];
        5'b10100: rD1_o = rf[20];
        5'b10101: rD1_o = rf[21];
        5'b10110: rD1_o = rf[22];
        5'b10111: rD1_o = rf[23];
        5'b11000: rD1_o = rf[24];
        5'b11001: rD1_o = rf[25];
        5'b11010: rD1_o = rf[26];
        5'b11011: rD1_o = rf[27];
        5'b11100: rD1_o = rf[28];
        5'b11101: rD1_o = rf[29];
        5'b11110: rD1_o = rf[30];
        5'b11111: rD1_o = rf[31];
        default: rD1_o = 32'b0; //默认值为0
    endcase
    case (rR2_i)
        5'b00000: rD2_o = 32'b0;
        5'b00001: rD2_o = rf[1];
        5'b00010: rD2_o = rf[2];
        5'b00011: rD2_o = rf[3];
        5'b00100: rD2_o = rf[4];
        5'b00101: rD2_o = rf[5];
        5'b00110: rD2_o = rf[6];
        5'b00111: rD2_o = rf[7];
        5'b01000: rD2_o = rf[8];
        5'b01001: rD2_o = rf[9];
        5'b01010: rD2_o = rf[10];
        5'b01011: rD2_o = rf[11];
        5'b01100: rD2_o = rf[12];
        5'b01101: rD2_o = rf[13];
        5'b01110: rD2_o = rf[14];
        5'b01111: rD2_o = rf[15];
        5'b10000: rD2_o = rf[16];
        5'b10001: rD2_o = rf[17];
        5'b10010: rD2_o = rf[18];
        5'b10011: rD2_o = rf[19];
        5'b10100: rD2_o = rf[20];
        5'b10101: rD2_o = rf[21];
        5'b10110: rD2_o = rf[22];
        5'b10111: rD2_o = rf[23];
        5'b11000: rD2_o = rf[24];
        5'b11001: rD2_o = rf[25];
        5'b11010: rD2_o = rf[26];
        5'b11011: rD2_o = rf[27];
        5'b11100: rD2_o = rf[28];
        5'b11101: rD2_o = rf[29];
        5'b11110: rD2_o = rf[30];
        5'b11111: rD2_o = rf[31];
        default: rD2_o = 32'b0; //默认值为0
    endcase
end

always @(posedge clk_i) begin
    if (WE_i && wR_i != 0) begin //写寄存器
        case (wR_i)
            5'b00000: ; //寄存器0不允许写入
            5'b00001: rf[1] <= Wd_i;
            5'b00010: rf[2] <= Wd_i;
            5'b00011: rf[3] <= Wd_i;
            5'b00100: rf[4] <= Wd_i;
            5'b00101: rf[5] <= Wd_i;
            5'b00110: rf[6] <= Wd_i;
            5'b00111: rf[7] <= Wd_i;
            5'b01000: rf[8] <= Wd_i;
            5'b01001: rf[9] <= Wd_i;
            5'b01010: rf[10] <= Wd_i;
            5'b01011: rf[11] <= Wd_i;
            5'b01100: rf[12] <= Wd_i;
            5'b01101: rf[13] <= Wd_i;
            5'b01110: rf[14] <= Wd_i;
            5'b01111: rf[15] <= Wd_i;
            5'b10000: rf[16] <= Wd_i;
            5'b10001: rf[17] <= Wd_i;
            5'b10010: rf[18] <= Wd_i;
            5'b10011: rf[19] <= Wd_i;
            5'b10100: rf[20] <= Wd_i;
            5'b10101: rf[21] <= Wd_i;
            5'b10110: rf[22] <= Wd_i;
            5'b10111: rf[23] <= Wd_i;
            5'b11000: rf[24] <= Wd_i;
            5'b11001: rf[25] <= Wd_i;
            5'b11010: rf[26] <= Wd_i;
            5'b11011: rf[27] <= Wd_i;
            5'b11100: rf[28] <= Wd_i;
            5'b11101: rf[29] <= Wd_i;
            5'b11110: rf[30] <= Wd_i;
            5'b11111: rf[31] <= Wd_i;
            default:;
        endcase
    end
end

endmodule