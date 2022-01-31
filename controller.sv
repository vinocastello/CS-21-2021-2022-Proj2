`timescale 1ns / 1ps
module controller(input  logic [5:0] op, funct,
                  input  logic       zero, lessthan,
                  output logic       memtoreg, memwrite,
                  output logic       pcsrc,
                  output logic [1:0] alusrc,
                  output logic       regdst, regwrite,
                  output logic       jump,
                  output logic [3:0] alucontrol);

  logic [2:0] aluop;
  logic       branch, blt;

  maindec md(op, memtoreg, memwrite, branch,blt,
             alusrc, regdst, regwrite, jump, aluop);
  aludec  ad(funct, aluop, alucontrol);

  assign pcsrc = (branch & zero)|(blt & lessthan);
endmodule