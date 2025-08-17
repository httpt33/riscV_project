module pcAdder(
    input [31:0] from_pc,
    output reg [31:0] next_pc
);
    always @(*) begin
        next_pc = 4 + from_pc;
    end

endmodule