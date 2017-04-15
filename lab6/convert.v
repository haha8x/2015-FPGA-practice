`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:57:38 11/16/2015 
// Design Name: 
// Module Name:    convert 
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
module convert(input [17:0]data,output [7:0]h0,output [7:0]h1,output [7:0]h2,output [7:0]h3,output [7:0]h4);
reg [7:0]o0;
reg [7:0]o1;
reg [7:0]o2;
reg [7:0]o3;
reg [7:0]o4;

assign h0=o0;
assign h1=o1;
assign h2=o2;
assign h3=o3;
assign h4=o4;

always @(*)begin
  if(data[17:16] < 10) 
    o0 <= data[17:16]+8'd48;
  else o0 <= data[17:16]+8'd55;
  
  if(data[15:12] < 10) 
    o1 <= data[15:12]+8'd48;
  else o1 <= data[15:12]+8'd55;
  
  if(data[11:8] < 10) 
    o2 <= data[11:8]+8'd48;
  else o2 <= data[11:8]+8'd55;
  
  if(data[7:4] < 10) 
    o3 <= data[7:4]+8'd48;
  else o3 <= data[7:4]+8'd55;
  
  if(data[3:0] < 10) 
    o4 <= data[3:0]+8'd48;
  else o4 <= data[3:0]+8'd55;
end
endmodule
