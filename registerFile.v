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
            registers[0] <= 32'b0;
            //for(k=0; k<32; k=k+1) begin
                //registers[k] <= 32'b00;
            //end
        end
        else if(reg_write && rd !=0 ) begin
            registers[rd] <= write_data;
        end
    end

    assign read_data1 = registers[rs1];
    assign read_data2 = registers[rs2];

endmodule