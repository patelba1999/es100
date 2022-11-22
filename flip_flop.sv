`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 02:27:56 PM
// Design Name: 
// Module Name: flip_flop
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


module flip_flop 

// N specifies how many samples to collect
// D specifies the delay before starting to collect samples

#(parameter N = 6, D = 3)
(
    input clk,
    input logic [15:0] count,
    input real d, 
    output real q
);

    // On the rising edge of clk, shift the values over to next flip-flop
    always_ff @(posedge clk) 
    
        // These constraints implement the delay in collection and also when
        // to stop collecting data
        
        if (count >= (D - 1) && count < (D + N - 1))
            q <= d;
    
endmodule
