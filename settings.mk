# Project-specific settings

## Assembly settings

# Assembly program (minus .asm extension)
#PROGRAM := array_loop
PROGRAM := LWHazard

# Memory image(s) to create from the assembly program
TEXTMEMDUMP := $(PROGRAM).text.hex
DATAMEMDUMP := $(PROGRAM).data.hex


## Verilog settings

# Top-level module/filename (minus .v/.t.v extension)
TOPLEVEL := pipelinedcpu

# All circuits included by the toplevel $(TOPLEVEL).t.v
CIRCUITS := $(TOPLEVEL).v regfile.v memory.v dff.v mux.v mux4.v alu.v instructiondecoder.v lut.v forwardingLUT.v lwHazard.v
