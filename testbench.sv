`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2022 10:48:04 PM
// Design Name: 
// Module Name: mac_test_tb
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


module mac_test_tb;

// Parameter for number of time bin points
parameter N = 6;

// Parameter for number of lags
parameter M = 3;

// Define general tb signals
logic clk_tb;
logic rst_tb;
real a_tb;
real b_tb;

// Define tb signal for shift register time bin
real q_reg_tb [N];

// Define tb signals for correlator
real un_corr_tb_out [M][N];
real un_corr_sum_tb_out [M];

// Define tb signals for counter
logic [15:0] count_tb;

// These 2 signal can be used for custom ADC input
int i;
int test [5] = '{1, 2, 3, 4, 5};

// Instantiate CLK signal
initial begin
    i = -1;
    clk_tb = 1'b0;
    rst_tb = 1'b1;
    a_tb = 2;
    b_tb = 2; 
    #5
    rst_tb = 1'b0;
    forever begin
    // Implies 10 ns period
    #5
    clk_tb = ~clk_tb;
 end end

// Simulates the ADC input
initial begin
    forever begin
    // Implies 10 ns period, same as universal FPGA CLK
    #10
    i = i + 1;
    a_tb = a_tb + 2;
    b_tb = b_tb + 2;
end end

// Assign simulation time
initial 
    #3000 $finish;
    
// Instantiate counter

counter cnt_uut1 (

    .clk(clk_tb),
    .rst(rst_tb),
    .count(count_tb)
);
    
// Instantiate shift register
shift_register shift_reg_uut1 (
    
    .clk(clk_tb),
    .adc_in(a_tb),
    .count(count_tb),
    .q_reg(q_reg_tb)

);

// Instantiate correlator
correlator_comb corr_comb_uut1 (

    .clk(clk_tb),
    .q_reg(q_reg_tb),
    .un_corr(un_corr_tb_out),
    .un_corr_sum(un_corr_sum_tb_out)

);



// NOTE: THESE SIGNALS ARE FROM EARLIER STAGES OF TESTING, SHOWN HERE FOR 
// THE SAKE OF COMPLETENESS

// Define tb signals for first mac
int b_del1_tb;
int mac1_out_tb;

// Define tb signals for second mac
int mac2_out_tb;
int b_del2_tb;

// Define tb signals for third mac
int mac3_out_tb;
int b_del3_tb1;

// Define tb signals for first mac_2
int accum_1_out_tb;

// Define tb signals for mux
int mux_out_tb1;
int mux_out_tb2;
int mux_out_tb3;

// Define tb signals for lag counter for mac 2
logic [15:0] lag_count_tb_mac2;

// Define tb signals for lag counter for mac 3
logic [15:0] lag_count_tb_mac3;

// Define tb signals for normalizer for mac 1
int normalized_val_tb_mac1;

// Define tb signals for normalizer for mac 2
int normalized_val_tb_mac2;

// Define tb signals for normalizer for mac 3
int normalized_val_tb_mac3;


//Instantiate 3 UUT mac

mac_test mac_uut1 (
	   .clk(clk_tb),
	   .rst(rst_tb),
	   .a_input(a_tb),
	   .b_input(b_tb),
	   .mac_output(mac1_out_tb),
	   .b_input_delayed(b_del1_tb)
	);

mac_test mac_uut2 (
	   .clk(clk_tb),
	   .rst(rst_tb),
	   .a_input(a_tb),
	   .b_input(b_del1_tb),
	   .mac_output(mac2_out_tb),
	   .b_input_delayed(b_del2_tb)
	);
	
mac_test mac_uut3 (
	   .clk(clk_tb),
	   .rst(rst_tb),
	   .a_input(a_tb),
	   .b_input(b_del2_tb),
	   .mac_output(mac3_out_tb),
	   .b_input_delayed(b_del3_tb)
	);
	
// Instantiate accum

accum accum_uut1 (
        .clk(clk_tb),
        .rst(rst_tb),
        .a_input(a_tb),
        .accum_output(accum_1_out_tb)
);
	

// Instantiate mux

mux_mac mux_uut1 (
    .mac_out(mac1_out_tb),
    .zero_value(32'b0),
    .sel(count_tb),
    .mux_out(mux_out_tb1)
);

mux_mac mux_uut2 (
    .mac_out(mac2_out_tb),
    .zero_value(32'b0),
    .sel(count_tb),
    .mux_out(mux_out_tb2)
);

mux_mac mux_uut3 (
    .mac_out(mac3_out_tb),
    .zero_value(32'b0),
    .sel(count_tb),
    .mux_out(mux_out_tb3)
);


// Instantiate lag counters for mac 2 and 3

lag_counter lag_counter_2 (
    .clk(clk_tb),
    .rst(rst_tb),
    .b_data(b_del1_tb),
    .lag_count(lag_count_tb_mac2)
);

lag_counter lag_counter_3 (
    .clk(clk_tb),
    .rst(rst_tb),
    .b_data(b_del2_tb),
    .lag_count(lag_count_tb_mac3)
);

// Instantiate normalizer for macs 1,2, and 3

normalizer normalizer_1 (
    .clk(clk_tb),
    .rst(rst_tb),
    .data(mux_out_tb1),
    .norm_count(count_tb),
    .normalized_val(normalized_val_tb_mac1)
);

normalizer normalizer_2 (
    .clk(clk_tb),
    .rst(rst_tb),
    .data(mux_out_tb2),
    .norm_count(lag_count_tb_mac2),
    .normalized_val(normalized_val_tb_mac2)
);

normalizer normalizer_3 (
    .clk(clk_tb),
    .rst(rst_tb),
    .data(mux_out_tb3),
    .norm_count(lag_count_tb_mac3),
    .normalized_val(normalized_val_tb_mac3)
);


endmodule
