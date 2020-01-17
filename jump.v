`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2018 08:48:04 PM
// Design Name: 
// Module Name: jump
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


module jump(instruction, pc, jAddress);
    input [31:0] instruction;
    input [3:0] pc;
    output reg [31:0] jAddress;

    
    always @(instruction, pc) begin
        jAddress <= instruction<<2;
        jAddress[31:28] <= pc;
    
    end
    
endmodule
