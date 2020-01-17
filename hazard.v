`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2018 12:05:18 AM
// Design Name: 
// Module Name: hazard
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


module hazard(instruction, rdE, rtE, regWriteE, memReadE, rdM, memReadM, PCWrite, FDWrite, ctrl, rstFD, BranchD, BranchE, BranchM);

    input [31:0] instruction;
    input [4:0] rtE, rdM, rdE;
    input memReadE, memReadM, regWriteE, BranchD, BranchE, BranchM;
    
    
    output reg PCWrite, FDWrite, ctrl, rstFD;
    
    
    always @ (*) begin
        PCWrite<=1; FDWrite<=1; ctrl<=0; rstFD <= 0;
        
        // stall for inst. in E and jr in D 
       if((instruction[31:26]==0)&&(instruction[5:0]==8) && (regWriteE==1) && (instruction[25:21]==rdE))begin
            PCWrite<=0; FDWrite<=0; ctrl<=1;
        end
        // stall for lw in M and jr in D
        if((instruction[31:26]==0)&&(instruction[5:0]==8) && (memReadM==1) && (instruction[25:21]==rdM))begin
            PCWrite<=0; FDWrite<=0; ctrl<=1;
        end
        // stall for lw in E and any inst. in D
        if((memReadE == 1) && ((instruction[25:21]==rtE)||(instruction[20:16]==rtE)))begin
            PCWrite<=0; FDWrite<=0; ctrl<=1;
        end
        if((BranchD == 1 || BranchE ==1) && (!(BranchM ==1 )) ) begin
            PCWrite<=0; FDWrite<=0;
        end
        if(BranchE == 1)begin 
            ctrl<=1;
        end
        
       
         
    end
endmodule
