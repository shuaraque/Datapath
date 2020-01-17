`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2018 07:42:11 PM
// Design Name: 
// Module Name: EtooM
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


module EtooM(clk, rst, WBE, MemE, PCAdderE, zeroE, ALUResultE, ReadData2E, RegDstE,
            WBM, MemWrite, MemRead, Branch, PCAdderM, zeroM, ALUResultM, ReadData2M, RegDstM, lbSel);
            output reg [31:0]PCAdderM, ALUResultM, ReadData2M;
            output reg [4:0] RegDstM;
            output reg [1:0] WBM, lbSel;
            output reg zeroM, MemWrite, MemRead, Branch;
            
            input [31:0] PCAdderE, ALUResultE, ReadData2E;
            input [4:0] RegDstE;
            input [4:0] MemE;
            input  [1:0] WBE;
            input zeroE, clk, rst; 
            
            always @(posedge clk)begin
                    if(rst) begin
                        WBM <= 0;
                        zeroM <= 0;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch  <= 0;
                        PCAdderM <= 0;
                        ALUResultM <= 0;
                        ReadData2M <= 0;
                        RegDstM <= 0;
                        lbSel <= 0;
                       end
                    else begin
                        WBM <= WBE;
                        zeroM <= zeroE;
                        lbSel <= MemE[4:3];
                        MemWrite <= MemE[2];
                        MemRead <= MemE[1];
                        Branch  <= MemE[0];
                        PCAdderM <= PCAdderE; 
                        ALUResultM <= ALUResultE;
                        ReadData2M <= ReadData2E;
                        RegDstM <= RegDstE;
                        end
                   end
            
            
endmodule

