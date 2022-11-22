`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 08:15:30 PM
// Design Name: 
// Module Name: correlator_comb
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


module correlator_comb

    // N specifies how many samples to collect/size of time bin
    // M specifies how many lag values to compute in parallel
    #(parameter N=6, M=3, D = 3)
    (
        input clk,
        
        // This is the input from the time bin
        input real q_reg [N-1:0],
        
        // This is a packed array that holds the value for each summation term
        // for each lag value
        output real un_corr [M][N],
        
        // This array holds the normalized correalation value
        output real un_corr_sum [M]

    );
 
    // Temporary array that can hold each summation term for each lag value
    real temp_sum [M][N + 1];

    // For every lag value (M) a combinational circuit implementing the summation 
    // equation is generated
    generate 
        genvar i, j;
        for (j = 0; j < M; j = j + 1) begin
            for (i = 0; i < N; i = i + 1) begin
            
                // J indexes into the lag value and i indexes into the specific
                // summation term
                assign un_corr[j][i] = q_reg[i]**2 * q_reg[i + j]**2;
            end  
        end  
    endgenerate 


    // For each lag value, the temp_sum array holds the total unnormalized 
    // correlation value
    always_comb begin
        for (int k = 0; k < M; k = k + 1) begin
            for (int l = 0; l < (N + 1); l = l + 1) begin
                temp_sum[k][l + 1] = temp_sum[k][l] + un_corr[k][l];
            end
        end
    end
    
    // Each unnormlized correlation value is normalized between 0-1. This is done
    // by dividing by the summation value for lag = 0
    generate 
        genvar p;
        for (p = 0; p < M; p = p + 1) begin
            assign un_corr_sum[p] = temp_sum[p][N] / temp_sum[0][N];
        end  
    endgenerate 
    
endmodule
