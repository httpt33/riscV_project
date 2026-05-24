module immediateGen(
    input  [6:0]  opcode,
    input  [31:0] instruction,
    output reg [31:0] immediate_ext //extend
); 

    always @(*) begin
        case(opcode)
            7'b0000011: //load
            immediate_ext <= {{20{instruction[31]}}, instruction[31:20]}; //make 20 copies of the MSB + concatenate
            7'b0100011: //store
            immediate_ext <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            7'b1100011: //branch
            immediate_ext <= {{19{instruction[31]}}, instruction[30:25], instruction[11:8], 1'b0};
            7'b0010011:
            immediate_ext <= {{20{instruction[31]}}, instruction[31:20]};
            default: 
            immediate_ext <= 32'b0;
        endcase
    end

endmodule