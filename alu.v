module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0]  control_in,
    output reg [31:0] alu_result,
    output reg   zero
);

    always @(control_in or a or b) begin

        case(control_in)
        4'b0000: begin //and
            zero <= 0;
            alu_result <= a & b;
        end
        4'b0001: begin //or
            zero <= 0;
            alu_result <= a | b;
        end
        4'b0010: begin //add
            zero <= 0;
            alu_result <= a + b;
        end
        4'b0110: begin //subtract
            if(a==b)
                zero <= 1;
            else
                zero <= 0;
            alu_result <= a - b;    
        end
        default: begin
            alu_result <= 32'b0;
            zero <= 1'b0;
        end
        endcase
    end

endmodule