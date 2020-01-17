`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2018 07:50:10 PM
// Design Name: 
// Module Name: forwardD
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


module forwardD(opcode, jr, rdM, rsD, mux);
    output reg mux;
    input [5:0] opcode, jr;
    input [4:0]  rdM, rsD;
    //input memRead;
    
    always @(*) begin
        mux<=0;
        if((opcode==6'b0) && (jr== 6'b001000) && (rdM==rsD) ) begin
            mux<=1;
        end
    end
endmodule
