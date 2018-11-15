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

// Flush MUX
module flushmux
(
    input clk,
    input enable,
    input [31:0] dR0, dR1,
    output [31:0] qR0, qR1
);

    dff #(32) dffR0(.clk(clk),
                    .enable(enable),
                    .d(dR0),
                    .q(qR0));

    dff #(32) dffR1(.clk(clk),
                    .enable(enable),
                    .d(dR1),
                    .q(qR1));

endmodule
