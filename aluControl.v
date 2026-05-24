module aluControl(
    input      [1:0] alu_op,
    input            funct7, //only bit 30
    input      [2:0] funct3,
    output reg [3:0] control_out
);

    always@(*) begin
        casez({alu_op, funct7, funct3})
        6'b00_?_???:
        control_out <= 4'b0010; // load/store: always ADD
        6'b01_?_???:
        control_out <= 4'b0110; // branch: always SUB
        6'b10_0_000: 
        control_out <= 4'b0010; 
        6'b10_1_000:
        control_out <= 4'b0110;
        6'b10_0_111:
        control_out <= 4'b0000;
        6'b10_0_110:
        control_out <= 4'b0001;
        default:
        control_out <= 4'b0000;
        endcase
    end
endmodule