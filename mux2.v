module mux2(
    input         sel2,
    input  [31:0] a2,
    input  [31:0] b2,
    output [31:0] mux2_out
);

assign mux2_out = (sel2==1'b0) ? a2 : b2;

endmodule