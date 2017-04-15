`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:24 10/08/2015 
// Design Name: 
// Module Name:    posfix 
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
module postfix(input CLK,input RESET,input OP_MODE,input IN_VALID,input [3:0] IN, 
               output reg [15:0] OUT,output reg OUT_VALID);
reg [15:0] val [7:0];
reg [3:0] a;
reg k;

always @(posedge CLK, negedge RESET)
begin
if(RESET == 0)
begin
 OUT <= 0;
 val[0] <= 16'd0;
 val[1] <= 16'd0;
 val[2] <= 16'd0;
 val[3] <= 16'd0;
 val[4] <= 16'd0;
 val[5] <= 16'd0;
 val[6] <= 16'd0;
 val[7] <= 16'd0;
 a <= 4'd0;
 OUT_VALID <= 0;
 k <= 0;
end 

else
begin
    if(IN_VALID == 1)
	 begin
	 k <= 1'b1;
	    if(OP_MODE == 0)
		 begin
		    val[a] <= IN;
		    a <= a+4'd1;
		 end
		 
	    else begin
	     case(IN)
		      4'b0001:
				begin
				     val[a-2] <= val[a-2]+val[a-1];
					  val[a-1] <= 0;
					  a <= a-4'd1;
				end
				4'b0010:
				begin
				     val[a-2] <= val[a-2]-val[a-1];
					  val[a-1] <= 0;
					  a <= a-4'd1;
				end
				4'b0100:
				begin
	              val[a-2] <= val[a-2]*val[a-1];
					  val[a-1] <= 0;
					  a <= a-4'd1;		  
	         end
			endcase	
		 end
	  end
end	  
end

always @(posedge CLK, negedge RESET)
begin
if(k == 1'b1 && IN_VALID == 1'b0)
begin
	OUT_VALID <= 1;
	OUT <= val[0];
	a <= 0;
	k <= 0;
end

if(OUT_VALID == 1'b1)
begin
  val[0] <= 0;
  OUT_VALID <= 0;
  OUT <= 0;
end

end
	
endmodule
