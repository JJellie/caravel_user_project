module wishbone_nn #(
    //parameter [31:0] ADDRESS = 32'h30000000
    )(
    `ifdef USE_POWER_PINS
        inout vccd1,	// User area 1 1.8V supply
        inout vssd1,	// User area 1 digital ground
    `endif

    input wire wb_clk_i,
    input wire wb_rst_i,
    input wire wbs_stb_i,
    input wire wbs_cyc_i,
    input wire wbs_we_i,
    //input wire [3:0] wbs_sel_i,
    input wire [31:0] wbs_dat_i,
    //input wire [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output wire [31:0] wbs_dat_o
);
    wire full;
    always @ (posedge wb_clk_i) begin 
        wbs_ack_o <= wbs_cyc_i & wbs_stb_i;
    end
    fifo_buffer fifo_in (
        .clk(wb_clk_i),
        .we(wbs_we_i),
        .rst(wb_rst_i),
        .ce(wbs_cyc_i),
        .full(full),
        .data_i(wbs_dat_i),
        .data_o(wbs_dat_o)
    );

endmodule

