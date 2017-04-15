`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:47 11/22/2015 
// Design Name: 
// Module Name:    lcd 
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
module lab9(
    input clk,
    input reset,
    input  button,
    output LCD_E,
    output LCD_RS,
    output LCD_RW,
    output [3:0]LCD_D
    );
	 localparam[1:0] S_IDLE = 2'b00,S_FIND = 2'b01, S_READ = 2'b10, S_INCR = 2'b11;
    reg flag;
	 reg [9:0] data [0:171];
	 wire btn_level, btn_pressed;
    reg prev_btn_level;
    reg [127:0] row_A, row_B;
	 
	 reg [1:0] Q,Q_next;
	 reg [11:0] idx;
	 reg [10:0] jdx;
    reg primes [1023:0];
	 
	 reg [7:0] c;
	 integer i;
	 
	 
	 
	 
    LCD_module lcd0( 
      .clk(clk),
      .reset(reset),
      .row_A(row_A),
      .row_B(row_B),
      .LCD_E(LCD_E),
      .LCD_RS(LCD_RS),
      .LCD_RW(LCD_RW),
      .LCD_D(LCD_D)
    );
    
    debounce btn_db0(
      .clk(clk),
      .btn_input(button),
      .btn_output(btn_level)
   );
    
    always @(posedge clk) begin
      if (reset)
        prev_btn_level <= 1;
      else
        prev_btn_level <= btn_level;
    end
	 
	 always @(posedge clk) begin
	   if(reset) Q <= S_FIND;
		else Q <= Q_next;
	 end
	
	 always @(*) begin
	   case(Q)
		  S_IDLE:
		    if(idx < 1024)Q_next = S_FIND;
			 else Q_next = S_IDLE;
		  S_FIND:
		    if(flag == 1) Q_next = S_READ;
			 else Q_next = S_FIND;
		  S_READ:
		    if(jdx > 1023) Q_next = S_INCR;
			 else Q_next = S_READ;
		  S_INCR:
		    Q_next = S_IDLE;
		endcase  
    end
	 
	 always @(posedge clk) begin
	   if(reset) begin
		  primes[0] <= 0;
		  primes[1] <= 0;
		    for (i = 2;i < 1024; i= i+1)
		      primes[i] <= 1;
		  idx <= 2;
		  c <= 0;
		  flag <= 0;
		end  
		else if(Q == S_FIND) begin
		  if(primes[idx]==1) begin
		    flag <= 1;
			 jdx <= idx;
		  end
        else idx <= idx+1;
		end  
		else if(Q == S_READ) begin  
		    jdx <= jdx +idx;
			 if(jdx <1024) primes[jdx] <= 0;
		end
		else if(Q == S_INCR) begin
		  data[c] <= idx;
		  c <= c+1;
		  idx <= idx+1;
		  flag <= 0;
		end
	 end
	 
    assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1 : 0;

    localparam[1:0] L_FIND = 2'b00,L_IDLE = 2'b01, L_OUT = 2'b10, L_INCR = 2'b11;
	 reg [1:0]P,P_next;
	 reg up;
	 reg [7:0] cnt;
	 reg [11:0] data_out;
	 reg [25:0] clock;
	 reg [7:0] show1,show2,show3,show4,show5;
	 
	 assign led = data_out;
	 
	 always @(posedge clk) begin
	   if(reset) P <= L_FIND;
		else P <= P_next;
	 end
	 
	 always @(*) begin
	   case(P)
		  L_FIND:
		    if(idx == 1024) P_next = L_IDLE;
			 else P_next = L_FIND;
		  L_IDLE:
		    P_next = L_OUT;
		  L_OUT:
		    if(btn_pressed) P_next = L_INCR;
			 else P_next = L_OUT;
		  L_INCR:
		    P_next = L_OUT;
		endcase
	 end
	 
	 always @(posedge clk) begin
      if (reset) begin
        up <= 1;
		  data_out <= 0;
		  clock <= 0;
		  cnt <= 1;
		  row_A <= 128'h2248656C6C6F2C20576F726C64212220; // "Hello, World!"
        row_B <= 128'h44656D6F206F6620746865204C43442E; // Demo of the LCD.
      end
		/*else if (P == L_IDLE) begin
		  cnt <= cnt + 1;
		  clock <= 0;
		  row_A <= row_B;
		  row_B <= {56'h5072696D652023,16'h3032,32'h20697320,24'h303033};
		end*/
      else if (P == L_OUT) begin
        if(clock != 35000000) clock <= clock+1;
		  else begin
		    clock <= 0;
			 if(up) begin
			   if(cnt == 172) cnt <= 1;
				else cnt <= cnt+1;
		        
				  show1 <= cnt[7:4]<10 ? cnt[7:4]+48:cnt[7:4]+55;
				  show2 <= cnt[3:0]<10 ? cnt[3:0]+48:cnt[3:0]+55;
				  data_out <= data[cnt-1];
				  show3 <= data_out[11:8]<10 ? data_out[11:8]+48:data_out[11:8]+55;
				  show4 <= data_out[7:4]<10 ? data_out[7:4]+48:data_out[7:4]+55;
				  show5 <= data_out[3:0]<10 ? data_out[3:0]+48:data_out[3:0]+55;
				  
				  row_A <= row_B;
				  row_B <= {56'h5072696D652023,show1,show2,32'h20697320,show3,show4,show5};
		    end
			 else begin
			   if(cnt == 1) cnt <= 172;
				else cnt <= cnt-1;
				
				show1 <= cnt[7:4]<10 ? cnt[7:4]+48:cnt[7:4]+55;
				show2 <= cnt[3:0]<10 ? cnt[3:0]+48:cnt[3:0]+55;
				data_out <= data[cnt-1];
				show3 <= data_out[11:8]<10 ? data_out[11:8]+48:data_out[11:8]+55;
				show4 <= data_out[7:4]<10 ? data_out[7:4]+48:data_out[7:4]+55;
				show5 <= data_out[3:0]<10 ? data_out[3:0]+48:data_out[3:0]+55;
				  
				row_B <= row_A;
				row_A <= {56'h5072696D652023,show1,show2,32'h20697320,show3,show4,show5};
			 end
		  end
		end
      else if(P == L_INCR) begin
		  if(up) up <= 0;
		  else up <= 1;
		end
    end

endmodule
