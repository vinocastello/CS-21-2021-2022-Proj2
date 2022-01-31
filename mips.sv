`timescale 1ns / 1ps
module mips(input  logic        clk, reset,
            output logic [31:0] pc,
            input  logic [31:0] instr,
            output logic        memwrite,
            output logic [31:0] aluout, writedata,
            input  logic [31:0] readdata);

  logic       memtoreg, regdst, 
              regwrite, jump, pcsrc, zero,lessthan;
  logic [1:0] alusrc;
  logic [3:0] alucontrol;

  controller c(instr[31:26], instr[5:0], zero, lessthan,
               memtoreg, memwrite, pcsrc,
               alusrc, regdst, regwrite, jump,
               alucontrol);
  datapath dp(clk, reset, memtoreg, pcsrc,
              regdst, regwrite, jump, alusrc,
              alucontrol,
              zero,lessthan, pc, instr,
              aluout, writedata, readdata);
endmodule