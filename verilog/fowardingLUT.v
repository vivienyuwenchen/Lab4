//------------------------------------------------------------------------
// Fowarding Look Up Table
// Mux Control   | Source | Explanation
// ForwardA = 00 | EX     | The first ALU operand comes from the register fi le.
// ForwardA = 10 | MEM    | The first ALU operand is forwarded from the prior ALU result.
// ForwardA = 01 | WB     | The first ALU operand is forwarded from data memory or an earlier ALU result.
// ForwardB = 00 | EX     | The second ALU operand comes from the register fi le.
// ForwardB = 10 | MEM    | The second ALU operand is forwarded from the prior ALU result.
// ForwardB = 01 | WB     | The second ALU operand is forwarded from data memory or an earlier ALU result.

//Companion reading chapter 4.7 pg 370
//------------------------------------------------------------------------

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

module fowardingLUT
(
    input [31:0] ex_rs,
    input [31:0] ex_rt,
    input [31:0] mem_regRd,
    input [31:0] wb_regRd,
    input [31:0] wb_rd,
    input [31:0] rs,
    input [31:0] rt,
    input       mem_regWrite,
    input       wb_regWrite,
    output [1:0] fowardA,
    output [1:0] fowardB,

);

  if(mem_regWrite && (mem_regRd != 0) begin:
      if (mem_regRd == ex_rs) begin:
        fowardA = 2'b10;
        end

      if (mem_regRd == ex_rt) begin:
        fowardB = 2'b10;
        end
  end
  else if(wb_regWrite && (wb_regRd != 0) begin:
      if ((!(mem_regWrite && (mem_regRd != 0))) begin:
          if((mem_regRd != ex_rs) && (wb_regRd == ex_rs)) begin:
            forwardA = 2'b01;
          end
          if ((mem_regRd != ex_rt) && (wb_regRd == ex_rs)) begin:
            forwardB = 2'b01;
          end
      end
  end
  else begin:
      fowardA = 2'b00;
      fowardB = 2'b00;

endmodule
