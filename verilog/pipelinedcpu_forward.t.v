`include "pipelinedcpu.v"

//------------------------------------------------------------------------
// Test bench for XOR SUB SLT sequence.
// instructions were generated from xor_sub_slt.asm
// This test bench test the ADDI, XORI, SUB, SLT, BNE, J functionality
// outputs are found at verious registers including
//------------------------------------------------------------------------

module cpu_test ();

    reg clk;
    reg reset;

    // Clock generation
    initial clk=0;
    always #10 clk = !clk;

    // Instantiate CPU
    cpu cpu(.clk(clk));

    initial begin

    $readmemh("../asm/dat/forwarding2.dat", cpu.mem.mem,0);

  	$dumpfile("cpu_alu.vcd");
  	$dumpvars();

  	// Assert reset pulse
  	reset = 0; #10;
  	reset = 1; #10;
  	reset = 0; #10;

    #10000
    if(cpu.register.RegisterOutput[9] != 32'h7 || cpu.register.RegisterOutput[10] != 32'h2 || cpu.register.RegisterOutput[11] != 32'hffffffff || cpu.register.RegisterOutput[12] != 32'h8 || cpu.register.RegisterOutput[13] != 32'h8 || cpu.register.RegisterOutput[14] != 32'hfffffffe) begin// || cpu.register.RegisterOutput[4] != 32'hb || cpu.register.RegisterOutput[8] != 32'hb || cpu.register.RegisterOutput[9] != 32'h37)
          $display("----------------------------------------");
          $display("FAILED PIPELINE Forwarding TEST");
          $display("$t1$: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[9]);
          $display("$t2$: Expected: %h, ACTUAL: %h", 32'h5, cpu.register.RegisterOutput[10]);
          $display("$t3$: Expected: %h, ACTUAL: %h", 32'h3, cpu.register.RegisterOutput[11]);
          $display("$t4$: Expected: %h, ACTUAL: %h", 32'h4, cpu.register.RegisterOutput[12]);
          $display("$t5$: Expected: %h, ACTUAL: %h", 32'h5, cpu.register.RegisterOutput[13]);
          $display("$t6$: Expected: %h, ACTUAL: %h", 32'h6, cpu.register.RegisterOutput[14]);
          $display("----------------------------------------");

          end
   else begin
         $display("----------------------------------------");
         $display("PASSED PIPELINE SW/LW TEST");
         $display("----------------------------------------");
         end
  	#2000 $finish();
      end

  endmodule
