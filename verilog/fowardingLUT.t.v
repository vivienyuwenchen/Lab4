//------------------------------------------------------------------------
// Test Bench for Behavioral Fowarding Look Up Table
//------------------------------------------------------------------------

`timescale 1 ns / 1 ps
`include "forwardingLUT.v"

module testfowardinglut();

	reg  [4:0]  ex_rs, ex_rt, mem_regRd, wb_regRd, rs, rt;
    reg         mem_regWrite, wb_regWrite;
    wire [1:0]  forwardA, forwardB;

	forwardingLUT forwardingLUT(.ex_rs(ex_rs),
					.ex_rt(ex_rt),
					.mem_regRd(mem_regRd),
					.wb_regRd(wb_regRd),
					.rs(rs),
					.rt(rt),
					.mem_regWrite(mem_regWrite),
					.wb_regWrite(wb_regWrite),
					.forwardA(forwardA),
					.forwardB(forwardB));

    initial begin
        $display("--------------------------------------------------");
        $display("Forwarding LUT tests starting...");

        // Test 1:
        $display("Testing 1...");
        ex_rs=5'b10011; ex_rt=5'b10011; mem_regRd=5'b10011;
        wb_regRd=5'b10011; rs=5'b10011; rt=5'b10011;
        mem_regWrite=1; wb_regWrite=0; #1000
        if(forwardA != 2'b10)
            $display("error with test:1 forwardA; Expected: 10, Got: %d", forwardA);
        if(forwardB != 2'b10)
            $display("error with test:1 forwardB; Expected: 10, Got: %d", forwardB);

        // Test 2:
        $display("Testing 2...");
        ex_rs=5'b10011; ex_rt=5'b10001; mem_regRd=5'b00000;
        wb_regRd=5'b10011; rs=5'b10011; rt=5'b10011;
        mem_regWrite=0; wb_regWrite=1; #1000
        if(forwardA != 2'b01)
            $display("error with test:2 forwardA; Expected: 01, Got: %d", forwardA);
        if(forwardB != 2'b01)
            $display("error with test:2 forwardB; Expected: 01, Got: %d", forwardB);

        // Test 3:
        $display("Testing 3...");
        ex_rs=5'b10011; ex_rt=5'b10001; mem_regRd=5'b00000;
        wb_regRd=5'b10011; rs=5'b10011; rt=5'b10011;
        mem_regWrite=0; wb_regWrite=0; #1000
        if(forwardA != 2'b00)
            $display("error with test:3 forwardA; Expected: 00, Got: %d", forwardA);
        if(forwardB != 2'b00)
            $display("error with test:3 forwardB; Expected: 00, Got: %d", forwardB);



        $display("Done Testing");
    end
endmodule // testfowardinglut
