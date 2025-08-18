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
        reset = 1;
        #10 reset = 0;  // release reset after 10 ns
        #400 $finish;   // run simulation
    end

    // Monitor only valid instruction addresses
    initial begin
        $monitor("T=%0t | PC=%h | Instr=%h | RegWrite=%b | ALUres=%h | MemData=%h | WB=%h", 
                 $time, uut.pc_top, uut.instruction_top, uut.reg_write_top, 
                 uut.addr_top, uut.mem_data_top, uut.write_back_top);
    end

endmodule
