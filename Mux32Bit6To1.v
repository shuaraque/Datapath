`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2018 10:38:50 PM
// Design Name: 
// Module Name: Mux32Bit6To1
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


module Mux32Bit6To1(out, a, b, c, d, e, sel);
    input [31:0] a, b, c, d, e;
    input [2:0] sel;
    output reg [31:0] out;
    
    always @(*) begin
    case (sel)
    0:out<=a ;
    1:out<=b ;
    2:out<=c ;
    3:out<=d ;
    4:out<=e ;
    endcase
    end
endmodule
