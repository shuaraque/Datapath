`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2017 07:15:22 AM
// Design Name: 
// Module Name: Controller
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








module controller(instruction, EX, WB, M, jal, jumpSel, Mux31);
    


 input [31:0] instruction; 
 
 
 output reg [1:0] jumpSel;
 output reg Mux31;
 
 
  output reg [14:0] EX;
 // EX[5:0] = ALUOp
 // EX[10:6]= Asel/Bsel
 // EX[11] = RegSelDst
 // EX[12] = SignexSel 
 // EX[13] = ZeroExtend  or 16bit Selector
 // EX[14] = ALUbMux
 
 output reg [1:0] WB;
 // WB[0]RegWrite 
 // WB[1]MemtoReg 
 output reg [4:0] M;
 // M[0] = Branch
 // M[1] = MemRead
 // M[2]MemWrite
 // full or byte/half
 output reg  jal ;
 






always @ (*) begin
 M<=4'd0; jal<=1'd0;  WB<=2'd0; jumpSel<=2'd0; EX<=14'd0; Mux31<=0; 
 
case(instruction[31:26])
    6'b001000 : begin//addi
      WB[0]<=1;  WB[1]<=1; EX[5:0]<=6'b000000; EX[14] <=1; EX[11] <=1;
        end
    6'b001001 : begin//addiu
      WB[0]<=1;  WB[1]<=1; EX[5:0]<=6'b000000; EX[14] <=1; EX[11] <=1;
       end
    6'b011100 : begin//SPECIAL 2
    case(instruction[5:0])
     6'b000010: begin
     EX[12]<=1; WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b000010;
           end
     6'b000000: begin //madd
    EX[5:0]<=6'b011001;  
     end
     6'b000100: begin //msub
     EX[5:0]<=6'b011010; 
      end
    endcase
    end
       
    6'b011111: begin
    case(instruction[10:6])
    5'b10000 : begin //seb
    EX[12]<=1; WB[0]<=1; EX[5:0]<=6'b011100; WB[1]<=1; 
    end
    5'b11000 : begin //seh
        EX[12]<=1; WB[0]<=1; EX[5:0]<=6'b011101; WB[1]<=1;
        end
    endcase
    end
    6'b001100 : begin//andi
      WB[0]<=1;  WB[1]<=1;  EX[5:0]<=6'b000011;EX[12] <= 1; EX[14] <=1;  EX[11] <= 1;
        end


    6'b001101  : begin//ori
      WB[0]<=1;  WB[1]<=1; EX[5:0]<=6'b000100; EX[14] <=1; EX[11] <=1; EX[12] <=1;
        end
  
    6'b001110 : begin//xori
      WB[0]<=1;   WB[1]<=1; EX[5:0]<=6'b001110; EX[14] <=1; EX[11] <=1;
        end
    6'b001010 : begin //slti
      WB[0]<=1;  EX[5:0]<=6'b000101; EX[14] <=1; WB[1] <= 1; EX[11] <=1;
        end
    6'b001011 : begin //sltiu
      WB[0]<=1;   WB[1]<=1; EX[5:0]<=6'b000101; EX[14] <=1;
        end


    6'b100011: begin //lw
      WB[0]<=1;   M[1]<=1; EX[5:0]<=6'b000000; EX[14] <=1; EX[11] <= 1;
            end
    6'b100000: begin //lb
      WB[0]<=1;   M[1]<=1; EX[5:0]<=6'b000000; EX[14] <=1;  EX[11] <= 1;
        M[3]<=1;
        end
    6'b100001: begin //lh
      WB[0]<=1;  M[1]<=1; EX[5:0]<=6'b000000; EX[14] <=1;
        M[4]<=1;
        end
    6'b101011: begin //sw
        M[2]<= 1; EX[5:0]<=6'b000000; EX[14] <=1;
        end
    6'b101000: begin //sb
        M[2]<= 1; EX[5:0]<=6'b000000; EX[14] <=1; M[3]<=1;
        end
    6'b101001: begin //sh
        M[2]<= 1; EX[5:0]<=6'b000000; EX[14] <=1; M[4]<=1;
        end
     6'b001111: begin //lui
       WB[0]<=1;   WB[1]<=1; EX[5:0]<=6'b110000; EX[12] <= 1; EX[14] <=1;
           end

    6'b000000: begin//R functions
            case(instruction[5:0])
            6'b001000: begin //jr
                   EX[5:0]<=6'b000000; jumpSel<=2'b10;
                   end
            6'b101011 : begin //sltu
                EX[12]<=1; WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b000101;
                end
            6'b100000: begin//add
                EX[12]<=1; WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b000000;
                end
            6'b100010 : begin//sub
                EX[12]<=1; WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b000001;
                end
            6'b100100 : begin//and
                EX[12]<=1; WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b000011;
                end
            6'b100101 : begin//or
                EX[12]<=1; WB[0]<=1;WB[1]<=1; EX[5:0]<=6'b000100; 
                end
            6'b100111  : begin//nor
                EX[12]<=1; WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b001101;
                end
            6'b100110 : begin //xor b01110
                EX[12]<=1; WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b001110;
                end
            6'b000000 : begin //sll
            if(instruction != 0) begin 
              EX[12]<=1; WB[0]<=1; WB[1]<=1;  EX[5:0]<=6'b001000; EX[13] <= 1;EX[7:6] <= 1; EX[14] <=1;
                end
            else begin 
               EX[5:0]<=6'b000001;
                end
                    end
            6'b000100 : begin //sllv
                WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b010011;
                end
            6'b000011 : begin //sra
              EX[12]<=1; WB[0]<=1; EX[13] <=1; WB[1] <= 1;  EX[5:0]<=6'b001001; EX[13] <= 1;EX[7:6] <= 1; EX[14] <=1;
                end
            6'b000111 : begin //srav
                EX[12]<=1; WB[0]<=1; EX[5:0]<=6'b010101; WB[1] <= 1;
                end
            6'b000010 : begin //srl or rotr
                case(instruction[21])
                    1'b0: begin //srl
                      EX[12]<=1; WB[0]<=1;   WB[1]<=1;  EX[5:0]<=6'b001001; EX[13] <= 1;EX[7:6] <= 1; EX[14] <=1;
                        end
                    1'b1: begin //rotr
                      EX[12]<=1; WB[0]<=1;  WB[1]<=1; EX[5:0]<=6'b001010; EX[13] <= 1;EX[7:6] <= 1; EX[14] <=1;
                        end       
                            endcase
                            end
    6'b000110 : begin //srlv or rotrv
        case(instruction[6])
        1'b0: begin //srlv
            WB[0]<=1; WB[1]<=1;  EX[5:0]<=6'b010101;
            end
        1'b1: begin //rotrv
            WB[0]<=1; WB[1]<=1; EX[5:0]<=6'b011011; 
            end      
                endcase
                end
    
    6'b011000 : begin // Mult
        EX[5:0]<=6'b001011;
        end
    6'b011001 : begin // Multu
        EX[5:0]<=6'b011000;
        end
    6'b011010 : begin//div
        EX[5:0]<=6'b001100;
        end
    6'b010001 : begin//mthi
        EX[5:0]<=6'b010001; 
        end
    6'b010011 : begin//mtlo
        EX[5:0]<=6'b010010; 
        end
    6'b010000  : begin//mfhi
      EX[12]<=1; WB[0]<=1; EX[10:8]<=1; WB[1]<=1; EX[5:0]<=6'b001111;
        end
    6'b010010 : begin//mflo
      EX[12]<=1; WB[0]<=1; EX[10:8]<=2; EX[5:0]<=6'b010000; WB[1] <= 1;
        end
    6'b101010 : begin //slt
        EX[12]<=1; WB[0]<=1; EX[5:0]<=6'b000101; WB[1] <= 1; 
        end
    6'b001011 : begin //movn
        EX[12]<=1; WB[0]<=1; EX[5:0]<=6'b010111; WB[1] <= 1;
        end
    6'b001010 : begin //movz
        WB[0]<=1; EX[5:0]<=6'b010100; WB[1] <= 1;
        end
endcase
          end // end R functions
    
    6'b000100: begin //beq
        M[0]<=1; EX[5:0]<=6'b000111;
        end
    6'b000001: begin //REGIMM
    case(instruction[20:16])
    5'b00001: begin //bgez
        M[0]<=1; EX[5:0]<=6'b011110;
        end
    5'b00000: begin //bltz
        M[0]<=1; EX[5:0]<=6'b100000;
        end
         endcase
            end
    6'b000110: begin // blez
       M[0]<=1; EX[5:0]<=6'b100010;
            end
    6'b000111: begin ///Z
    case(instruction[20:16])
    5'b00000: begin //bgtz
       M[0]<=1; EX[5:0]<=6'b100001;
        end
         endcase
            end
    
    6'b000101: begin //BNE
       M[0]<=1; EX[5:0]<=6'b000110;
        end
    6'b000010: begin //j
        EX[5:0]<=6'b000000; jumpSel<=2'b01;
        end
    6'b000011: begin //jal
       WB[0]<=1; EX[5:0]<=6'b000000; EX[12]<=1; jal<=1; jumpSel<=2'b01;
        end
    
endcase
end
endmodule