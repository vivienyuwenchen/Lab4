# CompArch Lab 4: Pipelined CPU

## CPU Option:
We will be pursuing a pipelined CPU. This will implement the modules we created for our single cycle CPU. Most importantly we want to focus on the pipeline functionality and the deliberate structure of our organization and clean, efficient scripting (quality Makefiles). We felt like we learned how to do this for the last lab but we truly want to implement these learnings here.
### Intended Deliverables:
* Verilog and test benches for pipelined CPU
* Automatic Makefiles
* Dynamically loaded memory (not need to run each assembly file from a different test bench)
* Report with
    * Written description and block diagram of processor architecture. Consider including selected RTL to capture how instructions are implemented.
    * Description of test plan and results
    * Some performance/area analysis of design, mainly of how pipelining has improved our design (differences between single cycle and pipelined CPU)
    * Work plan reflection
### Stretch Deliverables:
* If we finish early or are feeling confident we will finish early we would like to add more MIPS functionality to our multiplined CPU.
### Resources:
* Pipelined CPU: Patterson 6, Harris 7.5


## WORK PLAN:
Based on Lab 3’s work plan reflection we found that we often underestimated how long it would take us to debug. In this work plan we are more realistic in the “fixing and debugging” steps, allowing us the time we need to actually find problems and implement changes. By breaking down each task into smaller tasks we are able to think more critically about how much time we think each lab component will take us. 

*  Pipelined CPU schematic (3 hours) DUE WEDNESDAY 11/7
*  Written Lookup table (1 hour) DUE WEDNESDAY 11/7
*  “Earlier than midpoint” check in with Ben (0.5 hour) DUE THURSDAY 11/8
*  Set up organized repository for CPU code structure and makefiles (0.5 hour) DUE THURSDAY 11/8
*  Verilog pipelined CPU design (5-8 hours) DUE SUNDAY 11/11
   *  New top level module(s) (3-4 hours)
   *  Look up tables (1 hour)
   *  New submodules if necessary (1-2 hours)
   *  Verilinting (1 hour)
*  Verilog and test dynamic test benches (7 hours) DUE WEDNESDAY 11/14
   *  Design dynamic test benches (1 hour)
   *  Implement and Verilog test benches (3 hours)
   *  Debugging and fixing CPU based on failed test benches (3 hours)
*  Write make files (2 hours) DUE THURSDAY 11/15
*  Performance analysis (2 hours) DUE THURSDAY 11/15
*  Write Report (2 hours) DUE THURSDAY 11/15
*  Stretch Goals: Additional MIPS functionality
