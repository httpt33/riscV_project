`timescale 1ns/1ps

module riscVTop_tb();
    reg clk, reset;

    // Instantiate DUT
    riscVTop uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns period
    end

    // Stimulus
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, riscVTop_tb);
        reset = 1;
        #10 reset = 0;
        #130 $finish;  // just enough for 12 instructions
    end

    // Monitor only valid instruction addresses
    always @(negedge clk) begin
    $display("T=%0t | PC=%h | Instr=%h | x5=%h | rd1=%h | rd2=%h | imm=%h | ALUres=%h",
             $time, uut.pc_top, uut.instruction_top,
             uut.registerFile_inst.registers[5],
             uut.rd1_top,
             uut.rd2_top,
             uut.immediate_ext_top,
             uut.addr_top);
    end

endmodule