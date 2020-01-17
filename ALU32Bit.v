`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
//Team Members:  Sabrina Huaraque, John Irene Izere, Majed Almodhabri  
// % Effort    : Sabrina 33.33% , John 33.33%, Majed 33.33%
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, HiIn, LoIn, ALUResult, HiOut,LoOut, writeHiLo , Zero);

	input [5:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;
	input signed [31:0] HiIn, LoIn;	    // inputs
	integer i = 0;
    reg [31:0] cnt;
    reg flag = 0;
    reg [63:0] ALU64;
    reg [31:0] y;
    reg signed [31:0] SA, SB;
    output reg writeHiLo;
    output reg signed [31:0] HiOut, LoOut;

	output reg [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0
    /* Please fill in the implementation here... */
     always@(ALUControl, A, B, HiIn, LoIn) begin
            ALUResult = 0;
            writeHiLo=0;
           case(ALUControl)
           6'b000000: ALUResult = A + B ;
           6'b000001: ALUResult = A - B;
           6'b000010: ALUResult = A * B;
           6'b000011: ALUResult = A & B;
           6'b000100: begin
            ALUResult = $signed(A) | $signed(B); 
            writeHiLo =0;
            end
           6'b000101: //slt
            begin 
            if(A<B) ALUResult = 1;
            else ALUResult = 0;
            end
           6'b000110: ALUResult = (A == B) ? 1:0;
           6'b000111: ALUResult = (A != B) ? 1:0;
           6'b001000: ALUResult = A << B; //sll
           6'b001001:begin //srl 
            ALUResult = A >>B;
            end
           6'b001010: ALUResult = ((A >> B) | (A << (32-B))); //rotr
           6'b001011: begin //mult operation
                     {HiOut, LoOut}<= $signed(A)*$signed(B);
                     writeHiLo=1;
                     end
           6'b001100: begin //div
                     {HiOut, LoOut} <= A%B<<32;
                     {HiOut, LoOut}<= A/B;
                    writeHiLo=1;
                    end
           6'b001101: ALUResult = ~(A | B);
           6'b001110: ALUResult = (A ^ B);
           6'b001111: ALUResult = B; // mfhi notice you need to set RegDst and regwrite
           6'b010000: ALUResult = B; // mflo notice you need to set RegDst and regwrite
           6'b010001: begin // mthi
                HiOut<= A;
                writeHiLo=1;
           end
           6'b010010: begin // mtlo
               LoOut<= A;
               writeHiLo=1;
           end
           6'b010011: ALUResult = B<<A; //sllv
           6'b010100:begin//movz
                if (B == 0) begin
                ALUResult = A;
                end
                end
           6'b010101: ALUResult = B>>A; //salv 
           6'b010111: begin//movn
                if (B != 0) begin
                ALUResult = A;
                end
                end
           6'b011000: begin //mult operation
                      {HiOut, LoOut} <=  A*B;
                     writeHiLo=1;
                     end
           6'b011001:  begin // madd
            writeHiLo = 1;
            SA = A;
            SB = B;
            ALU64 = (SA*SB);
            ALUResult = 0;
           {HiOut, LoOut} <= {HiIn, LoIn} + ALU64;
           end
           6'b011010:  begin // msub
           writeHiLo = 1;
           SA = A;
           SB = B;
           ALU64 = (SA*SB);
           ALUResult = 0;
          {HiOut, LoOut} <= {HiIn, LoIn} - ALU64;
          end
          6'b011011: begin // rotrv
          ALUResult = (B >> A) | (B << (32-A));
              end
          6'b011100: //seb
          begin
            if(B[7]==1'b0)  ALUResult = {24'b000000000000000000000000,B[7:0]};
            else  ALUResult = {24'b111111111111111111111111,B[7:0]};
          end

          6'b011101: //seh
          begin
            if(B[15]==1'b0)  ALUResult = {16'b0000000000000000,B[15:0]};
            else  ALUResult = {16'b1111111111111111,B[15:0]};
             end
          6'b011110:begin //bgez
          SA=A;
          ALUResult =0;
          if( SA < 0) ALUResult =1;
          end
          6'b011111: // We dont know
          begin
               if ((0 || A) < (0 || B)) ALUResult=1;
               else ALUResult =0;
               end 
          6'b100000: //bltz
           begin 
           SA = A;
           if(SA < 0)
           ALUResult = 0;
                end
                
            
          6'b100001: begin //bgtz 
            SA = A;
          if(SA > 0 )
          ALUResult = 0;
           end
           6'b100010: //blez
             begin 
             SA = A;
             if(SA < 0 || SA == 0)
                ALUResult = 0;
                 end
            6'b110000: //lui
              begin 
                   ALUResult = B << 16;
                   end
           endcase
           
           end
           assign Zero = (ALUResult == 0)? 1:0;

endmodule

