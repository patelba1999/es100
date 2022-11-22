`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 09:42:22 AM
// Design Name: 
// Module Name: counter
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


module counter (
    input logic clk,
    input logic rst,
    output logic [15:0] count
 );
 
    // RST resets the value to 0 and then increments by 1 on each CLK cycle
     always_ff @(posedge clk, posedge rst) begin
        if (rst)
            count <= 32'd0;
        else
            count <= count + 1;
     end
 
endmodule
