// `include "input_fifo.v"
// `include "wishbone_nn/input_fifo.v"

module wishbone_nn #(
    parameter [31:0] IO_ADDRESS = 32'h30000000,
    parameter [31:0] PROGRAMMABLE_ADDRESS = IO_ADDRESS + 1
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
    input wire [3:0] wbs_sel_i,
    input wire [31:0] wbs_dat_i,
    input wire [31:0] wbs_adr_i,
    output wire wbs_ack_o,
    output wire [31:0] wbs_dat_o,
    input wire [`NN_ID_BUS-1:0] nn_ids
);
    wire full;
    wire full2;
    wire [`NN_ID_BUS-1:0] fifo_output;
    wire read_e;
    assign read_e = wbs_adr_i == IO_ADDRESS;
    fifo_buffer fifo_in (
        `ifdef USE_POWER_PINS
            .vccd1(vccd1),	// User area 1 1.8V supply
            .vssd1(vssd1),	// User area 1 digital ground
        `endif
        .clk(wb_clk_i),
        .we(wbs_we_i),
        .rst(wb_rst_i),
        .ce(wbs_stb_i && read_e), 
        .full(full),
        .data_i(wbs_dat_i)
    );

    fifo_buffer #(.FIFO_TYPE(`NN_ID_BUS)) fifo_out (
        `ifdef USE_POWER_PINS
            .vccd1(vccd1),	// User area 1 1.8V supply
            .vssd1(vssd1),	// User area 1 digital ground
        `endif
        .clk(wb_clk_i),
        .we(wbs_we_i),
        .rst(wb_rst_i),
        .ce(wbs_stb_i && read_e), 
        .full(full2),
        .data_i(nn_ids),
        .data_o(fifo_output)
    );
    
    assign wbs_ack_o = (wbs_stb_i && wbs_cyc_i && !wb_rst_i && (wbs_adr_i == IO_ADDRESS || wbs_adr_i == PROGRAMMABLE_ADDRESS)) ? 1'b1 : 1'bz;
    assign wbs_dat_o = (wbs_adr_i == IO_ADDRESS && !wbs_we_i && !wb_rst_i) ? {32-`NN_ID_BUS'b0 ,fifo_output} : 32'bz;
    
    `ifdef FORMAL
        always @(posedge wb_clk_i) begin
            if (~wb_rst_i) begin
                // Is able to ack while reset is low
                will_ack: cover (wbs_ack_o);

                // Can only ack if master initiates a read or write cycle to this slave
                a_ack_only_when_stb_and_cyc: assert(!wbs_ack_o || (wbs_stb_i && wbs_cyc_i));
                a_ack_only_when_addr: assert(!wbs_ack_o || (wbs_adr_i == IO_ADDRESS || wbs_adr_i == PROGRAMMABLE_ADDRESS));
                
            end else if (wb_rst_i) begin

                // Can not pull ack or data high when rst is high
                ack_dat_low: assert(!wbs_ack_o && !wbs_dat_o);
            end
        end
    `endif

endmodule

