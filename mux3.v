module mux3(
    input         sel3,
    input  [31:0] a3,
    input  [31:0] b3,
    output [31:0] mux3_out
);

assign mux3_out = (sel3==1'b0) ? a3 : b3;

endmodule