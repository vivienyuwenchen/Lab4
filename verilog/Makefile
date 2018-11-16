cpu: pipelinedcpu_alu.t.v pipelinedcpu_forward.t.v pipelinedcpu_swlw.t.v
	iverilog -o pipelinedcpu_alu.o pipelinedcpu_alu.t.v
	iverilog -o pipelinedcpu_forward.o pipelinedcpu_forward.t.v
	iverilog -o pipelinedcpu_swlw.o pipelinedcpu_swlw.t.v
	./pipelinedcpu_alu.o
	./pipelinedcpu_forward.o
	./pipelinedcpu_swlw.o

tests: alu.t.v dff.t.v forwardingLUT.t.v hazardLUT.t.v instructiondecoder.t.v lut.t.v lwhazard.t.v memory.t.v mux.t.v regfile.t.v
	iverilog -o alu.o alu.t.v
	iverilog -o dff.o dff.t.v
	iverilog -o forwardingLUT.o forwardingLUT.t.v
	iverilog -o hazardLUT.o hazardLUT.t.v
	iverilog -o instructiondecoder.o instructiondecoder.t.v
	iverilog -o lut.o lut.t.v
	iverilog -o lwhazard.o lwhazard.t.v
	iverilog -o memory.o memory.t.v
	iverilog -o mux.o mux.t.v
	iverilog -o regfile.o regfile.t.v
	./alu.o
	./dff.o
	./forwardingLUT.o
	./hazardLUT.o
	./instructiondecoder.o
	./lut.o
	./lwhazard.o
	./memory.o
	./mux.o
	./regfile.o

clean:
	rm *.o
	rm *.vcd

run:
	make cpu
	make tests
	make clean
