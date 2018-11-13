//-----------------------------------------------------------------------------
// Multiplexers
//-----------------------------------------------------------------------------

// 4 input MUX with parameterized bit width (default: 1-bit)

module mux4 #( parameter W = 32 )
      (
      input [W-1:0] in0,                 // 4-bit input called a
      input [W-1:0] in1,                 // 4-bit input called b
      input [W-1:0] in2,                 // 4-bit input called c
      input [W-1:0] in3,                 // 4-bit input called d
      input [1:0] sel,               // input sel used to select between a,b,c,d
      output [W-1:0] out);             // 4-bit output based on input sel

  // When sel[1] is 0, (sel[0]? b:a) is selected and when sel[1] is 1, (sel[0] ? d:c) is taken
  // When sel[0] is 0, a is sent to output, else b and when sel[0] is 0, c is sent to output, else d
  assign out = sel[1] ? (sel[0] ? in3 : in2) : (sel[0] ? in1 : in0);

endmodule
