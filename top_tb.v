`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: Majed almodhabri, John Palanca, Sabrina Huaraque
//// effort    Majed 33%,         John 33%      Sabrian 33%     
//// Create Date: 10/15/2018 12:03:21 PM
//// Design Name: 
//// Module Name: top_tb
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


module top_tb();
    reg clkin, rst;
    wire [31:0] WriteData, Hi,Lo; 
    wire [31:0] PC;
    
    DatapathTop u(
        .rst(rst),
        .clkin(clkin),
        .PC(PC),
        .WriteData(WriteData),
        .Hi(Hi),
        .Lo(Lo)
        );

initial begin
		clkin <= 1'b0;
		forever  
		#10 clkin <= ~clkin;
	end
	initial begin
	   rst <=1;
	   #30
	   rst<=0;
	end






endmodule
