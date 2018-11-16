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
    input [4:0] mem_regAw,
    input [4:0] wb_regAw,
    input       mem_regWrite,
    input       wb_regWrite,
    input clk,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB

);

always @(*) begin

if((mem_regWrite) && (mem_regAw !=0) && (mem_regAw == ex_rs))
    forwardA = 2'b10;
else if((wb_regWrite && (wb_regAw != 0)) && ((mem_regAw != ex_rs) && (wb_regAw == ex_rs)))
    forwardA = 2'b01;
else
    forwardA = 2'b00;


if((mem_regWrite) && (mem_regAw !=0) && (mem_regAw == ex_rt))
    forwardB = 2'b10;
else if((wb_regWrite && (wb_regAw != 0)) && ((mem_regAw != ex_rt) && (wb_regAw == ex_rt)))
    forwardB = 2'b01;
else
    forwardB = 2'b00;
end

endmodule
