`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2018 08:00:57 PM
// Design Name: 
// Module Name: bytExtnd
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


module bytExtndWithSel (in, out, sel);
    input [31:0] in;
    
   input [1:0]sel;
    output reg [31:0] out;
	always @(in) begin
	out<=in;
	if(sel[0]==1) begin
	   if(in[7]==0) begin
	    out[31:8] <= 24'b000000000000000000000000;
	    out [7:0] <= in[7:0];
	    end 
	   else begin
	       out[31:8] <= 24'b111111111111111111111111;
	       out [7:0] <= in[7:0];
	   end
	    
    end
    if(sel[1]==1) begin
       if(in[15]==0) begin
            out[31:16] <= 16'b0000000000000000;
            out [15:0] <= in[15:0];
            end 
           else begin
               out[31:16] <= 16'b1111111111111111;
               out [15:0] <= in[15:0];
           end
           end
	end
endmodule
