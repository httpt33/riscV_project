module instructionMemory(
    input      [31:0] read_addr,
    input clk,
    input reset,
    output [31:0] instruction_out
);
    reg [31:0] i_mem[63:0];
    integer i;

    assign instruction_out = i_mem[read_addr >> 2];

    always@(posedge clk or posedge reset) begin

        if(reset) begin
            for (i = 0; i < 64; i = i + 1) begin
                i_mem[i] = 32'b00;
            end
        end else begin
            // R-type
            i_mem[0] = 32'b00000000000000000000000000000000;          // nop
            i_mem[1] = 32'b0000000_11001_10000_000_01101_0110011;     // add x13, x16, x25
            i_mem[2] = 32'b0100000_00011_01000_000_00101_0110011;     // sub x5, x8, x3
            i_mem[3] = 32'b0000000_00011_00010_111_00001_0110011;     // and x1, x2, x3
            i_mem[4] = 32'b0000000_00101_00011_110_00100_0110011;     // or x4, x3, x5

            // I-type
            i_mem[5] = 32'b000000000011_10101_000_10110_0010011;      // addi x22, x21, 3
            i_mem[6] = 32'b000000000001_01000_110_01001_0010011;      // ori x9, x8, 1

            // L-type
            i_mem[7] = 32'b000000001111_00101_010_01000_0000011;
            i_mem[8] = 32'b000000000011_00011_010_01001_0000011;

            // S-type
            i_mem[9]  = 32'b0000000_01111_00101_010_01100_0100011;
            i_mem[10] = 32'b0000000_01110_00110_010_01010_0100011;

            // SB-type
            i_mem[11] = 32'h00948663;
        end
    end

endmodule
