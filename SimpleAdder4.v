`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2018 07:54:52 PM
// Design Name: 
// Module Name: SimpleAdder4
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


module SimpleAdder4(in,out);
    input [31:0] in;
    output reg [31:0] out;

    /* Please fill in the implementation here... */
    
    always @ (in) begin
        out <= in + 4;
    end
endmodule
