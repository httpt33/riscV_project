module dataMemory(
    input         clk, 
    input         reset,
    input         mem_write,
    input         mem_read,
    input  [31:0] read_addr,
    input  [31:0] write_addr,   // Added write address
    input  [31:0] write_data,
    output [31:0] mem_data_out
);
    reg [31:0] d_mem[63:0];
    integer k;

    // Clear memory on reset
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            for(k=0; k<64; k=k+1) begin
                d_mem[k] <= 32'b0;
            end
        end
        else if(mem_write) begin
            d_mem[write_addr[7:2]] <= write_data; // word-aligned write
        end
    end

    assign mem_data_out = (mem_read) ? d_mem[read_addr[7:2]] : 32'b0; 
endmodule
