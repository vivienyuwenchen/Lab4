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

module lwHazard
(
  input [4:0] ex_rs,
  input [4:0] ex_rt,
  input [4:0] id_rs,
  input [4:0] id_rt,
  input clk,
  input MemToReg_EX,
  output reg StallF,
  output reg StallD,
  output reg FlushE

);
    reg lwstall;

always @(negedge clk) begin
    lwstall = (((id_rs == ex_rt) || (id_rt == ex_rt)) && MemToReg_EX);
    StallF = !(lwstall);
    StallD = !(lwstall);
    FlushE = lwstall;
end

endmodule
