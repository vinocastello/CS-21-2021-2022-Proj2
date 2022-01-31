////////////
`timescale 1ns / 1ps
module datapath(input  logic        clk, reset,
                input  logic        memtoreg, pcsrc,
                input  logic        regdst,
                input  logic        regwrite, jump,
                input  logic [1:0]  alusrc,
                input  logic [3:0]  alucontrol,
                output logic        zero, lessthan,
                output logic [31:0] pc,
                input  logic [31:0] instr,
                output logic [31:0] aluout, writedata,
                input  logic [31:0] readdata);

  logic [4:0]  writereg;
  logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
  logic [31:0] signimm, signimmsh;
  logic [31:0] srca, srcb;
  logic [31:0] result;
  logic [4:0]  shamt;
  assign shamt = instr[10:6];
  logic [31:0] shiftedforlui;
  logic [31:0] zeroextended;
  // next PC logic
  flopr #(32) pcreg(clk, reset, pcnext, pc);
  adder #(32) pcadd1(pc, 32'b100, 'b0, pcplus4); //So we adjust this to use the more complex adder; wmt-modification
  sl2         immsh(signimm, signimmsh);
  adder #(32) pcadd2(pcplus4, signimmsh, 'b0, pcbranch); //See comment above
  mux2 #(32)  pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
  mux2 #(32)  pcmux(pcnextbr, {pcplus4[31:28], 
                    instr[25:0], 2'b00}, jump, pcnext);

  // register file logic
  regfile     rf(clk, regwrite, instr[25:21], instr[20:16], 
                 writereg, result, srca, writedata);
  mux2 #(5)   wrmux(instr[20:16], instr[15:11],
                    regdst, writereg);
  mux2 #(32)  resmux(aluout, readdata, memtoreg, result);
  signext     se(instr[15:0], signimm);

  // ALU logic
  zeroext     zeroxtender(instr[15:0],zeroextended);
  shiftleft   luishifter(instr[15:0],shiftedforlui);
  mux4 #(32)  srcbmux(writedata, signimm, shiftedforlui,zeroextended, alusrc, srcb);
  alu         alu(srca, srcb, alucontrol,shamt, aluout, zero, lessthan);
endmodule