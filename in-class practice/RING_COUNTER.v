`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:26 10/05/2015 
// Design Name: 
// Module Name:    RING_COUNTER 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RING_COUNTER(
    input clk,
    input rst,
    output reg t0,
	 output reg t1,
	 output reg t2,
	 output reg t3
    );
	 wire [3:0] counter;
    always@ (posedge clk)
	 begin 
	 t1<=t0;
	 t2<=t1;
	 t3<=t2;
	 t0<=t3;
	 end
    
	 always@ (posedge clk or rst)
	 begin 
	 t0=1'b1;
	 t1=1'b0;
	 t2=1'b0;
	 t3=1'b0;
	 end

endmodule


