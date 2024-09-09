module fifo_buffer (
    input wire clk,
    input wire we,
    input wire rst,
    input wire ce,
    output wire full,
    input wire [31:0] data_i,
    output reg [31:0] data_o
);
    reg [31:0] FIFO [0:7];
    reg [2:0] count;
    reg [2:0] write_addr = 0, read_addr = 0;

    assign full = (count==8) ? 1'b1 : 1'b0;
    always @ (posedge clk) begin
        if (rst) begin
            write_addr <= 0;
            read_addr <= 0;
            count <= 0;
        end
        else if (ce) begin
            if (!we && count > 0) begin
                data_o <= FIFO[read_addr];
                read_addr <= read_addr + 1;
            end
            else if (we && count < 8) begin
                FIFO[write_addr] <= data_i;
                write_addr <= write_addr + 1;
            end
        end
        if (write_addr == 8) write_addr <= 0;
        if (read_addr == 8) read_addr <= 0;
        if (read_addr > write_addr) count <= read_addr - write_addr;
        if (write_addr > read_addr) count <= write_addr - read_addr;
    end
endmodule
