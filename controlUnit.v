module controlUnit(
    input      [6:0] instruction,
    output reg       branch,
    output reg       mem_read,
    output reg       mem_to_reg,
    output reg [1:0] alu_op,
    output reg       mem_write,
    output reg       alu_src,
    output reg       reg_write
);

always @(*) begin

    case(instruction)
    7'b0110011: 
    {alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op} = 8'b00100010;
    7'b0000011:
    {alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op} = 8'b11110000;
    7'b0100011:
    {alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op} = 8'b10001000;
    7'b1100011:
    {alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op} = 8'b00000101;
    default:
    {alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op} = 8'b00000000;
    endcase
end
endmodule