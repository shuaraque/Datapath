`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2018 09:02:41 PM
// Design Name: 
// Module Name: Mux32Bit3to1
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


module Mux32Bit3to1(out, A, B, C, sel);

    output reg [31:0] out;
    
    input [31:0] A, B, C;
    input [1:0] sel;
    
   
    /* Fill in the implementation here ... */ 
    always @(*) begin
    out<=A;
    case(sel)
    2'b00: out<=A;
    2'b01: out<=B;
    2'b10: out<=C;
    endcase
    end
    
endmodule