//------------------------------------------------------------------------
// Test Bench for Load Word Hazard Look Up Table
//------------------------------------------------------------------------

`timescale 1 ns / 1 ps
`include "lwhazard.v"

module testlwhazard();

    reg  [4:0]  ex_rs, ex_rt, id_rs, id_rt;
    reg         clk;
    reg         MemToReg_EX;
    wire        StallF, StallD, FlushE;

    lwHazard lwhaz(.ex_rs(ex_rs),
                  .ex_rt(ex_rt),
                  .id_rs(id_rs),
                  .id_rt(id_rt),
                  .clk(clk),
                  .MemToReg_EX(MemToReg_EX),
                  .StallF(StallF),
                  .StallD(StallD),
                  .FlushE(FlushE));

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
        $display("--------------------------------------------------");
        $display("Instruction LW Hazard tests starting...");

        // Test 1: True 1
        $display("Testing True 1...");
        ex_rt=5'b00001; id_rs=5'b00001; id_rt=5'b00001; MemToReg_EX=1; #1000
        if(StallF != 1'b0)
            $display("error with Test 1 StallF; Expected: 0, Got: %d", StallF);
        if(StallD != 1'b0)
            $display("error with Test 1 StallD; Expected: 0, Got: %d", StallD);
        if(FlushE != 1'b1)
            $display("error with Test 1 FlushE; Expected: 1, Got: %d", FlushE);

        // Test 2: True 2
        $display("Testing True 2...");
        ex_rt=5'b00001; id_rs=5'b00001; id_rt=5'b00000; MemToReg_EX=1; #1000
        if(StallF != 1'b0)
            $display("error with Test 2 StallF; Expected: 0, Got: %d", StallF);
        if(StallD != 1'b0)
            $display("error with Test 2 StallD; Expected: 0, Got: %d", StallD);
        if(FlushE != 1'b1)
            $display("error with Test 2 FlushE; Expected: 1, Got: %d", FlushE);

        // Test 3: True 3
        $display("Testing True 3...");
        ex_rt=5'b00001; id_rs=5'b00000; id_rt=5'b00001; MemToReg_EX=1; #1000
        if(StallF != 1'b0)
            $display("error with Test 3 StallF; Expected: 0, Got: %d", StallF);
        if(StallD != 1'b0)
            $display("error with Test 3 StallD; Expected: 0, Got: %d", StallD);
        if(FlushE != 1'b1)
            $display("error with Test 3 FlushE; Expected: 1, Got: %d", FlushE);

        // Test 4: False 1
        $display("Testing False 1...");
        ex_rt=5'b00001; id_rs=5'b00000; id_rt=5'b00000; MemToReg_EX=1; #1000
        if(StallF != 1'b1)
            $display("error with Test 4 StallF; Expected: 0, Got: %d", StallF);
        if(StallD != 1'b1)
            $display("error with Test 4 StallD; Expected: 0, Got: %d", StallD);
        if(FlushE != 1'b0)
            $display("error with Test 4 FlushE; Expected: 1, Got: %d", FlushE);

        // Test 5: False 2
        $display("Testing False 3...");
        ex_rt=5'b00001; id_rs=5'b00001; id_rt=5'b00001; MemToReg_EX=0; #1000
        if(StallF != 1'b1)
            $display("error with Test 5 StallF; Expected: 0, Got: %d", StallF);
        if(StallD != 1'b1)
            $display("error with Test 5 StallD; Expected: 0, Got: %d", StallD);
        if(FlushE != 1'b0)
            $display("error with Test 5 FlushE; Expected: 1, Got: %d", FlushE);

        $display("Instruction LW Hazard tests done!!");
        $display("--------------------------------------------------");
        $finish;
    end
endmodule
