module instructionMemory(
    input      [31:0] read_addr,
    input      clk,
    input      reset,
    output     [31:0] instruction_out
);
    reg [31:0] i_mem[63:0];

    assign instruction_out = i_mem[read_addr >> 2];
    integer i;

    initial begin
        i_mem[0]  = 32'h00500093; // ADDI x1, x0, 5
        i_mem[1]  = 32'h00300113; // ADDI x2, x0, 3
        i_mem[2]  = 32'h002081B3; // ADD  x3, x1, x2
        i_mem[3]  = 32'h40208233; // SUB  x4, x1, x2
        i_mem[4]  = 32'h0020F2B3; // AND  x5, x1, x2
        i_mem[5]  = 32'h0020E333; // OR   x6, x1, x2
        i_mem[6]  = 32'h00302023; // SW   x3, 0(x0)
        i_mem[7]  = 32'h00402223; // SW   x4, 4(x0)
        i_mem[8]  = 32'h00002383; // LW   x7, 0(x0)
        i_mem[9]  = 32'h00402403; // LW   x8, 4(x0)
        i_mem[10] = 32'h00800493; // ADDI x9, x0, 8
        i_mem[11] = 32'h00938463; // BEQ  x7, x9, 8
    end

endmodule