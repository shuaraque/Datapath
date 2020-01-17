`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//Team Members:  Sabrina Huaraque, John Irene Izere, Majed Almodhabri  
// % Effort    : Sabrina 33.33% , John 33.33%, Majed 33.33%
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

  /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;   //using always @
    //output [31:0] out;   //using assign statement
    
    /* Fill in the implementation here ... */
    always @ (in) begin
        if (in[15] == 0) begin
            out = 32'h0;
            out[15:0] = in;
        end
        else begin
            out[31:16] = 16'b1111111111111111;
            out[15:0] = in;
        end
    end
	

endmodule
