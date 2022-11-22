`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 10:30:58 AM
// Design Name: 
// Module Name: mux_mac
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_mac  (
    input int mac_out, 
    input int zero_value,
    input logic [15:0] sel,
    output int mux_out
);

    always_comb begin 
        if (sel == 16'b100)
            mux_out = mac_out;
        else
            mux_out = zero_value;
    end
    
endmodule
