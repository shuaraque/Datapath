`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2018 09:36:03 PM
// Design Name: 
// Module Name: mux4to1
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


module Mux32Bit4To1(out, a, b, c, d, sel);
    input [31:0] a, b, c, d;
    input [1:0] sel;
    output reg [31:0] out;
    
    
    always @(*) begin
    case (sel)
    0:out<=a ;
    1:out<=b ;
    2:out<=c ;
    3:out<=d ;
    endcase
    end
    
    
endmodule
