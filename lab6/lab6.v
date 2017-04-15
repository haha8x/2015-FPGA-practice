`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:43:16 10/20/2015 
// Design Name: 
// Module Name:    lab5 
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
module lab5(
    input clk,
    input reset,
    input button,
    input rx,
    output tx,
    output [7:0] led
    );

localparam [1:0] S_IDLE = 2'b00, S_WAIT = 2'b01, S_SEND = 2'b10, S_INCR = 2'b11;
localparam MEM_SIZE = 32;

// declare system variables
wire btn_pressed;
reg [7:0] cnt;
reg [7:0] send_counter;
reg [1:0] Q, Q_next;
reg [17:0] data[0:MEM_SIZE-1];
wire [7:0] result[95:0];
integer idx,j;
reg [7:0] A[0:31];

reg flag;
reg [5:0] i ;

// declare UART signals
wire transmit;
wire received;
wire [7:0] rx_byte;
reg  [7:0] rx_temp;
wire [7:0] tx_byte;
wire is_receiving;
wire is_transmitting;
wire recv_error;

assign led = {btn_pressed,1'b0 ,cnt[5:0]};
assign tx_byte = result[send_counter];

assign result[5] =  32;
assign result[11] = 32;
assign result[17] = 32;
assign result[23] = 13;
assign result[29] = 32;
assign result[35] = 32;
assign result[41] = 32;
assign result[47] = 13;
assign result[53] = 32;
assign result[59] = 32;
assign result[65] = 32;
assign result[71] = 13;
assign result[77] = 32;
assign result[83] = 32;
assign result[89] = 32;
assign result[95] = 13;

debounce btn_db(
    .clk(clk),
    .btn_input(button),
    .btn_output(btn_pressed)
    );

uart uart(
    .clk(clk),
    .rst(reset),
    .rx(rx),
    .tx(tx),
    .transmit(transmit),
    .tx_byte(tx_byte),
    .received(received),
    .rx_byte(rx_byte),
    .is_receiving(is_receiving),
    .is_transmitting(is_transmitting),
    .recv_error(recv_error)
    );

// ------------------------------------------------------------------------
// FSM of the "Hello, World!" transmission controller

always @(posedge clk) begin
  if (reset) Q <= S_IDLE;
  else 
     Q <= Q_next;
end

always @ (posedge clk )
begin 
	if(reset)  flag <= 0 ;
	else flag <= btn_pressed ;

end 
always @(*) begin // FSM next-state logic
  case (Q)
    S_IDLE: // wait for button click
      if (btn_pressed == 1 && flag == 0 ) Q_next = S_WAIT;
      else Q_next = S_IDLE;
    S_WAIT: // wait for the transmission of current data byte begins
      if (is_transmitting == 1) Q_next = S_SEND;
      else Q_next = S_WAIT;
    S_SEND: // wait for the transmission of current data byte finishes
      if (is_transmitting == 0) Q_next = S_INCR; // transmit next character
      else Q_next = S_SEND;
    S_INCR:
      if (send_counter == 95) Q_next = S_IDLE; // string transmission ends
      else Q_next = S_WAIT;
  endcase
end

// FSM output logics
assign transmit = (Q == S_WAIT)? 1 : 0;

// FSM-controlled send_counter incrementing data path
always @(posedge clk) begin
  if (reset || (Q == S_IDLE))
    send_counter <= 0;
  else if (Q == S_INCR)
    send_counter <= send_counter + 1;
end

// End of the FSM of the "Hello, World! " transmission controller
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// The following logic stores the UART input in a temporary buffer
// You must replace this code by your own code to store multiple
// bytes of data.
//
always @(posedge clk) begin
  if (reset)begin
    rx_temp <= 8'b0;
	 cnt <= 0;
	 for(idx = 0; idx < 32; idx = idx+1)
	 begin 
	  A[idx] <= 0;
	 end	
  end
  
  else if (received)
    begin
     A[cnt] <= rx_byte;
	  cnt <= cnt+1;
    end
	
end
// ------------------------------------------------------------------------

always @(posedge clk) begin
 if(reset) begin 
	i <= 0 ;
 end
 else if(cnt == 32)begin 
   //for(i=0;i<4;i=i+1)begin
	 data[i] = A[i]*A[16]+A[i+1]*A[20]+A[i+2]*A[24]+A[i+3]*A[28];
	 data[i+1] = A[i]*A[17]+A[i+1]*A[21]+A[i+2]*A[25]+A[i+3]*A[29];
	 data[i+2] = A[i]*A[18]+A[i+1]*A[22]+A[i+2]*A[26]+A[i+3]*A[30];
	 data[i+3] = A[i]*A[19]+A[i+1]*A[23]+A[i+2]*A[27]+A[i+3]*A[31];
	//end
    if(i<16)
		i <= i + 4 ;
 end
end	
	convert c1(.data(data[0]),.h0(result[0]),.h1(result[1]),.h2(result[2]),.h3(result[3]),.h4(result[4]));
	convert c2(.data(data[1]),.h0(result[6]),.h1(result[7]),.h2(result[8]),.h3(result[9]),.h4(result[10]));
	convert c3(.data(data[2]),.h0(result[12]),.h1(result[13]),.h2(result[14]),.h3(result[15]),.h4(result[16]));
	convert c4(.data(data[3]),.h0(result[18]),.h1(result[19]),.h2(result[20]),.h3(result[21]),.h4(result[22]));
	
	convert c5(.data(data[4]),.h0(result[24]),.h1(result[25]),.h2(result[26]),.h3(result[27]),.h4(result[28]));
	convert c6(.data(data[5]),.h0(result[30]),.h1(result[31]),.h2(result[32]),.h3(result[33]),.h4(result[34]));
	convert c7(.data(data[6]),.h0(result[36]),.h1(result[37]),.h2(result[38]),.h3(result[39]),.h4(result[40]));
	convert c8(.data(data[7]),.h0(result[42]),.h1(result[43]),.h2(result[44]),.h3(result[45]),.h4(result[46]));
	
	convert c9(.data(data[8]),.h0(result[48]),.h1(result[49]),.h2(result[50]),.h3(result[51]),.h4(result[52]));
	convert c10(.data(data[9]),.h0(result[54]),.h1(result[55]),.h2(result[56]),.h3(result[57]),.h4(result[58]));
	convert c11(.data(data[10]),.h0(result[60]),.h1(result[61]),.h2(result[62]),.h3(result[63]),.h4(result[64]));
	convert c12(.data(data[11]),.h0(result[66]),.h1(result[67]),.h2(result[68]),.h3(result[69]),.h4(result[70]));
	
	convert c13(.data(data[12]),.h0(result[72]),.h1(result[73]),.h2(result[74]),.h3(result[75]),.h4(result[76]));
	convert c14(.data(data[13]),.h0(result[78]),.h1(result[79]),.h2(result[80]),.h3(result[81]),.h4(result[82]));
	convert c15(.data(data[14]),.h0(result[84]),.h1(result[85]),.h2(result[86]),.h3(result[87]),.h4(result[88]));
	convert c16(.data(data[15]),.h0(result[90]),.h1(result[91]),.h2(result[92]),.h3(result[93]),.h4(result[94]));
 
	


endmodule


