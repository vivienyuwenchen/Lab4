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
    input [31:0] dR0, dR1;
    output [31:0] qR0, qR1;
);

    dff #(32) dffR0(.clk(clk),
                    .enable(enable),
                    .d(dR0),
                    .q(qR0));

    dff #(32) dffR1(.clk(clk),
                    .enable(enable),
                    .d(dR1),
                    .q(qR1));

endmodule

// ID/EX Register
module idex
(
    input clk,
    input enable,
    input [31:0] dR0, dR1, dR2, dR3, dR4, dR5;
    input dC0, dC1, dC2, dC3, dC4, dC5, dC6;
    input [2:0] dC10;
    output [31:0] qR0, qR1, qR2, qR3, qR4, qR5;
    output qC0, qC1, qC2, qC3, qC4, qC5, qC6;
    output [2:0] qC10;
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

    dff #(32) dffR3(.clk(clk),
                    .enable(enable),
                    .d(dR3),
                    .q(qR3));

    dff #(32) dffR4(.clk(clk),
                    .enable(enable),
                    .d(dR4),
                    .q(qR4));

    dff #(32) dffR5(.clk(clk),
                    .enable(enable),
                    .d(dR5),
                    .q(qR5));

    dff #(1) dffC0(.clk(clk),
                    .enable(enable),
                    .d(dC0),
                    .q(qC0));

    dff #(1) dffC1(.clk(clk),
                    .enable(enable),
                    .d(dC1),
                    .q(qC1));

    dff #(1) dffC2(.clk(clk),
                    .enable(enable),
                    .d(dC2),
                    .q(qC2));

    dff #(1) dffC3(.clk(clk),
                    .enable(enable),
                    .d(dC3),
                    .q(qC3));

    dff #(1) dffC4(.clk(clk),
                    .enable(enable),
                    .d(dC4),
                    .q(qC4));

    dff #(1) dffC5(.clk(clk),
                    .enable(enable),
                    .d(dC5),
                    .q(qC5));

    dff #(1) dffC6(.clk(clk),
                    .enable(enable),
                    .d(dC6),
                    .q(qC6));

    dff #(3) dffC10(.clk(clk),
                    .enable(enable),
                    .d(dC10),
                    .q(qC10));

endmodule

// EX/MEM Register
module exmem
(
    input clk,
    input enable,
    input [31:0] dR0, dR1, dR2, dR3;
    input dC0, dC1, dC2, dC3, dC4;
    input dF0, dF1;
    output [31:0] qR0, qR1, qR2, qR3;
    output qC0, qC1, qC2, qC3, qC4;
    output qF0, qF1;
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

    dff #(32) dffR3(.clk(clk),
                    .enable(enable),
                    .d(dR3),
                    .q(qR3));

    dff #(1) dffC0(.clk(clk),
                    .enable(enable),
                    .d(dC0),
                    .q(qC0));

    dff #(1) dffC1(.clk(clk),
                    .enable(enable),
                    .d(dC1),
                    .q(qC1));

    dff #(1) dffC2(.clk(clk),
                    .enable(enable),
                    .d(dC2),
                    .q(qC2));

    dff #(1) dffC3(.clk(clk),
                    .enable(enable),
                    .d(dC3),
                    .q(qC3));

    dff #(1) dffC4(.clk(clk),
                    .enable(enable),
                    .d(dC4),
                    .q(qC4));

    dff #(1) dffF0(.clk(clk),
                    .enable(enable),
                    .d(dF0),
                    .q(qF0));

    dff #(1) dffF1(.clk(clk),
                    .enable(enable),
                    .d(dF1),
                    .q(qF1));

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
