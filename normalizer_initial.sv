`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2022 12:08:42 AM
// Design Name: 
// Module Name: normalizer
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


module normalizer(
        
        input logic clk,
        input logic rst,
        input int data,
        input logic [15:0] norm_count,
        output int normalized_val

    );

    always_comb
        normalized_val = data/norm_count;
     
endmodule
