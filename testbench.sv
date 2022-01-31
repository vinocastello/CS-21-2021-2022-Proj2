// CS 21 A2 -- S2 AY 2020-2021
// Hans Gabriel H. De Castro -- 06/27/2021
// testbench.sv -- testbench file for Project

`timescale 1ns / 1ps
module testbench();

  logic        clk;
  logic        reset;

  logic [31:0] writedata, dataadr;
  logic        memwrite;

  // instantiate device to be tested
  top dut(clk, reset, writedata, dataadr, memwrite);
  
  // initialize test
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    begin
      if(memwrite) begin
        if(dataadr === 4 & writedata === 'hf00d0000) begin
          $display("simulation successful");
          $stop;
        end else if (dataadr !== 4) begin
          $display("lw / sw failed");
          $stop;
        end
      end
    end
endmodule