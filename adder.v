module adder(
    input  [31:0] in1,
    input  [31:0] in2,
    output [31:0] sum_out
);

assign sum_out = in1 + in2;

endmodule