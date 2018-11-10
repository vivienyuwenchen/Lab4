//------------------------------------------------------------------------
// Pipelined CPU
//------------------------------------------------------------------------

`include "regfile.v"
`include "memory.v"
`include "dff.v"
`include "mux.v"
`include "alu.v"
`include "instructiondecoder.v"
`include "lut.v"

module cpu
(
    input clk
);

    // control wires
    wire RegDst, RegWr, MemWr, MemToReg, ALUsrc, IsJump, IsJAL, IsJR, IsBranch;
    wire [2:0] ALUctrl;
    wire [31:0]      datain;
    // decoder wires
    wire [5:0] OP_ID, FUNCT_ID;
    wire [4:0] RT_ID, RS_ID, RD_ID, SHAMT_ID;
    wire [15:0] IMM16_ID;
    wire [25:0] TA_ID;
    // IF wires
    wire [31:0] PCcount_IF, PCplus4_IF;
    wire [31:0] instruction_IF;
    // ID wires
    wire [31:0] PCplus4_ID;
    wire [31:0] instruction_ID;
    // EX wires
    wire ex;
    // MEM wires
    wire ALUout_MEM;
    // WB wires
    wire wb;

    dff #(32) pccounter(.clk(clk),
                    .enable(1'b1),
                    .d(isjrout),
                    .q(PCcount_IF));

    assign PCplus4_IF = PCcount_IF + 32'h00000004;

    memory mem(.clk(clk),
                    .WrEn(MemWr_MEM),
                    .DataAddr(aluout_MEM),
                    .DataIn(regDb_MEM),
                    .DataOut(memout_MEM),
                    .InstrAddr(PCcount_IF),
                    .Instruction(instruction_IF));

    // IF/ID Register
    ifid #(32) ifidreg(.clk(clk),
                    .enable(1'b1),
                    .d0(PCplus4_IF),
                    .q0(PCplus4_ID),
                    .d1(instruction_IF),
                    .q1(instruction_ID));

    instructiondecoder decoder(.OP(OP_ID),
                    .RT(RT_ID),
                    .RS(RS_ID),
                    .RD(RD_ID),
                    .IMM16(IMM16_ID),
                    .TA(TA_ID),
                    .SHAMT(SHAMT_ID),
                    .FUNCT(FUNCT_ID),
                    .instruction(instruction_ID));

    assign SE_ID = {{16{IMM16_ID[15]}}, IMM16_ID};

    mux2 #(5) regdst(.in0(RT_ID),
                    .in1(RD_ID),
                    .sel(RegDst_ID),
                    .out(Rint_ID));

    mux2 #(5) isjalaw(.in0(Rint),
                    .in1(5'd31),
                    .sel(IsJAL_ID),
                    .out(regAw_ID));

    regfile register(.ReadData1(regDa_ID),
                    .ReadData2(regDb_ID),
                    .WriteData(regDin_WB),
                    .ReadRegister1(RS_ID),
                    .ReadRegister2(RT_ID),
                    .WriteRegister(regAw_ID),
                    .RegWrite(RegWr_ID),
                    .Clk(clk));

    // ID/EX Register
    idex #(32) idexreg(.clk(clk),
                    .enable(1'b1),
                    .d0(PCplus4_ID),
                    .q0(PCplus4_EX),
                    .d1(regDa_ID),
                    .q1(regDa_EX),
                    .d2(regDb_ID),
                    .q2(regDb_EX),
                    .d3(SE_ID),
                    .q3(SE_EX));

    mux2 #(32) alusrc(.in0(regDb_EX),
                    .in1(SE_EX),
                    .sel(ALUsrc_EX),
                    .out(alusrcout_EX));

    ALU alumain(.carryout(carryout_EX),
                    .zero(zero_EX),
                    .overflow(overflow_EX),
                    .result(aluout_EX),
                    .operandA(regDa_EX),
                    .operandB(alusrcout_EX),
                    .command(ALUctrl_EX));

    assign jumpaddr = {PCplus4[31:28], TA, 2'b00};
    assign branchaddr = {{14{IMM16[15]}}, IMM16, 2'b00};

    mux2 #(32) muxshift2(.in0(jumpaddr),
                    .in1(branchaddr),
                    .sel(IsBranch),
                    .out(shift2));

    assign aluaddsum = PCplus4 + shift2;

    // EX/MEM Register
    exmem #(32) exmemreg(.clk(clk),
                    .enable(1'b1),
                    .d0(aluout_EX),
                    .q0(aluout_MEM),
                    .d1(regDb_EX),
                    .q1(regDb_MEM),
                    .d2(MemWr_EX),
                    .q2(MemWr_MEM));

    // memory mem(.clk(clk),
    //                 .WrEn(MemWr),
    //                 .DataAddr(aluout_MEM),
    //                 .DataIn(regDb_MEM),
    //                 .DataOut(memout_MEM),
    //                 .InstrAddr(PCcount_IF),
    //                 .Instruction(instruction_IF));

    // EX/MEM Register
    memwb #(32) memwbreg(.clk(clk),
                    .enable(1'b1),
                    .d0(memout_MEM),
                    .q0(memout_WB),
                    .d1(aluout_MEM),
                    .q1(aluout_WB),
                    .d2(MemToReg_EX),
                    .q2(MemToReg_WB));

    mux2 #(32) mem2reg(.in0(aluout_WB),
                    .in1(memout_WB),
                    .sel(MemToReg_WB),
                    .out(mem2regout_WB));

    mux2 #(32) isjaldin(.in0(mem2regout_WB),
                    .in1(PCplus4_WB),
                    .sel(IsJAL_WB),
                    .out(regDin_WB));

    // regfile register(.ReadData1(regDa_ID),
    //                 .ReadData2(regDb_ID),
    //                 .WriteData(regDin_WB),
    //                 .ReadRegister1(RS_ID),
    //                 .ReadRegister2(RT_ID),
    //                 .WriteRegister(regAw_ID),
    //                 .RegWrite(RegWr_ID),
    //                 .Clk(clk));

endmodule
