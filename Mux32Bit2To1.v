`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2018 09:04:03 PM
// Design Name: 
// Module Name: Mux32Bit2To1
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

module Mux32Bit2To1(out, A, B, sel);

    output [31:0] out;
    
    input [31:0] A, B;
    input  sel;
    
   
    /* Fill in the implementation here ... */ 
     assign  out = (sel==0)? A:B;
         
endmodule