`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:11:39 10/26/2015 
// Design Name: 
// Module Name:    lab4 
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
module shift(input clk, input rst, output[31:0] sum,output [31:0] result);

	wire [7:0] in0, in1, in2, in3, in4, in5, in6, in7;
   reg [7:0] data0[0:31];
	reg [7:0] data1[0:31];
	reg [7:0] data2[0:31];
	reg [7:0] data3[0:31];
	reg [7:0] data4[0:31];
	reg [7:0] data5[0:31];
	reg [7:0] data6[0:31];
	reg [7:0] data7[0:31];
	 
   wire data_available;

    assign data_available = 1; // you must modify this in your code
	 reg cnt;
	 reg[31:0] num;
	 
	 assign in0 = data0[31];
	 assign in1 = data1[31];
	 assign in2 = data2[31];
	 assign in3 = data3[31];
	 assign in4 = data4[31];
	 assign in5 = data5[31];
	 assign in6 = data6[31];
	 assign in7 = data7[31];
	 assign result = num;

	adder_tree add (
		.clk(clk),
		.rst(rst),
		.in_valid(data_available),
		.in0(in0),
		.in1(in1),
		.in2(in2),
		.in3(in3),
		.in4(in4),
		.in5(in5),
		.in6(in6),
		.in7(in7),
		.sum(sum)
	); 

  always @(posedge clk) begin
    if (rst) begin
      `include "data.dat"
		data_available <= 0;
		sum <= 0;
		cnt <= 0;
	end
	else if(cnt<=31) begin
  	   for(int i=0 ; i < 31;i++) begin
		   data0[i+1] <= data0[i]; 
			data1[i+1] <= data1[i]; 
			data2[i+1] <= data2[i]; 
			data3[i+1] <= data3[i]; 
			data4[i+1] <= data4[i]; 
			data5[i+1] <= data5[i]; 
			data6[i+1] <= data6[i]; 
			data7[i+1] <= data7[i]; 
		end
		cnt <= cnt+1;
		data_available <= 1;
    end
	 else begin
	   data_available <= 0;
	   cnt <= 0;
		num <= (sum + 128) >>8 ;
    end
 end	 
endmodule