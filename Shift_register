`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 02:30:35 PM
// Design Name: 
// Module Name: shift_register
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


module shift_register

    // N specifies how many samples to collect/size of time bin
    #(parameter N=6)
    (
    
        // Input is to the first FF is the ADC samples
        input logic clk,
        input real adc_in,
        
        // This external counter determines when to stop updating values
        input logic [15:0] count,
        
        // Output stored in a register
        output real q_reg [N-1:0]
    
    );
    
    flip_flop ff_1 (.clk(clk), .count(count), .d(adc_in), .q(q_reg[N - 1]));
    
    // Arbitrary number of FFs generated based on the N parameter
    generate 
        genvar i;
        for (i = 1; i < N; i = i + 1)
            flip_flop ff (.clk(clk), .count(count), .d(q_reg[N - i]), .q(q_reg[N - i - 1]));
    endgenerate 
    
    
endmodule
