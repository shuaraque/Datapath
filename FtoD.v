`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2018 06:26:00 PM
// Design Name: 
// Module Name: FtoD
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


module FtoD(clk, rst, regWrite, instructionF,  PCF, instructionD, PCD);

    output reg [31: 0] instructionD, PCD;
    input [31:0] instructionF, PCF;
    input clk, rst, regWrite;
    
     always @(posedge clk)begin
        if(rst) begin
           instructionD <= 32'd0;
           PCD <= 32'd0;
           end
        else begin
            if(regWrite==1) begin
                instructionD <= instructionF;
                PCD <= PCF;
                end
            end
       end
endmodule
