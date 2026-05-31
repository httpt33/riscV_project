module riscVTop(
    input clk,
    input reset,
    output [31:0] debug_out  // for debugging on vivado
);

wire [31:0] pc_top, instruction_top, rd1_top, rd2_top, immediate_ext_top, mux1_top, sum_out_top, next_pc_top, pc_in_top, addr_top, mem_data_top, write_back_top;
wire reg_write_top, alu_src_top, branch_top, zero_top, sel2_top, mem_to_reg_top, mem_write_top, mem_read_top;
wire [1:0] alu_op_top;
wire [3:0] control_top;


//programCounter
programCounter programCounter_inst (.clk(clk), .reset(reset), .pc_in(pc_in_top), .pc_out(pc_top));

//pcAdder
pcAdder pcAdder_inst (.from_pc(pc_top), .next_pc(next_pc_top));

//instructionMemory
instructionMemory instructionMemory_inst (.clk(clk), .reset(reset), .read_addr(pc_top), .instruction_out(instruction_top));

//registerFile
registerFile registerFile_inst (.clk(clk), .reset(reset), .reg_write(reg_write_top), .rs1(instruction_top[19:15]), .rs2(instruction_top[24:20]), .rd(instruction_top[11:7]), .write_data(write_back_top), .read_data1(rd1_top), .read_data2(rd2_top));

//immediateGen
immediateGen immediateGen_inst (.opcode(instruction_top[6:0]), .instruction(instruction_top), .immediate_ext(immediate_ext_top));

//controlUnit
controlUnit controlUnit_inst (.instruction(instruction_top[6:0]), .branch(branch_top), .mem_read(mem_read_top), .mem_to_reg(mem_to_reg_top), .alu_op(alu_op_top), .mem_write(mem_write_top), .alu_src(alu_src_top), .reg_write(reg_write_top));

//aluControl
aluControl aluControl_inst (.alu_op(alu_op_top), .funct7(instruction_top[30]), .funct3(instruction_top[14:12]), .control_out(control_top));

//alu
alu alu_inst (.a(rd1_top), .b(mux1_top), .control_in(control_top), .alu_result(addr_top), .zero(zero_top));

//mux 1
mux1 alu_mux (.sel1(alu_src_top), .a1(rd2_top), .b1(immediate_ext_top), .mux1_out(mux1_top));

//adder
adder adder_inst (.in1(pc_top), .in2(immediate_ext_top), .sum_out(sum_out_top));

//andGate
andGate andGate_inst (.branch(branch_top), .zero(zero_top), .and_out(sel2_top));

//mux 2
mux2 adder_mux (.sel2(sel2_top), .a2(next_pc_top), .b2(sum_out_top), .mux2_out(pc_in_top));

//dataMemory
dataMemory dataMemory_inst (.clk(clk), .reset(reset), .mem_write(mem_write_top), .mem_read(mem_read_top), .read_addr(addr_top), .write_data(rd2_top),.write_addr(addr_top), .mem_data_out(mem_data_top));

//mux 3
mux3 data_memory_mux (.sel3(mem_to_reg_top), .a3(addr_top), .b3(mem_data_top), .mux3_out(write_back_top));

assign debug_out = write_back_top;

endmodule