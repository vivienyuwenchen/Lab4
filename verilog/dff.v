//-----------------------------------------------------------------------------
// D Flip-Flops
//-----------------------------------------------------------------------------

// D flip-flop with parameterized bit width (default: 1-bit)
// Parameters in Verilog: http://www.asic-world.com/verilog/para_modules1.html
module dff #( parameter W = 32 )
(
    input clk,
    input enable,
    input   [W-1:0] d,
    output  [W-1:0] q
);

    reg [W-1:0] mem;

    initial begin
        mem <= {W{1'b0}};
    end

    always @(posedge clk) begin
        if(enable) begin
            mem <= d;
        end
    end

    assign q = mem;
endmodule

// IF/ID Register
module ifid
(
    input clk,
    input enable,
    input [31:0] d0, d1;
    output [31:0] q0, q1;
);

    dff #(32) dff0(.clk(clk),
                    .enable(enable),
                    .d(d0),
                    .q(q0));

    dff #(32) dff1(.clk(clk),
                    .enable(enable),
                    .d(d1),
                    .q(q1));

endmodule

// ID/EX Register
module idex
(
    input clk,
    input enable,
    input [31:0] d0, d1, d2, d3;
    output [31:0] q0, q1, q2, q3;
);

    dff #(32) dff0(.clk(clk),
                    .enable(enable),
                    .d(d0),
                    .q(q0));

    dff #(32) dff1(.clk(clk),
                    .enable(enable),
                    .d(d1),
                    .q(q1));

    dff #(32) dff2(.clk(clk),
                    .enable(enable),
                    .d(d2),
                    .q(q2));

    dff #(32) dff3(.clk(clk),
                    .enable(enable),
                    .d(d3),
                    .q(q3));

endmodule

// EX/MEM Register
module exmem
(
    input clk,
    input enable,
    input [31:0] dR0, dR1;
    input dC0;
    output [31:0] qR0, qR1;
    output qC0;
);

    dff #(32) dffR0(.clk(clk),
                    .enable(enable),
                    .d(dR0),
                    .q(qR0));

    dff #(32) dffR1(.clk(clk),
                    .enable(enable),
                    .d(dR1),
                    .q(qR1));

    dff #(1) dffC0(.clk(clk),
                    .enable(enable),
                    .d(dC0),
                    .q(qC0));

endmodule

// MEM/WB Register
module memwb
(
    input clk,
    input enable,
    input [31:0] dR0, dR1, dR2;
    input dC0, dC1;
    output [31:0] qR0, qR1, qR2;
    output qC0, qC1;
);

    dff #(32) dffR0(.clk(clk),
                    .enable(enable),
                    .d(dR0),
                    .q(qR0));

    dff #(32) dffR1(.clk(clk),
                    .enable(enable),
                    .d(dR1),
                    .q(qR1));

    dff #(32) dffR2(.clk(clk),
                    .enable(enable),
                    .d(dR2),
                    .q(qR2));

    dff #(1) dffC0(.clk(clk),
                    .enable(enable),
                    .d(dC0),
                    .q(qC0));

    dff #(1) dffC1(.clk(clk),
                    .enable(enable),
                    .d(dC1),
                    .q(qC1));

endmodule
