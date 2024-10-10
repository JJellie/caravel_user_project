module fifo_buffer #(
    parameter FIFO_TYPE = 32,
    parameter FIFO_SPACES = 8
    ) (
    `ifdef USE_POWER_PINS
        inout vccd1,	// User area 1 1.8V supply
        inout vssd1,	// User area 1 digital ground
    `endif
    input wire clk,
    input wire we,
    input wire rst,
    input wire ce,
    output wire full,
    input wire [FIFO_TYPE-1:0] data_i,
    output wire [FIFO_TYPE-1:0] data_o

);
    reg [FIFO_TYPE-1:0] FIFO [0:FIFO_SPACES-1];
    reg [$clog2(FIFO_SPACES):0] count;
    reg [$clog2(FIFO_SPACES):0] write_addr = 0, read_addr = 0;

    initial begin
        count <= 0;
        read_addr <= 0;
        write_addr <= 0;
    end

    assign full = (count==FIFO_SPACES) ? 1'b1 : 1'b0;
    assign data_o = ce ? FIFO[read_addr] : {FIFO_TYPE{1'b0}};
    
    always @(posedge clk) begin
        if (rst) begin
            write_addr <= 0;
            read_addr <= 0;
            count <= 0;
        end
        else if (ce) begin
            if (we && count <= FIFO_SPACES) begin
                FIFO[write_addr] <= data_i;
                write_addr <= write_addr + 1;
                count <= count + 1;
            end
            else if (!we && count > 0) begin
                read_addr <= read_addr+1;
                count <= count - 1;
            end
        end
        if (write_addr == FIFO_SPACES) begin
            write_addr <= 0;
        end 
        if (read_addr == FIFO_SPACES) begin
            read_addr <= 0;
        end
    
    end
    

    `ifdef FORMAL
    // Formal verification with SymbiYosis
    always @(posedge clk) begin
        if (~rst) begin
            // Count is bound beween 0 or 8 items, the addresses are bound between 0 and 7
            count_bound: assert (count <= FIFO_SPACES && count >= 0);
            r_addr_bound: assert (read_addr >= 0 && read_addr <= FIFO_SPACES-1);
            w_addr_bound: assert (write_addr >= 0 && write_addr <= FIFO_SPACES-1);

            // Count can only increase or decrease by 1 each cycle
            count_change: assert(count == 0 || count == $past(count) || count == $past(count) + 1 || count == $past(count) - 1);

            // The addresses can only increase by 1 or be reset to zero when reaching the end.
            read_addr_change: assert(read_addr == 0 || read_addr == $past(read_addr) || read_addr == $past(read_addr) + 1);
            write_addr_change: assert(write_addr == 0 || write_addr == $past(write_addr) || write_addr == $past(write_addr) + 1);
        end
    end
    `endif
endmodule
