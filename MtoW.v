`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2018 08:09:07 PM
// Design Name: 
// Module Name: MtoW
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


module MtoW(clk, rst, WBM, ReadDataM, ALUResultM, RegDstM,
            RegWrite, MemtoReg, ReadDataW, ALUResultW, RegDstW);
            
    input [31:0] ReadDataM, ALUResultM;
    input [4:0] RegDstM;
    input [1:0] WBM;
    input clk, rst;
    
    output reg [31:0] ReadDataW, ALUResultW;
    output reg [4:0] RegDstW;
    output reg RegWrite, MemtoReg; 
    
    always @ (posedge clk) begin
        if(rst) begin
            RegWrite <=0;
            MemtoReg <=0;
            ReadDataW <=0;
            ALUResultW <=0;
            RegDstW <=0;
         end
         else begin
            RegWrite <= WBM[0];
            MemtoReg <=WBM[1];
            ReadDataW <= ReadDataM;
            ALUResultW <=ALUResultM;
            RegDstW <= RegDstM;
         end
     end
           
endmodule
