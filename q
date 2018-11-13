[1mdiff --cc verilog/pipelinedcpu_alu.t.v[m
[1mindex 56a8269,303bb69..0000000[m
[1m--- a/verilog/pipelinedcpu_alu.t.v[m
[1m+++ b/verilog/pipelinedcpu_alu.t.v[m
[36m@@@ -31,17 -31,17 +31,17 @@@[m [mmodule cpu_test ()[m
    	reset = 1; #10;[m
    	reset = 0; #10;[m
  [m
[31m-     #7670[m
[31m -    #1000000[m
[31m -    if(cpu.register.RegisterOutput[8] != 32'h1 || cpu.register.RegisterOutput[9] != 32'h1 || cpu.register.RegisterOutput[10] != 32'h7 || cpu.register.RegisterOutput[11] != 32'hfffffffb || cpu.register.RegisterOutput[12] != 32'h3 || cpu.register.RegisterOutput[13] != 32'hfffffff2 || cpu.register.RegisterOutput[14] != 32'hfffffff7  ) begin// || cpu.register.RegisterOutput[4] != 32'hb || cpu.register.RegisterOutput[8] != 32'hb || cpu.register.RegisterOutput[9] != 32'h37)[m
[32m++    #82450[m
[32m +    if(cpu.register.RegisterOutput[8] != 32'h1 || cpu.register.RegisterOutput[9] != 32'h3 || cpu.register.RegisterOutput[10] != 32'h2 || cpu.register.RegisterOutput[11] != 32'h3 || cpu.register.RegisterOutput[12] != 32'h2 || cpu.register.RegisterOutput[13] != 32'h5|| cpu.register.RegisterOutput[14] != 32'h6 ) begin// || cpu.register.RegisterOutput[4] != 32'hb || cpu.register.RegisterOutput[8] != 32'hb || cpu.register.RegisterOutput[9] != 32'h37)[m
            $display("----------------------------------------");[m
[31m -          $display("FAILED XOR SUB SLT TEST");[m
[31m -          $display("$t0$: Expected: %h, ACTUAL: %h", 32'h0, cpu.register.RegisterOutput[8]);[m
[31m -          $display("$t1$: Expected: %h, ACTUAL: %h", 32'h7, cpu.register.RegisterOutput[9]);[m
[32m +          $display("FAILED PIPELINE ALU TEST");[m
[32m +          $display("$t0$: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[8]);[m
[32m +          $display("$t1$: Expected: %h, ACTUAL: %h", 32'h3, cpu.register.RegisterOutput[9]);[m
            $display("$t2$: Expected: %h, ACTUAL: %h", 32'h2, cpu.register.RegisterOutput[10]);[m
[31m -          $display("$t3$: Expected: %h, ACTUAL: %h", 32'hffffffff, cpu.register.RegisterOutput[11]);[m
[31m -          $display("$t4$: Expected: %h, ACTUAL: %h", 32'h8, cpu.register.RegisterOutput[12]);[m
[31m -          $display("$t5$: Expected: %h, ACTUAL: %h", 32'h8, cpu.register.RegisterOutput[13]);[m
[31m -          $display("$t6$: Expected: %h, ACTUAL: %h", 32'hfffffffe, cpu.register.RegisterOutput[14]);[m
[32m +          $display("$t3$: Expected: %h, ACTUAL: %h", 32'h3, cpu.register.RegisterOutput[11]);[m
[32m +          $display("$t4$: Expected: %h, ACTUAL: %h", 32'h2, cpu.register.RegisterOutput[12]);[m
[32m +          $display("$t5$: Expected: %h, ACTUAL: %h", 32'h5, cpu.register.RegisterOutput[13]);[m
[32m +          $display("$t6$: Expected: %h, ACTUAL: %h", 32'h6, cpu.register.RegisterOutput[14]);[m
            $display("----------------------------------------");[m
  [m
            end[m
