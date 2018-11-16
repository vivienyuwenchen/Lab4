//------------------------------------------------------------------------
// Load Word Hazard Look Up Table
//------------------------------------------------------------------------

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

    reg lwstall, branchstall;

    always @(*) begin
        lwstall = (((id_rs == ex_rt) || (id_rt == ex_rt)) && MemToReg_EX);
        StallF = !(lwstall);
        StallD = !(lwstall);
        FlushE = (lwstall);
    end

endmodule
