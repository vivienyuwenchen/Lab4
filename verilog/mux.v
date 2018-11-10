//-----------------------------------------------------------------------------
// Multiplexers
//-----------------------------------------------------------------------------

// Two-input MUX with parameterized bit width (default: 1-bit)
module mux2 #( parameter W = 32 )
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule
