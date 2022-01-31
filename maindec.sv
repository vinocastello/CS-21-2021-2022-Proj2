`timescale 1ns / 1ps
module maindec(input  logic [5:0] op,
               output logic       memtoreg, memwrite,
               output logic       branch, blt,
               output logic [1:0] alusrc,
               output logic       regdst, regwrite,
               output logic       jump,
               output logic [2:0] aluop);

  logic [11:0] controls;

  assign {regwrite, regdst, alusrc, branch, blt, memwrite,
          memtoreg, jump, aluop} = controls;

  always_comb
    case(op)
      6'b000000: controls <= 12'b110000000010; // RTYPE
      6'b100011: controls <= 12'b100100010000; // LW
      6'b101011: controls <= 12'b0x01001x0000; // SW
      6'b000100: controls <= 12'b0x00100x0001; // BEQ
      6'b001000: controls <= 12'b100100000000; // ADDI
      6'b000010: controls <= 12'b0xxxx00x1xxx; // J
      6'b001111: controls <= 12'b101000000100; // lui
      6'b010001: controls <= 12'b101100000100; // li
      6'b011111: controls <= 12'b0x00010x0011; // blt
      default:   controls <= 12'bxxxxxxxxxxxx; // illegal op
    endcase
endmodule