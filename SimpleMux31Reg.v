`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2018 08:28:45 PM
// Design Name: 
// Module Name: SimpleMux31Reg
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


module SimpleMux31Reg(out, in, sel);
  
    input [4:0] in;
    input sel;
    output [4:0] out;
    /* Fill in the implementation here ... */ 
   assign  out = (sel==0)? in:31;     
endmodule