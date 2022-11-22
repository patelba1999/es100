`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 11:24:48 PM
// Design Name: 
// Module Name: accum
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


module accum(

    input logic clk,
    input logic rst,
    input int a_input,
    output int accum_output

    );
    
    
    // On each clock, shift/delay values, and multiply/accumulate
    always_ff @(posedge clk) begin
        accum_output <= (a_input * a_input * a_input * a_input) + accum_output;
    end
    
endmodule
