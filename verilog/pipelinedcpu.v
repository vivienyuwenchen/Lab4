//------------------------------------------------------------------------
// Pipelined CPU
//------------------------------------------------------------------------

`include "regfile.v"
`include "memory.v"
`include "dff.v"
`include "mux.v"
`include "mux4.v"
`include "alu.v"
`include "instructiondecoder.v"
`include "lut.v"
`include "forwardingLUT.v"
`include "lwhazard.v"

module cpu_h
(
    input clk
);

    // control wires
    wire RegDst_ID, RegWr_ID, MemWr_ID, MemToReg_ID, ALUsrc_ID, IsJump_ID, IsJAL_ID, IsJR_ID, IsBranch_ID;
    wire RegDst_ID_F, RegWr_ID_F, MemWr_ID_F, MemToReg_ID_F, ALUsrc_ID_F, IsJump_ID_F, IsBranch_ID_F;
    wire RegDst_EX, RegWr_EX, MemWr_EX, MemToReg_EX, ALUsrc_EX, IsJump_EX, IsBranch_EX;
    wire RegDst_EX_F, RegWr_EX_F, MemWr_EX_F, MemToReg_EX_F, ALUsrc_EX_F, IsJump_EX_F, IsBranch_EX_F;
    wire RegWr_MEM, MemWr_MEM, MemToReg_MEM, IsJump_MEM, IsBranch_MEM;
    wire RegWr_WB, MemToReg_WB;
    wire [2:0] ALUctrl_ID, ALUctrl_ID_F, ALUctrl_EX, ALUctrl_EX_F;
    // decoder wires
    wire [5:0] OP_ID, FUNCT_ID;
    wire [4:0] RS_ID, RT_ID, RD_ID, SHAMT_ID;
    wire [4:0] RS_EX, RT_EX, RD_EX, RD_MEM, RD_WB;
    wire [15:0] IMM16_ID, IMM16_EX;
    wire [25:0] TA_ID, TA_EX;
    wire [31:0] SE_ID, SE_EX;
    // flag wires
    wire zero_EX, zero_MEM;
    wire overflow_EX, overflow_MEM;
    wire carryout_EX;
    // register wires
    wire [31:0] PCplus4_IF, PCplus4_ID, PCplus4_EX;
    wire [31:0] PCplus4addr_EX, PCplus4addr_MEM;
    wire [31:0] shift2_EX, shift2_MEM;
    wire [31:0] aluout_EX, aluout_MEM, aluout_WB;
    wire [31:0] regDa_ID, regDa_EX;
    wire [31:0] regDb_ID, regDb_EX, regDb_MEM;
    wire [4:0] regAw_EX, regAw_MEM, regAw_WB;
    wire [31:0] memout_MEM, memout_WB;
    wire [31:0] instruction_IF, instruction_ID;
    // IF exclusive wires
    wire [31:0] isbranchout_IF, isjumpout_IF;
    wire [31:0] PCcount_IF;
    // EX exclusive wires
    wire [31:0] alusrcout_EX;
    wire [31:0] jumpaddr_EX, branchaddr_EX;
    wire [1:0] forwardA_EX, forwardB_EX;
    wire [31:0] operandA_EX, operandB_EX;
    // WB exclusive wires
    wire [31:0] regDin_WB;

    //Stall wires
    wire StallF, StallD, FlushE;
    wire [31:0] regDa_ID_F, regDb_ID_F, PCplus4_ID_F, SE_ID_F;
    wire [4:0] RS_ID_F, RT_ID_F, RD_ID_F;
    wire [25:0] TA_ID_F;
    wire [15:0] IMM16_ID_F;

    mux2 #(32) muxisbranch(.in0(PCplus4_IF),
                    .in1(PCplus4addr_MEM),
                    .sel(IsBranch_MEM),
                    .out(isbranchout_IF));

    mux2 #(32) muxisjump(.in0(isbranchout_IF),
                    .in1(shift2_MEM),
                    .sel(IsJump_MEM),
                    .out(isjumpout_IF));

    dff #(32) pccounter(.clk(clk),
                    .enable(StallF),
                    .d(isjumpout_IF),
                    .q(PCcount_IF));

    assign PCplus4_IF = PCcount_IF + 32'h00000004;

    memory mem(.clk(clk),
                    .WrEn(MemWr_MEM),
                    .DataAddr(aluout_MEM),
                    .DataIn(regDb_MEM),
                    .DataOut(memout_MEM),
                    .InstrAddr(PCcount_IF),
                    .Instruction(instruction_IF));

    lwHazard lwhaz(.ex_rs(RS_EX),
                  .ex_rt(RS_EX),
                  .id_rs(RS_ID),
                  .id_rt(RT_ID),
                  .clk(clk),
                  .MemToReg_EX(MemToReg_EX),
                  .StallF(StallF),
                  .StallD(StallD),
                  .FlushE(FlushE));

    // IF/ID Register
    ifid ifidreg(.clk(clk),
                    .enable(StallD),
                    .dR0(PCplus4_IF),
                    .qR0(PCplus4_ID),
                    .dR1(instruction_IF),
                    .qR1(instruction_ID));

    instructiondecoder decoder(.OP(OP_ID),
                    .RT(RT_ID),
                    .RS(RS_ID),
                    .RD(RD_ID),
                    .IMM16(IMM16_ID),
                    .TA(TA_ID),
                    .SHAMT(SHAMT_ID),           // unused
                    .FUNCT(FUNCT_ID),
                    .instruction(instruction_ID));

    instructionLUT lut(.OP(OP_ID),
                    .FUNCT(FUNCT_ID),
                    .zero(zero_MEM),
                    .overflow(overflow_MEM),
                    .RegDst(RegDst_ID),
                    .RegWr(RegWr_ID),
                    .MemWr(MemWr_ID),
                    .MemToReg(MemToReg_ID),
                    .ALUctrl(ALUctrl_ID),
                    .ALUsrc(ALUsrc_ID),
                    .IsJump(IsJump_ID),
                    .IsJAL(IsJAL_ID),           // unused
                    .IsJR(IsJR_ID),             // unused
                    .IsBranch(IsBranch_ID));

    regfile register(.ReadData1(regDa_ID),
                    .ReadData2(regDb_ID),
                    .WriteData(regDin_WB),
                    .ReadRegister1(RS_ID),
                    .ReadRegister2(RT_ID),
                    .WriteRegister(regAw_WB),
                    .RegWrite(RegWr_WB),
                    .Clk(clk));

    assign SE_ID = {{16{IMM16_ID[15]}}, IMM16_ID};

    flushmux flush(.sel(FlushE),
                    .in0(MemToReg_ID),
                    .out0(MemToReg_ID_F),
                    .in1(RegWr_ID),
                    .out1(RegWr_ID_F),
                    .in2(MemWr_ID),
                    .out2(MemWr_ID_F),
                    .in3(IsBranch_ID),
                    .out3(IsBranch_ID_F),
                    .in4(IsJump_ID),
                    .out4(IsJump_ID_F),
                    .in5(ALUsrc_ID),
                    .out5(ALUsrc_ID_F),
                    .in6(RegDst_ID),
                    .out6(RegDst_ID_F),
                    .in7(ALUctrl_ID),
                    .out7(ALUctrl_ID_F));
                    // .inR0(regDa_ID),
                    // .outR0(regDa_ID_F),
                    // .inR1(regDb_ID),
                    // .outR1(regDb_ID_F),
                    // .inR2(PCplus4_ID),
                    // .outR2(PCplus4_ID_F),
                    // .inR3(SE_ID),
                    // .outR3(SE_ID_F),
                    // .inR4(RS_ID),
                    // .outR4(RS_ID_F),
                    // .inR5(RT_ID),
                    // .outR5(RT_ID_F),
                    // .inR6(RD_ID),
                    // .outR6(RD_ID_F),
                    // .inR7(TA_ID),
                    // .outR7(TA_ID_F),
                    // .inR8(IMM16_ID),
                    // .outR8(IMM16_ID_F)

    // ID/EX Register
    idex idexreg(.clk(clk),
                    .enable(1'b1),
                    .dR0(regDa_ID),
                    .qR0(regDa_EX),
                    .dR1(regDb_ID),
                    .qR1(regDb_EX),
                    .dR2(PCplus4_ID),
                    .qR2(PCplus4_EX),
                    .dR3(SE_ID),
                    .qR3(SE_EX),
                    .dR4(RS_ID),
                    .qR4(RS_EX),
                    .dR5(RT_ID),
                    .qR5(RT_EX),
                    .dR6(RD_ID),
                    .qR6(RD_EX),
                    .dR7(TA_ID),
                    .qR7(TA_EX),
                    .dR8(IMM16_ID),
                    .qR8(IMM16_EX),
                    // .dC0(MemToReg_ID),
                    // .qC0(MemToReg_EX_F),
                    // .dC1(RegWr_ID),
                    // .qC1(RegWr_EX_F),
                    // .dC2(MemWr_ID),
                    // .qC2(MemWr_EX_F),
                    // .dC3(IsBranch_ID),
                    // .qC3(IsBranch_EX_F),
                    // .dC4(IsJump_ID),
                    // .qC4(IsJump_EX_F),
                    // .dC5(ALUsrc_ID),
                    // .qC5(ALUsrc_EX_F),
                    // .dC6(RegDst_ID),
                    // .qC6(RegDst_EX_F),
                    // .dC10(ALUctrl_ID),
                    // .qC10(ALUctrl_EX_F));
                    .dC0(MemToReg_ID_F),
                    .qC0(MemToReg_EX),
                    .dC1(RegWr_ID_F),
                    .qC1(RegWr_EX),
                    .dC2(MemWr_ID_F),
                    .qC2(MemWr_EX),
                    .dC3(IsBranch_ID_F),
                    .qC3(IsBranch_EX),
                    .dC4(IsJump_ID_F),
                    .qC4(IsJump_EX),
                    .dC5(ALUsrc_ID_F),
                    .qC5(ALUsrc_EX),
                    .dC6(RegDst_ID_F),
                    .qC6(RegDst_EX),
                    .dC10(ALUctrl_ID_F),
                    .qC10(ALUctrl_EX));

    // flushmux flush(.sel(FlushE),
    //                 .in0(MemToReg_EX_F),
    //                 .out0(MemToReg_EX),
    //                 .in1(RegWr_EX_F),
    //                 .out1(RegWr_EX),
    //                 .in2(MemWr_EX_F),
    //                 .out2(MemWr_EX),
    //                 .in3(IsBranch_EX_F),
    //                 .out3(IsBranch_EX),
    //                 .in4(IsJump_EX_F),
    //                 .out4(IsJump_EX),
    //                 .in5(ALUsrc_EX_F),
    //                 .out5(ALUsrc_EX),
    //                 .in6(RegDst_EX_F),
    //                 .out6(RegDst_EX),
    //                 .in7(ALUctrl_EX_F),
    //                 .out7(ALUctrl_EX));

    mux2 #(32) alusrc(.in0(regDb_EX),
                    .in1(SE_EX),
                    .sel(ALUsrc_EX),
                    .out(alusrcout_EX));

    mux4 #(32) fwdA(.in0(regDa_EX),
                    .in1(regDin_WB),
                    .in2(aluout_MEM),
                    .in3(32'h00000000),
                    .sel(forwardA_EX),
                    .out(operandA_EX));

    mux4 #(32) fwdB(.in0(alusrcout_EX),
                    .in1(regDin_WB),
                    .in2(aluout_MEM),
                    .in3(32'h00000000),
                    .sel(forwardB_EX),
                    .out(operandB_EX));

    ALU alumain(.carryout(carryout_EX),         // unused
                    .zero(zero_EX),
                    .overflow(overflow_EX),
                    .result(aluout_EX),
                    .operandA(operandA_EX),
                    .operandB(operandB_EX),
                    .command(ALUctrl_EX));

    assign jumpaddr_EX = {PCplus4_EX[31:28], TA_EX, 2'b00};
    assign branchaddr_EX = {{14{IMM16_EX[15]}}, IMM16_EX, 2'b00};

    mux2 #(32) muxshift2(.in0(jumpaddr_EX),
                    .in1(branchaddr_EX),
                    .sel(IsBranch_EX),
                    .out(shift2_EX));

    assign PCplus4addr_EX = PCplus4_EX + shift2_EX;

    mux2 #(5) muxregdst(.in0(RT_EX),
                    .in1(RD_EX),
                    .sel(RegDst_EX),
                    .out(regAw_EX));

    forwardingLUT forwardingLUT(.ex_rs(RS_EX),
                    .ex_rt(RT_EX),
                    .mem_regAw(regAw_MEM),
                    .wb_regAw(regAw_WB),
                    .mem_regWrite(RegWr_MEM),
                    .wb_regWrite(RegWr_WB),
                    .clk(clk),
                    .forwardA(forwardA_EX),
                    .forwardB(forwardB_EX));

    // EX/MEM Register
    exmem exmemreg(.clk(clk),
                    .enable(1'b1),
                    .dR0(aluout_EX),
                    .qR0(aluout_MEM),
                    .dR1(regDb_EX),
                    .qR1(regDb_MEM),
                    .dR2(PCplus4addr_EX),
                    .qR2(PCplus4addr_MEM),
                    .dR3(shift2_EX),
                    .qR3(shift2_MEM),
                    .dR4(RD_EX),
                    .qR4(RD_MEM),
                    .dA0(regAw_EX),
                    .qA0(regAw_MEM),
                    .dC0(MemToReg_EX),
                    .qC0(MemToReg_MEM),
                    .dC1(RegWr_EX),
                    .qC1(RegWr_MEM),
                    .dC2(MemWr_EX),
                    .qC2(MemWr_MEM),
                    .dC3(IsBranch_EX),
                    .qC3(IsBranch_MEM),
                    .dC4(IsJump_EX),
                    .qC4(IsJump_MEM),
                    .dF0(zero_EX),
                    .qF0(zero_MEM),
                    .dF1(overflow_EX),
                    .qF1(overflow_MEM));

    // memory mem(.clk(clk),
    //                 .WrEn(MemWr_MEM),
    //                 .DataAddr(aluout_MEM),
    //                 .DataIn(regDb_MEM),
    //                 .DataOut(memout_MEM),
    //                 .InstrAddr(PCcount_IF),
    //                 .Instruction(instruction_IF));

    // MEM/WB Register
    memwb memwbreg(.clk(clk),
                    .enable(1'b1),
                    .dR0(aluout_MEM),
                    .qR0(aluout_WB),
                    .dR1(memout_MEM),
                    .qR1(memout_WB),
                    .dR2(RD_MEM),
                    .qR2(RD_WB),
                    .dA0(regAw_MEM),
                    .qA0(regAw_WB),
                    .dC0(MemToReg_MEM),
                    .qC0(MemToReg_WB),
                    .dC1(RegWr_MEM),
                    .qC1(RegWr_WB));

    mux2 #(32) mem2reg(.in0(aluout_WB),
                    .in1(memout_WB),
                    .sel(MemToReg_WB),
                    .out(regDin_WB));

    // regfile register(.ReadData1(regDa_ID),
    //                 .ReadData2(regDb_ID),
    //                 .WriteData(regDin_WB),
    //                 .ReadRegister1(RS_ID),
    //                 .ReadRegister2(RT_ID),
    //                 .WriteRegister(regAw_WB),
    //                 .RegWrite(RegWr_WB),
    //                 .Clk(clk));

endmodule
