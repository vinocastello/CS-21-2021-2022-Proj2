module alu(input  logic [31:0] a, b,
           input  logic [3:0]  alucontrol,
           input  logic [4:0]  shamt,
           output logic [31:0] result,
           output logic        zero,lessthan);
  
  logic [31:0] condinvb, sum;

  assign condinvb = alucontrol[3] ? ~b : b;
  assign sum = a + condinvb + alucontrol[3];
 
  always_comb
    case (alucontrol[2:0])
      3'b000: result = a & b;    			// and
      3'b001: result = a | b;    			// or
      3'b010: result = sum;					// add or sub
      3'b011: result = sum[31];  			// slt
      3'b100: result = b << shamt; 			// sll
      3'b101: result = {a[31:16],b[15:0]};  // mix
      3'b110: result = b;                   // lui or li
      3'b111: result = ~(a | b); 			// nor
    endcase

  assign zero = (result == 32'b0);
  assign lessthan = (result == 'h00000001); // res = 1 when slt is true
endmodule