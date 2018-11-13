//------------------------------------------------------------------------
// Fowarding Look Up Table
// Mux Control   | Source | Explanation
// ForwardA = 00 | EX     | The first ALU operand comes from the register file.
// ForwardA = 10 | MEM    | The first ALU operand is forwarded from the prior ALU result.
// ForwardA = 01 | WB     | The first ALU operand is forwarded from data memory or an earlier ALU result.
// ForwardB = 00 | EX     | The second ALU operand comes from the register file.
// ForwardB = 10 | MEM    | The second ALU operand is forwarded from the prior ALU result.
// ForwardB = 01 | WB     | The second ALU operand is forwarded from data memory or an earlier ALU result.

//Companion reading chapter 4.7 pg 370
//------------------------------------------------------------------------

module forwardingLUT
(
    input [4:0] ex_rs,
    input [4:0] ex_rt,
    input [4:0] mem_regRd,
    input [4:0] wb_regRd,
    input [4:0] rs,
    input [4:0] rt,
    input       mem_regWrite,
    input       wb_regWrite,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB

);

always @(*) begin
  if(mem_regWrite && (mem_regRd != 0)) begin
      if (mem_regRd == ex_rs) begin
          forwardA = 2'b10;
      end

      if (mem_regRd == ex_rt) begin
          forwardB = 2'b10;
      end
  end

  else if(wb_regWrite && (wb_regRd != 0)) begin
      if ((!(mem_regWrite && (mem_regRd != 0)))) begin

          if((mem_regRd != ex_rs) && (wb_regRd == ex_rs)) begin
              forwardA = 2'b01;
          end

          if ((mem_regRd != ex_rt) && (wb_regRd == ex_rs)) begin
              forwardB = 2'b01;
          end

      end
  end

  else begin
      forwardA = 2'b00;
      forwardB = 2'b00;
  end
end

endmodule
