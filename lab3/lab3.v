`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:33 10/15/2015 
// Design Name: 
// Module Name:    lab3 
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
module lab3(
    input clk,
    input reset,
    input btn_east,
    input btn_west,
    output reg signed [7:0]LED
    );

reg [24:0]count;	 


always@(posedge clk )
begin
	 if(reset == 1) 
	 begin
	 count <= 25'd0;
	
	 end
	 else if(btn_east | btn_west ) count <= 0 ;
	 else 
	 begin
	 if(count == 25'd1000000) count <= count ;
	 else count <= count + 25'd1;
	 end
end

always@(posedge clk )
begin	
        if(reset == 1)
		  begin
			LED <= 0;
		  end
		  else begin 
			  if(count == 25'd1000000)
			  begin
					
					if(btn_east == 1) 
					begin
						 if(LED != -8'd8)
						 begin
						  LED <= LED - 8'd1;
						 end
						 else 
						 begin
						  LED <= LED;
						 end
					end	 
					else if(btn_west == 1) 
					begin
						 if(LED != 8'd7)
						 begin
						 LED <= LED + 8'd1;
						 
						 end
						 else 
						 begin
						 LED <= LED;
						 
						 end
					
					end
					
			  end
		end
end



endmodule
