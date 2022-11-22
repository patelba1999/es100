`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2022 06:12:17 PM
// Design Name: 
// Module Name: lc_test
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


module lc_test(

    input logic clk,
    input logic rst,
    input int a_input,
    input int b_input,
    output int lc_output

    );
    
    // Intermediate signals
    int b_delayed;
    int b_delayed1;
    int mac1_out;
    
    mac_test mac1 (.clk(clk), .rst(rst), .a_input(a_input), .b_input(b_input),
                   .b_input_delayed(b_delayed), .mac_output(mac1_out));
    mac_test mac2 (.clk(clk), .rst(rst), .a_input(a_input), .b_input(b_delayed),
                   .b_input_delayed(b_delayed1), .mac_output(lc_output));
    
    
endmodule
