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
  input MemToReg_MEM,   // branch
  input IsBranch_ID,    // branch
  input RegWr_EX,       // branch
  input [4:0] regAw_EX,     // branch
  input [4:0] regAw_MEM,    // branch
  input [31:0] regDa_ID,    // branch
  input [31:0] regDb_ID,    // branch
  output reg StallF,
  output reg StallD,
  output reg FlushE,
  output reg IsBranch_ID_Haz    // branch
);

    reg lwstall, branchstall;

    always @(*) begin
        lwstall = (((id_rs == ex_rt) || (id_rt == ex_rt)) && MemToReg_EX);
        branchstall = ((IsBranch_ID && RegWr_EX && ((regAw_EX == id_rs) || (regAw_EX == id_rt)))  ||  (IsBranch_ID && MemToReg_MEM && ((regAw_MEM == id_rs) || (regAw_MEM == id_rt))));
        IsBranch_ID_Haz = (IsBranch_ID && (regDa_ID == regDb_ID));
        StallF = !(lwstall || branchstall);
        StallD = !(lwstall || branchstall);
        FlushE = (lwstall || branchstall);
    end

endmodule
