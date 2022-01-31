module shiftleft(input  logic [15:0] a,
                 output logic [31:0] shiftedforlui);
              
//   assign shiftedforlui = {a,{16{'b0}}};
  assign shiftedforlui = a << 16;
endmodule