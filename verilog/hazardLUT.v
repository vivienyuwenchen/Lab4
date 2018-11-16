`define opLW    6'b100011
`define opSW    6'b101011
`define opJ     6'b000010
`define opJR    6'b001000 //FUNCT, OP = 6'b000000
`define opJAL   6'b000011
`define opBEQ   6'b000100
`define opBNE   6'b000101
`define opXORI  6'b001110
`define opADDI  6'b001000
`define opADD   6'b100000 //FUNCT, OP = 6'b000000
`define opSUB   6'b100010 //FUNCT, OP = 6'b000000
`define opSLT   6'b101010 //FUNCT, OP = 6'b000000
`define Rtype   6'b000000

module instructionLUT
(
    input [5:0] OP,
    input [5:0] FUNCT,
    input       zero,
    input       overflow,
    output reg  RegDst,
    output reg  RegWr,
    output reg  MemWr,
    output reg  MemToReg,
    output reg [2:0] ALUctrl,
    output reg  ALUsrc,
    output reg  IsJump,
    output reg  IsJAL,
    output reg  IsJR,
    output reg  IsBranch,
    output reg pcEnable,
    output reg controlLUT0,
    output reg if_Idreg
);

    always @(*) begin
        case(OP)
            `opJ: begin
              pcEnable = 0;
              controlLUT0 = 0;
              if_Idreg = 0;
            end
            `opJAL: begin
              pcEnable = 0;
              controlLUT0 = 0;
              if_Idreg = 0;
            end
            `opBEQ: begin
              pcEnable = 0;
              controlLUT0 = 0;
              if_Idreg = 0;
            end
            `opBNE: begin
              pcEnable = 0;
              controlLUT0 = 0;
              if_Idreg = 0;
            end

            `Rtype: begin
                case(FUNCT)
                    `opJR: begin
                      pcEnable = 0;
                      controlLUT0 = 0;
                      if_Idreg = 0;
                    end

                    default: begin
                        pcEnable = 1;
                        controlLUT0 = 1;
                        if_Idreg = 1;
                    end
                endcase // case(FUNCT)
            end // Rtype
            default: begin
                pcEnable = 1;
                controlLUT0 = 1;
                if_Idreg = 1;
            end
        endcase // case(OP)
    end // always
endmodule
