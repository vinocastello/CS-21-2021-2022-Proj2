`include "mips.sv"
`include "imem.sv"
`include "dmem.sv"
`include "adder.sv"
`include "alu.sv"
`include "aludec.sv"
`include "controller.sv"
`include "datapath.sv"
`include "flopr.sv"
`include "maindec.sv"
`include "mux2.sv"
`include "regfile.sv"
`include "signext.sv"
`include "sl2.sv"
`include "mux4.sv"
`include "shiftleft.sv"
`include "zeroext.sv"

`timescale 1ns / 1ps
module top(input  logic        clk, reset, 
           output logic [31:0] writedata, dataadr, 
           output logic        memwrite);

  logic [31:0] pc, instr, readdata;
  
  // instantiate processor and memories
  mips mips(clk, reset, pc, instr, memwrite, dataadr, 
            writedata, readdata);
  imem imem(pc[7:2], instr);
  dmem dmem(clk, memwrite, dataadr, writedata, readdata);
endmodule