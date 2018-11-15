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
    input sel,
    input in0, in1, in2, in3, in4, in5, in6,
    input [2:0] in7,
    // input [31:0] inR0, inR1, inR2, inR3,
    // input [4:0] inR4, inR5, inR6,
    // input [25:0] inR7,
    // input [15:0] inR8,
    output out0, out1, out2, out3, out4, out5, out6,
    output [2:0] out7
    // output [31:0] outR0, outR1, outR2, outR3,
    // output [4:0] outR4, outR5, outR6,
    // output [25:0] outR7,
    // output [15:0] outR8
);

    mux2 #(1) mux0(.in0(in0),
                    .in1(1'b0),
                    .sel(sel),
                    .out(out0));

    mux2 #(1) mux1(.in0(in1),
                    .in1(1'b0),
                    .sel(sel),
                    .out(out1));

    mux2 #(1) mux2_(.in0(in2),
                    .in1(1'b0),
                    .sel(sel),
                    .out(out2));

    mux2 #(1) mux3(.in0(in3),
                    .in1(1'b0),
                    .sel(sel),
                    .out(out3));

    mux2 #(1) mux4(.in0(in4),
                    .in1(1'b0),
                    .sel(sel),
                    .out(out4));

    mux2 #(1) mux5(.in0(in5),
                    .in1(1'b0),
                    .sel(sel),
                    .out(out5));

    mux2 #(1) mux6(.in0(in6),
                    .in1(1'b0),
                    .sel(sel),
                    .out(out6));

    mux2 #(3) mux7(.in0(in7),
                    .in1(3'b000),
                    .sel(sel),
                    .out(out7));
    //
    // mux2 #(32) muxR0(.in0(inR0),
    //                 .in1(32'h00000000),
    //                 .sel(sel),
    //                 .out(outR0));
    //
    // mux2 #(32) muxR1(.in0(inR1),
    //                 .in1(32'h00000000),
    //                 .sel(sel),
    //                 .out(outR1));
    //
    // mux2 #(32) muxR2(.in0(inR2),
    //                 .in1(32'h00000000),
    //                 .sel(sel),
    //                 .out(outR2));
    //
    // mux2 #(32) muxR3(.in0(inR3),
    //                 .in1(32'h00000000),
    //                 .sel(sel),
    //                 .out(outR3));
    //
    // mux2 #(5) muxR4(.in0(inR4),
    //                 .in1(5'b0),
    //                 .sel(sel),
    //                 .out(outR4));
    //
    // mux2 #(5) muxR5(.in0(inR5),
    //                 .in1(5'b0),
    //                 .sel(sel),
    //                 .out(outR5));
    //
    // mux2 #(5) muxR6(.in0(inR6),
    //                 .in1(5'b0),
    //                 .sel(sel),
    //                 .out(outR6));
    //
    // mux2 #(26) muxR7(.in0(inR7),
    //                 .in1(26'b0),
    //                 .sel(sel),
    //                 .out(outR7));
    //
    // mux2 #(16) muxR8(.in0(inR8),
    //                 .in1(16'b0),
    //                 .sel(sel),
    //                 .out(outR8));

endmodule
