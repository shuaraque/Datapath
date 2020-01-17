`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2018 05:44:37 PM
// Design Name: 
// Module Name: Mux5bit2to1
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


module Mux5Bit2To1(out, A, B, sel);
    
        output [4:0] out;
        
        input [4:0] A, B;
        input  sel;
        
       
        /* Fill in the implementation here ... */ 
         assign  out = (sel==0)? A:B;
             
    endmodule
