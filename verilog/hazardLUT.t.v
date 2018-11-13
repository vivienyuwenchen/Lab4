//------------------------------------------------------------------------
// Test Bench for Hazard Look Up Table
//------------------------------------------------------------------------
`timescale 1 ns / 1 ps
`include "hazardLUT.v"

module testhazardlut();

	reg  [5:0]  OP,FUNCT;
    reg         zero, overflow;
    wire [2:0]  ALUctrl;
    wire        RegDst, RegWr, MemWr, MemToReg, ALUsrc, IsJump, IsJAL;
    wire        IsJR, IsBranch, pcEnable, controlLUT0, if_Idreg;

	instructionLUT instructionLUT(.OP(OP),
                    .FUNCT(FUNCT),
                    .zero(zero),
                    .overflow(overflow),
                    .RegDst(RegDst),
                    .RegWr(RegWr),
                    .MemWr(MemWr),
                    .MemToReg(MemToReg),
                    .ALUctrl(ALUctrl),
                    .ALUsrc(ALUsrc),
                    .IsJump(IsJump),
                    .IsJAL(IsJAL),
                    .IsJR(IsJR),
                    .IsBranch(IsBranch),
                    .pcEnable(pcEnable),
                    .controlLUT0(controlLUT0),
                    .if_Idreg(if_Idreg));


    initial begin
        $display("--------------------------------------------------");
        $display("Hazard LUT tests starting...");

        // Test 1:J
        $display("Testing 1:J...");
        OP=6'b000010; #1000
        if(pcEnable != 0)
            $display("error with test1:J pcEnable; Expected: 0, Got: %d", pcEnable);
        if(controlLUT0 != 0)
            $display("error with test1:J controlLUT0; Expected: 0, Got: %d", controlLUT0);
        if(if_Idreg != 0)
            $display("error with test1:J if_Idreg; Expected: 0, Got: %d", if_Idreg);

        // Test 2:JAL
        $display("Testing 2:JAL...");
        OP=6'b000011; #1000
        if(pcEnable != 0)
            $display("error with test2:JAL pcEnable; Expected: 0, Got: %d", pcEnable);
        if(controlLUT0 != 0)
            $display("error with test2:JAL controlLUT0; Expected: 0, Got: %d", controlLUT0);
        if(if_Idreg != 0)
            $display("error with test2:JAL if_Idreg; Expected: 0, Got: %d", if_Idreg);

        // Test 3:BEQ
        $display("Testing 3:BEQ...");
        OP=6'b000100; #1000
        if(pcEnable != 0)
            $display("error with test3:BEQ pcEnable; Expected: 0, Got: %d", pcEnable);
        if(controlLUT0 != 0)
            $display("error with test3:BEQ controlLUT0; Expected: 0, Got: %d", controlLUT0);
        if(if_Idreg != 0)
            $display("error with test3:BEQ if_Idreg; Expected: 0, Got: %d", if_Idreg);

        // Test 4:BNE
        $display("Testing 4:BNE...");
        OP=6'b000101; #1000
        if(pcEnable != 0)
            $display("error with test4:BNE pcEnable; Expected: 0, Got: %d", pcEnable);
        if(controlLUT0 != 0)
            $display("error with test4:BNE controlLUT0; Expected: 0, Got: %d", controlLUT0);
        if(if_Idreg != 0)
            $display("error with test4:BNE if_Idreg; Expected: 0, Got: %d", if_Idreg);

        // Test 5:JR
        $display("Testing 5:JR...");
        OP=6'b000000; FUNCT=6'b001000; #1000
        if(pcEnable != 0)
            $display("error with test5:JR pcEnable; Expected: 0, Got: %d", pcEnable);
        if(controlLUT0 != 0)
            $display("error with test5:JR controlLUT0; Expected: 0, Got: %d", controlLUT0);
        if(if_Idreg != 0)
            $display("error with test5:JR if_Idreg; Expected: 0, Got: %d", if_Idreg);

        // Test 6:LW
        $display("Testing 6:LW...");
        OP=6'b100011; #1000
        if(pcEnable != 1)
            $display("error with test6:LW pcEnable; Expected: 1, Got: %d", pcEnable);
        if(controlLUT0 != 1)
            $display("error with test6:LW controlLUT0; Expected: 1, Got: %d", controlLUT0);
        if(if_Idreg != 1)
            $display("error with test6:LW if_Idreg; Expected: 1, Got: %d", if_Idreg);

        // Test 7:ADD
        $display("Testing 7:ADD...");
        OP=6'b000000; FUNCT=6'b100000; #1000
        if(pcEnable != 1)
            $display("error with test7:ADD pcEnable; Expected: 1, Got: %d", pcEnable);
        if(controlLUT0 != 1)
            $display("error with test7:ADD controlLUT0; Expected: 1, Got: %d", controlLUT0);
        if(if_Idreg != 1)
            $display("error with test7:ADD if_Idreg; Expected: 1, Got: %d", if_Idreg);


        $display("Testing Complete");
    end
endmodule // testfowardinglut