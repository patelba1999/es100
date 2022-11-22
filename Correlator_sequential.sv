`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2022 10:31:34 PM
// Design Name: 
// Module Name: mac_test
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


module mac_test(

    input logic clk,
    input logic rst,
    input int a_input,
    input int b_input,
    output int b_input_delayed,
    output int mac_output

    );
    
    // assign b_input_delayed = 0;
    
    // On each clock, shift/delay values, and multiply/accumulate
    always_ff @(posedge clk) begin
        b_input_delayed <= b_input;
        mac_output <= (a_input**2) * b_input**2 + mac_output;
    end
    
endmodule
