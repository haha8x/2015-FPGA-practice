`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:43:47 10/02/2015
// Design Name:   traffic_light
// Module Name:   C:/Users/hung/Desktop/ise/ise/traffic_light_tb.v
// Project Name:  ise
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: traffic_light
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module traffic_light_tb;

	// Inputs
	reg clk;
	reg reset;
	// Outputs
	wire green_light;
	wire red_light;
	wire [3:0]cnt ;
	// Instantiate the Unit Under Test (UUT)
	traffic_light uut (
		.clk(clk), 
		.reset(reset), 
		.green_light(green_light),
		.red_light(red_light),
		.cnt(cnt)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		#10;
      reset = 0;  
		#20 
		reset = 1;
		// Add stimulus here
		
		#500 ;
		$finish ;
	end
	
	always
		begin
		#10 clk = !clk;
	end	
      
endmodule

