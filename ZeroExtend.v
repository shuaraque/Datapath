`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2018 02:03:58 PM
// Design Name: 
// Module Name: ZeroExtend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ZeroExtend(in, out);
input [15:0] in;
output reg [31:0] out;

 always @ (in) begin
 out[31:16] <= 16'b0000000000000000;
 out[15:0] <= in;
 end
endmodule
