`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2018 09:29:36 PM
// Design Name: 
// Module Name: forward
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


module forwardEX(ALUsrc, regWriteM, regWriteWB, DstRegM, DstRegWB, RsE, RtE, ASel, BSel, ALUbMux);
    input regWriteM, regWriteWB;
    input [4:0]  DstRegM, DstRegWB, RsE, RtE;
    input [5:0] ALUsrc;// this is alu A and B input sources, they come form EX[].
    output reg [2:0]  BSel;
    output reg [1:0] ASel;
    output reg ALUbMux;
    
    
    always @(*) begin
    ASel <= ALUsrc[1:0];
    BSel <= ALUsrc[4:2];
    ALUbMux <= ALUsrc[5];
    if((regWriteM && ((DstRegM==RsE) && (DstRegM > 0)))) begin
    ASel<=2;
    end  
    else if(regWriteWB && (DstRegWB==RsE) && (DstRegWB > 0)) begin
    ASel<=3;
    end
    
    if(ALUsrc[1:0]==1)begin
        if((regWriteM && ((DstRegM==RtE) && (DstRegM > 0)))) begin
        ASel<=2;
        end  
        else if(regWriteWB && (DstRegWB==RtE) && (DstRegWB > 0)) begin
        ASel<=3;
        end
    end

    if(regWriteM && (DstRegM==RtE)&& (DstRegM > 0)) begin
    BSel <= 3;
    end
    else if(regWriteWB && (DstRegWB==RtE) && (DstRegWB > 0)) begin
    BSel <= 4;
    end 
    
    end
    
endmodule
