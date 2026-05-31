`timescale 1ns/1ps

module riscVTop_tb();
    reg clk, reset;
    integer errors;

    riscVTop uut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, riscVTop_tb);
        errors = 0;
        reset = 1;
        #15 reset = 0;
        #160 $finish;
    end

    initial begin
        $monitor("T=%0t | PC=%h | Instr=%h | RegWrite=%b | rd1=%h | rd2=%h | imm=%h | ALUres=%h | MemData=%h | WB=%h",
                 $time, uut.pc_top, uut.instruction_top, uut.reg_write_top,
                 uut.rd1_top, uut.rd2_top, uut.immediate_ext_top,
                 uut.addr_top, uut.mem_data_top, uut.write_back_top);
    end

    task assert_eq;
        input [31:0] actual;
        input [31:0] expected;
        input [127:0] label;
        begin
            if (actual !== expected) begin
                $display("FAIL [%s]: got %h | expected %h", label, actual, expected);
                errors = errors + 1;
            end else
                $display("PASS [%s]: %h", label, actual);
        end
    endtask

    // Check register values on negedge — after posedge writes have settled
    always @(negedge clk) begin
        if (!reset) begin
            case(uut.pc_top)
                32'h00000004: assert_eq(uut.registerFile_inst.registers[1], 32'd5,  "ADDI x1=5       ");
                32'h00000008: assert_eq(uut.registerFile_inst.registers[2], 32'd3,  "ADDI x2=3       ");
                32'h0000000C: assert_eq(uut.registerFile_inst.registers[3], 32'd8,  "ADD  x3=8       ");
                32'h00000010: assert_eq(uut.registerFile_inst.registers[4], 32'd2,  "SUB  x4=2       ");
                32'h00000014: assert_eq(uut.registerFile_inst.registers[5], 32'd1,  "AND  x5=1       ");
                32'h00000018: assert_eq(uut.registerFile_inst.registers[6], 32'd7,  "OR   x6=7       ");
                32'h00000024: assert_eq(uut.registerFile_inst.registers[7], 32'd8,  "LW   x7=8       ");
                32'h00000028: assert_eq(uut.registerFile_inst.registers[8], 32'd2,  "LW   x8=2       ");
                32'h0000002C: assert_eq(uut.registerFile_inst.registers[9], 32'd8,  "ADDI x9=8       ");
                32'h00000034: assert_eq(uut.pc_top,                         32'h34, "BEQ  taken      ");
            endcase
        end
    end

    // Final summary
    initial begin
        #175;
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("%0d TEST(S) FAILED", errors);
    end

endmodule