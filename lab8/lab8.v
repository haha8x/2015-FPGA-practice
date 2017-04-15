`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:36:48 11/30/2015 
// Design Name: 
// Module Name:    lab8 
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
module lab8(
  input clk, 
  input reset, 
  input ROT_A, 
  input ROT_B,
  output reg [7:0] led
    );
	 
  wire rotary_event;
  wire rotary_right;
  
  reg [12:0] dutycycle;
  reg [12:0] cnt;

Rotation_direction R1(.CLK(clk), .ROT_A(ROT_A), .ROT_B(ROT_B), .rotary_event(rotary_event), .rotary_right(rotary_right));

always @(posedge clk) begin
  if(reset) dutycycle <= 0;
  else begin
    if(rotary_event == 1 && rotary_right == 1) begin
	   if(dutycycle < 100) dutycycle <= dutycycle + 1;
	 end
    else if(rotary_event == 1 && rotary_right == 0) begin
	   if(dutycycle > 0) dutycycle <= dutycycle - 1;
	 end
  end
end

always @(posedge clk) begin
  if(reset) begin 
    led <= 0;
  end	 
  else begin
    if(cnt < dutycycle) led <= 8;	
	 else if(cnt >= dutycycle) led <= 0;	
  end 
end

always @(posedge clk) begin
  if(reset)  cnt <= 0;
  else begin
    if(cnt == 100) cnt <= 0;
    else cnt <= cnt + 1;
  end
end

endmodule
