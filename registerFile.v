module registerFile(
    input         clk,
    input         reset,
    input         reg_write,
    input  [4:0]  rs1, //source 1
    input  [4:0]  rs2, //source 2
    input  [4:0]  rd,  //destination
    input  [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] registers [31:0]; 

    initial begin

        registers[0] = 0;
        registers[1] = 3;
        registers[2] = 2;
        registers[3] = 12;
        registers[4] = 20;
        registers[5] = 3;
        registers[6] = 44;
        registers[7] = 4;
        registers[8] = 2;
        registers[9] = 1;
        registers[10] = 23;
        registers[11] = 4;
        registers[12] = 90;
        registers[13] = 10;
        registers[14] = 20;
        registers[15] = 30;
        registers[16] = 40;
        registers[17] = 50;
        registers[18] = 60;
        registers[19] = 70;
        registers[20] = 80;
        registers[21] = 80;
        registers[22] = 90;
        registers[23] = 70;
        registers[24] = 60;
        registers[25] = 65;
        registers[26] = 4;
        registers[27] = 32;
        registers[28] = 12;
        registers[29] = 34;
        registers[30] = 5;
        registers[31] = 10;

    end
    
    integer k;
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            registers[0]  <= 32'd0;
            registers[1]  <= 32'd3;
            registers[2]  <= 32'd2;
            registers[3]  <= 32'd12;
            registers[4]  <= 32'd20;
            registers[5]  <= 32'd3;
            registers[6]  <= 32'd44;
            registers[7]  <= 32'd4;
            registers[8]  <= 32'd2;
            registers[9]  <= 32'd1;
            registers[10] <= 32'd23;
            registers[11] <= 32'd4;
            registers[12] <= 32'd90;
            registers[13] <= 32'd10;
            registers[14] <= 32'd20;
            registers[15] <= 32'd30;
            registers[16] <= 32'd40;
            registers[17] <= 32'd50;
            registers[18] <= 32'd60;
            registers[19] <= 32'd70;
            registers[20] <= 32'd80;
            registers[21] <= 32'd80;
            registers[22] <= 32'd90;
            registers[23] <= 32'd70;
            registers[24] <= 32'd60;
            registers[25] <= 32'd65;
            registers[26] <= 32'd4;
            registers[27] <= 32'd32;
            registers[28] <= 32'd12;
            registers[29] <= 32'd34;
            registers[30] <= 32'd5;
            registers[31] <= 32'd10;
        end
        else if(reg_write && rd != 0) begin
            registers[rd] <= write_data;
        end
    end

    assign read_data1 = registers[rs1];
    assign read_data2 = registers[rs2];

endmodule