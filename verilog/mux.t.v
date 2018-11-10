//------------------------------------------------------------------------
// Test bench for Multiplexers
//------------------------------------------------------------------------

`include "mux.v"

module testMUX2();

    reg [31:0] in0;
    reg [31:0] in1;
    reg sel;
    wire [31:0] out;

    mux2 #(32) dut(.in0(in0),
                .in1(in1),
			    .sel(sel),
			    .out(out));

    initial begin
        $display("Testing MUX2...");
        in0=32'hAAAAAAAA; in1=32'hBBBBBBBB; sel=1'b0; #1000
        if(out != 32'hAAAAAAAA)
            $display("ERROR Expected: AAAAAAAA, Got: %h", out);
        in0=32'hAAAAAAAA; in1=32'hBBBBBBBB; sel=1'b1; #1000
        if(out != 32'hBBBBBBBB)
            $display("ERROR Expected: BBBBBBBB, Got: %h", out);
        $display("Done with MUX2!");
    end
endmodule
