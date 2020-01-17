`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ECE 369 
// Engineer: Majed almodhabri, John Palanca, Sabrina Huaraque
// effort    Majed 33%,         John 33%      Sabrina 33%     
//////////////////////////////////////////////////////////////////////////////////

module DatapathTop(rst,clkin, PC, WriteData, Hi, Lo);

  input clkin, rst;
	output reg [31:0] PC, WriteData, Hi, Lo;
  
  // WIRES HERE //
  
  wire [31:0] PC_MuxResult,  PCAddResult,  Address, PCJump, BranchAddress,  
  BranchAddressE, JRData, PCResult, Instruction,PCAdderResult,InstructionD,PCAdderD,
   ALUResultM, ReadData1, ReadData2, DataToBeWritten, RegWriteData, ReadData2M,  
  SignExtendD, ZeroExtendD, Bit5ExtendD, SignExtendE, ZeroExtendE, Bit5ExtendE,
  PCD, PCPlus8, PCE, ExtendResult16Bit, Immediate, ImmediateShefted, ALUResultW,
  ALUa, ForwardM, ForwardW, BMux, HiResult, LoResult, ALUb, HiOut, LoOut, ALUResultE,
  ReadData1E, ReadData2E, memDataM, memDataW, outbh;
  
  
  wire [14:0] EX;
  
  
  wire [4:0] MemD, MemE, RegDstM, RegDstW, RegToBeWritten, rs25to21E, rt20to16E, rd15to11E, RegDstE;
  
  wire [5:0] ALUsrc;
   
  wire [5:0] ALUop;
  
  wire [1:0] JumpSel, WBD,WBM, WBE,ASel, lbSel;
  wire [2:0] BSel;
 
  
  wire PCSrc, PCWrite, FDWrite, CtrlMux, memReadM, rstE, jrDataSel, SignExSel, zeroM, zeroE, ALUbMux,
  MemWrite, MemRead, Branch, JALRegWrite, writeHilo, RegWriteW, RegWrite, Mux31, RegDstSel, BitExSel,
  rstctrlFD, rstFD, MemtoReg;
  
  //START HERE //
  
  ////////////////////////////////////// FETCH UNIT //////////////////////////////////////////////////
  
  //PC_Mux decides between the normal PCAddResult and a Branch Address. 
  //This is decided by PCSrc is decided by an and function bewtween "Branch" and a Zero Output from the ALU
  Mux32Bit2To1 PC_MUX(PC_MuxResult, PCAdderResult, BranchAddress, PCSrc); 
  
  //chose between normal insts(branch/pc+4) and jumps(jr, jal/j). note that jal and j are the same output
  Mux32Bit3to1 JumpInstMux(Address, PC_MuxResult, PCJump, JRData, JumpSel);
  
  //program counter
  ProgramCounter PCCounter(Address, PCResult, PCWrite, rst, clkin);
  
  //instructionMemory: Stores Instructions and outputs the current instruction being imputted
  InstructionMemory instMem(PCResult[11:2], Instruction);
  
  //PCAdder : Adds 4 (1 byte) to the current PCResult
  PCAdder pcadder(PCResult, PCAdderResult);
  //OR(A, B, out);
  OR FDrst(rst, rstctrlFD,  rstFD);
  /****************************************************************************************************/
  //Pipelines the Instructions and PCAdderResult
  FtoD FtoD(clkin, rst, FDWrite, Instruction, PCAdderResult, InstructionD, PCD);
  
  //////////////////////////////////// DECODE UNIT ///////////////////////////////
  
  // PCJump = (PCAdderD[31:28] <<28) + Instruction[28:0]. basically set the Adress for j and jal
  jump SetJump(InstructionD, PCD[31:28], PCJump);
	
  //Stall the pipeLine in case there is data hazard
  hazard hazardDetect(InstructionD, rd15to11E, rt20to16E, WBE[0], MemE[1], RegDstM, MemRead, PCWrite, FDWrite, CtrlMux, rstctrlFD, MemD[0], MemE[0], Branch);
    
  //forward form M to D >>
  forwardD ForwardMtoD(InstructionD[31:26], InstructionD[5:0], RegDstM, InstructionD[25:21], jrDataSel);
    
  //mux to forward from M to D for jr
  Mux32Bit2To1 jrForward(JRData, ReadData1, ALUResultM, jrDataSel);
	
  //The Controller Sends Out Signals To the Pipeline
  controller ctrl(InstructionD, EX, WBD, MemD, JALRegWrite, JumpSel, Mux31);
  
  //This Or determines whether it will write from the Jump and Link or if it will be writing from the WriteBack Stage
  OR OrForJAL(JALRegWrite, RegWriteW, RegWrite);
  //Chose between reg31 or RegDstW
  SimpleMux31Reg mux31(RegToBeWritten, RegDstW, JALRegWrite);
  // Add 4 to PCD
  PCAdder PCDPlus8(PCD, PCPlus8);
   
  //chose btween pc+8(for jal) and date from WB mux
  Mux32Bit2To1 SelData2_PC8_WB(DataToBeWritten, RegWriteData, PCPlus8, JALRegWrite);
  
 //RegisterFile Reads and Writes Data into and out of registers
 //RegisterFile(Clk, RegWrite, WriteData, ReadRegister1, ReadRegister2, WriteRegister, ReadData1, ReadData2);
  RegisterFile regs(clkin, RegWrite, DataToBeWritten, InstructionD[25:21], InstructionD[20:16], RegToBeWritten, ReadData1, ReadData2);
  
  /////////Extenders for 16 bit (Signed and Unisigned) and 5 Bit//////
  SignExtension  Bit16extend(InstructionD[15:0], SignExtendD); //
  ZeroExtend Zeroextend16Bit(InstructionD[15:0], ZeroExtendD); //
  Signextend5to32 Bit5Extend(InstructionD[10:6], Bit5ExtendD); //
  ////////////////////////////////////////////////////////////////////
  
  // In case there is data hazard, zero DtoE pipe, use or with rst and ctrlMux
  OR zeroPipelineOr(rst, CtrlMux, rstE);
  
    /****************************************************************************************************/
  //Pipelines the Instructions and PCAdderResult
  DtoE DtoE(clkin, rstE, WBD, MemD, EX, PCD, ReadData1, ReadData2, SignExtendD, ZeroExtendD, Bit5ExtendD,InstructionD[25:21],
   InstructionD[20:16], InstructionD[15:11], 
  WBE, MemE, ALUop, RegDstSel, SignExSel, BitExSel, ALUsrc, PCE, ReadData1E, ReadData2E, SignExtendE,
   ZeroExtendE, Bit5ExtendE, rs25to21E, rt20to16E, rd15to11E);
  
/////////////////////////////////////// EXE UNIT ////////////////////////////////////////////

	///////////////////////////// Immediate Value Mux /////////////////////////////////////////////////////
  Mux32Bit2To1 ExtendMux(ExtendResult16Bit, SignExtendE, ZeroExtendE, SignExSel);						 //
  Mux32Bit2To1 SignExDst(Immediate, ExtendResult16Bit, Bit5ExtendE, BitExSel);      				     //
  ////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  ///////////////////////////A L U and ALU Muxes///////////////////////////////////////////////////////////////
  Mux32Bit4To1 A(ALUa, ReadData1E, ReadData2E, ALUResultM, RegWriteData, ASel);								 //					    			 //
  Mux32Bit6To1 bMux(BMux, ReadData2E, HiResult, LoResult, ALUResultM, RegWriteData, BSel);  			 //
  Mux32Bit2To1 B(ALUb, BMux, Immediate, ALUbMux);															 //												 			 //
  ALU32Bit alu(ALUop, ALUa,ALUb ,HiOut, LoOut, ALUResultE, HiResult, LoResult, writeHilo, zeroE);      		 //
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  // HiLoReg(clk, HiIn,LoIn, write, HiOut, LoOut);
  HiLoReg hilo(clkin,HiResult, LoResult, writeHilo,  HiOut, LoOut);
  
  
  // forwardEX(ALUsrc, regWriteM, regWriteWB, DstRegM, DstRegWB, RsE, RtE, ASel, BSel, ALUbMux);
  forwardEX MandWBtoEX(ALUsrc,WBM[0], RegWriteW, RegDstM, RegDstW, rs25to21E, rt20to16E, ASel, BSel, ALUbMux );
  
  
  ////////////////////////////  B r a n c h e s ////////////////////////////////////////////
  sheftLeft2 branchAddress(Immediate, ImmediateShefted);									//
  simpleAdder branchTo(ImmediateShefted, PCE,  BranchAddressE);											//
 //////////////////////////////////////////////////////////////////////////////////////////
 // sellecting the destanation register
  Mux5Bit2To1 DstReg(RegDstE, rd15to11E, rt20to16E, RegDstSel);	



/******************************************************************************************/
  EtooM EM(clkin, rst, WBE, MemE, BranchAddressE, zeroE, ALUResultE, BMux, RegDstE,
             WBM, MemWrite, MemRead, Branch, BranchAddress, zeroM, ALUResultM, ReadData2M, RegDstM, lbSel);

///////////////////////////////////////// Data Memory Unite ///////////////////////////////
  
  //PCSrc = Branch && zeroM;
  And ab(Branch, zeroM, PCSrc);
  //dataMemory  DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData);
  DataMemory mem(ALUResultM[11:2], ReadData2M, clkin, MemWrite, MemRead, memDataM, lbSel);
  
  // bytExtndWithSel (in, out, sel);
  //bytExtndWithSel bh(memDataM, outbh, lbSel);

/**********************************************************************************************/
  MtoW MW(clkin, rst, WBM, memDataM, ALUResultM, RegDstM, RegWriteW, MemtoReg, memDataW, ALUResultW, RegDstW);
//////////////////////////////////////// WB unite ////////////////////////////////////////////
// WB mux
  Mux32Bit2To1 SelData(RegWriteData, memDataW, ALUResultW, MemtoReg);

  always @ (posedge clkin) begin
   PC <= PCAdderResult;
   WriteData <= DataToBeWritten;
   Hi<=HiOut;
   Lo <= LoOut;
  end

endmodule
  