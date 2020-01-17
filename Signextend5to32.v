`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2018 08:22:23 AM
// Design Name: 
// Module Name: Signextend5to32
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


module Signextend5to32(in, out);

    /* A 16-Bit input word */
    input [4:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    /* Fill in the implementation here ... */
	always @(in) begin
	if(in[4]==1'b1)  out <= {27'b000000000000000000000000000,in[4:0]};
              else  out <= {{27{in[4]}}, in};

	end
endmodule
