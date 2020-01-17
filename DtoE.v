`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2018 06:59:48 PM
// Design Name: 
// Module Name: DtoE
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


module DtoE(clk, rst, WBD, MemD, EX, PCD, ReadData1, ReadData2, SignExtendD, ZeroExtendD, Bit5ExtendD, 
            inst25to21D, inst20to16D, inst15to11D, WBE, MemE, ALUop, RegDstSel, SignexSel, BitExSel, 
            ALUsrc, PCE, ReadData1E, ReadData2E, SignExtendE, ZeroExtendE, Bit5ExtendE, rs25to21E, inst20to16E, inst15to11E);
  
  			output reg [31:0] PCE, ReadData1E, ReadData2E, SignExtendE, ZeroExtendE, Bit5ExtendE;
            output reg [4:0] inst20to16E, inst15to11E, rs25to21E;
            output reg [5:0] ALUop;
            output reg [4:0] MemE;
            output reg [1:0] WBE;
            output reg RegDstSel, SignexSel, BitExSel;// ExtendSel
  			output reg [5:0] ALUsrc;
  
           input [31:0] PCD, SignExtendD, ZeroExtendD, Bit5ExtendD, ReadData1, ReadData2;
  					input [14:0] EX;
            input [4:0] inst20to16D, inst15to11D, inst25to21D;
            input [4:0] MemD;
            input [1:0] WBD;
            input clk, rst; 
            
            always @(posedge clk)begin
                    if(rst) begin
                      PCE <= 0;
                      ReadData1E <= 0;
                      ReadData2E <= 0;
                      SignExtendE<=0; 
                      ZeroExtendE<=0; 
                      Bit5ExtendE<=0;
            		  inst20to16E <= 0;
                      inst15to11E <= 0;
                      rs25to21E<=0;
            		  ALUop <= 0;
                      MemE <= 0;
                      WBE <= 0;
                      RegDstSel <= 0;
                      SignexSel <= 0;
                      BitExSel <= 0;
                      ALUsrc <= 0;
                      end
                    else begin
                      PCE <= PCD;
                      ReadData1E <= ReadData1;
                      ReadData2E <= ReadData2;
                      SignExtendE<=SignExtendD; 
                      ZeroExtendE<=ZeroExtendD; 
                      Bit5ExtendE<=Bit5ExtendD;
            		  inst20to16E <= inst20to16D;
                      inst15to11E <= inst15to11D;
                      rs25to21E <=inst25to21D;
                      MemE <= MemD;
                      WBE <= WBD;
                      ALUop <= EX[5:0];
                      ALUsrc[4:0] <= EX[10:6];// ASel/BSel
                      ALUsrc[5] <= EX[14];   //ALUbMux
                      RegDstSel <= EX[11];
                      SignexSel <= EX[12];
                      BitExSel <= EX[13];
                        end
                   end
            
            
endmodule
