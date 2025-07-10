`timescale 1ns / 1ps

module my_IROM (
    input  wire [31:0]   pc_i,     
    output reg  [31:0]   inst_o       
);

wire [13:0] inst_addr = pc_i[15:2];

IROM u_IROM (
    .a      (inst_addr),
    .spo    (inst_o)
);
endmodule