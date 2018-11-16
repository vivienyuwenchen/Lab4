//------------------------------------------------------------------------
// Test Bench for Behavioral Fowarding Look Up Table
//------------------------------------------------------------------------

`timescale 1 ns / 1 ps
`include "forwardingLUT.v"

module testfowardinglut();

	reg  [4:0]  ex_rs, ex_rt, mem_regAw, wb_regAw;
    reg         mem_regWrite, wb_regWrite;
    wire [1:0]  forwardA, forwardB;

	forwardingLUT forwardingLUT(.ex_rs(ex_rs),
					.ex_rt(ex_rt),
					.mem_regAw(mem_regAw),
					.wb_regAw(wb_regAw),
					.mem_regWrite(mem_regWrite),
					.wb_regWrite(wb_regWrite),
					.forwardA(forwardA),
					.forwardB(forwardB));

    initial begin
        $display("--------------------------------------------------");
        $display("Forwarding LUT tests starting...");

        // Test 1:
        $display("Testing 1...");
        ex_rs=5'b10011; ex_rt=5'b10011; mem_regAw=5'b10011; wb_regAw=5'b10011;
        mem_regWrite=1; wb_regWrite=0; #1000
        if(forwardA != 2'b10)
            $display("error with test:1 forwardA; Expected: 10, Got: %b", forwardA);
        if(forwardB != 2'b10)
            $display("error with test:1 forwardB; Expected: 10, Got: %b", forwardB);

        // Test 2:
        $display("Testing 2...");
        ex_rs=5'b10011; ex_rt=5'b10011; mem_regAw=5'b00000; wb_regAw=5'b10011;
        mem_regWrite=0; wb_regWrite=1; #1000
        if(forwardA != 2'b01)
            $display("error with test:2 forwardA; Expected: 01, Got: %b", forwardA);
        if(forwardB != 2'b01)
            $display("error with test:2 forwardB; Expected: 01, Got: %b", forwardB);

        // Test 3:
        $display("Testing 3...");
        ex_rs=5'b10011; ex_rt=5'b10001; mem_regAw=5'b00000; wb_regAw=5'b10011;
        mem_regWrite=0; wb_regWrite=0; #1000
        if(forwardA != 2'b00)
            $display("error with test:3 forwardA; Expected: 00, Got: %b", forwardA);
        if(forwardB != 2'b00)
            $display("error with test:3 forwardB; Expected: 00, Got: %b", forwardB);

        $display("Forwarding LUT tests done!!");
        $display("--------------------------------------------------");
    end
endmodule
