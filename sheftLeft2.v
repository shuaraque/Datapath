`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2018 02:09:57 PM
// Design Name: 
// Module Name: sheftLeft2
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


module sheftLeft2(in, out);
    input [31:0] in;
    output reg [31:0] out;
    
    always @(in) begin
        out <= in<<2;
    end
endmodule
