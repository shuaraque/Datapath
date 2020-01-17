`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2018 05:30:25 PM
// Design Name: 
// Module Name: HiLoReg
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


module HiLoReg(clk, HiIn,LoIn, write, HiOut, LoOut);
    input [31:0] HiIn,LoIn;
    input write, clk;
    output reg [31:0] HiOut, LoOut;
    initial begin
    HiOut=0;
    LoOut = 0;
    end
    always @(posedge clk) begin
        if(write) begin
           HiOut <= HiIn;
           LoOut <= LoIn;
        end
    end

endmodule
