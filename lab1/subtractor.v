`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:24 09/24/2015 
// Design Name: 
// Module Name:    subtractor 
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
module subtractor(A,B,Cin,S,C,Cout);
input [7:0] A,B;
input Cin;
output [8:0] S;
output [8:0] C;
output Cout;
wire [7:0] t;


comp_8bits comp(.B(B),.C(C));

FA_1bit FA0(.A(A[0]), .B(C[0]), .Cin(Cin), .S(S[0]), .Cout(t[0]));
FA_1bit FA1(.A(A[1]), .B(C[1]), .Cin(t[0]), .S(S[1]), .Cout(t[1]));
FA_1bit FA2(.A(A[2]), .B(C[2]), .Cin(t[1]), .S(S[2]), .Cout(t[2]));
FA_1bit FA3(.A(A[3]), .B(C[3]), .Cin(t[2]), .S(S[3]), .Cout(t[3]));
FA_1bit FA4(.A(A[4]), .B(C[4]), .Cin(t[3]), .S(S[4]), .Cout(t[4]));
FA_1bit FA5(.A(A[5]), .B(C[5]), .Cin(t[4]), .S(S[5]), .Cout(t[5]));
FA_1bit FA6(.A(A[6]), .B(C[6]), .Cin(t[5]), .S(S[6]), .Cout(t[6]));
FA_1bit FA7(.A(A[7]), .B(C[7]), .Cin(t[6]), .S(S[7]), .Cout(t[7]));
FA_1bit FA8(.A(A[7]), .B(C[8]), .Cin(t[7]), .S(S[8]), .Cout(Cout));


endmodule
//-------------------------------------------------------------------
module FA_1bit(A,B,Cin,S,Cout );
input A,B,Cin;
output S,Cout;

assign S=Cin^A^B;
assign Cout = (A & B) | (Cin & B) | (Cin & A);
endmodule
//--------------------------------------------------------------------
module comp_8bits(B,C);

input [7:0] B;
output [8:0] C;
wire [6:0] t;

assign C[0]=B[0]^0;

assign C[1]=C[0]^B[1];
assign t[0]= C[0]|C[1];

assign C[2]=t[0]^B[2];
assign t[1]=t[0]|C[2];

assign C[3]=t[1]^B[3];
assign t[2]=t[1]|C[3];

assign C[4]=t[2]^B[4];
assign t[3]=t[2]|C[4];

assign C[5]=t[3]^B[5];
assign t[4]=t[3]|C[5];

assign C[6]=t[4]^B[6];
assign t[5]=t[4]|C[6];

assign C[7]=t[5]^B[7];
assign t[6]=t[5]|C[7];

assign C[8]=t[6]^B[7];
endmodule
