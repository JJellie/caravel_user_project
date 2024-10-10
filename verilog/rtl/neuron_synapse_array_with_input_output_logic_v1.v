// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/neuron_synapse_array_with_input_output_logic_v1.sch
module neuron_synapse_array_with_input_output_logic_v1
(
  output wire req_o,
  output wire [0:3] aer_o,
  inout wire dGND,
  inout wire dVDD,
  inout wire aVDD,
  inout wire monout,
  inout wire aGND,
  input wire vleakn,
  input wire vrefn,
  input wire ifdcp,
  input wire bufmonp,
  input wire nRes,
  input wire ack,
  input wire [0:3] neu_addr,
  input wire req_inp,
  input wire [0:3] syn_addr,
  input wire exc,
  input wire [0:3] W,
  input wire resetW,
  input wire setW,
  input wire vepulseextp,
  input wire vipulseextp,
  input wire [0:3] JExcWn,
  input wire [0:3] JInhWp,
  input wire vthrdp,
  input wire vtaun,
  input wire vthrdn,
  input wire vtaup,
  input wire Da,
  input wire CLK
);
wire [15:0] ack_neu ;
wire [15:0] monout ;
wire [15:0] neu_req ;
wire req_inp_array ;
wire [3:0] neu_addr_latched ;
wire [15:0] req_o ;
wire exc_latched ;
wire [3:0] syn_addr_latched ;

neuro_synaptic_core_16neu_32syn_v1
x1 ( 
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .bufmonp( bufmonp ),
 .ifdcp( ifdcp ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .syn_addr( {syn_addr_latched[0],syn_addr_latched[1],syn_addr_latched[2],syn_addr_latched[3]} ),
 .ack_neu( {ack_neu[0],ack_neu[1],ack_neu[2],ack_neu[3],ack_neu[4],ack_neu[5],ack_neu[6],ack_neu[7],ack_neu[8],ack_neu[9],ack_neu[10],ack_neu[11],ack_neu[12],ack_neu[13],ack_neu[14],ack_neu[15]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .vepulseextp( vepulseextp ),
 .monout( {monout[0],monout[1],monout[2],monout[3],monout[4],monout[5],monout[6],monout[7],monout[8],monout[9],monout[10],monout[11],monout[12],monout[13],monout[14],monout[15]} ),
 .resetW( resetW ),
 .neu_req( {neu_req[0],neu_req[1],neu_req[2],neu_req[3],neu_req[4],neu_req[5],neu_req[6],neu_req[7],neu_req[8],neu_req[9],neu_req[10],neu_req[11],neu_req[12],neu_req[13],neu_req[14],neu_req[15]} ),
 .vrefn( vrefn ),
 .req_neu_out( {req_o[0],req_o[1],req_o[2],req_o[3],req_o[4],req_o[5],req_o[6],req_o[7],req_o[8],req_o[9],req_o[10],req_o[11],req_o[12],req_o[13],req_o[14],req_o[15]} ),
 .vthrdn( vthrdn ),
 .vthrdp( vthrdp ),
 .setW( setW ),
 .exc( exc_latched ),
 .vtaup( vtaup ),
 .vtaun( vtaun ),
 .aGND( aGND ),
 .dGND( dGND ),
 .aVDD( aVDD ),
 .dVDD( dVDD ),
 .nRes( nRes )
);


arbiter_tree_sixteen_bits
x5 ( 
 .req( {req_o[0],req_o[1],req_o[2],req_o[3],req_o[4],req_o[5],req_o[6],req_o[7],req_o[8],req_o[9],req_o[10],req_o[11],req_o[12],req_o[13],req_o[14],req_o[15]} ),
 .ack_cpu( ack ),
 .ack( {ack_neu[0],ack_neu[1],ack_neu[2],ack_neu[3],ack_neu[4],ack_neu[5],ack_neu[6],ack_neu[7],ack_neu[8],ack_neu[9],ack_neu[10],ack_neu[11],ack_neu[12],ack_neu[13],ack_neu[14],ack_neu[15]} ),
 .req_cpu( req_o ),
 .VDD( dVDD ),
 .GND( dGND )
);


encoder_16_to_4
x6 ( 
 .neu_addr( {aer_o[0],aer_o[1],aer_o[2],aer_o[3]} ),
 .ack_neu( {ack_neu[0],ack_neu[1],ack_neu[2],ack_neu[3],ack_neu[4],ack_neu[5],ack_neu[6],ack_neu[7],ack_neu[8],ack_neu[9],ack_neu[10],ack_neu[11],ack_neu[12],ack_neu[13],ack_neu[14],ack_neu[15]} ),
 .VDD( dVDD ),
 .GND( dGND )
);


inputs_latch_16neu
x3 ( 
 .req_inp( req_inp ),
 .syn_addr_latched( {syn_addr_latched[0],syn_addr_latched[1],syn_addr_latched[2],syn_addr_latched[3]} ),
 .syn_addr_in( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .nRes( nRes ),
 .neu_addr_latched( {neu_addr_latched[0],neu_addr_latched[1],neu_addr_latched[2],neu_addr_latched[3]} ),
 .neu_addr_in( {neu_addr[0],neu_addr[1],neu_addr[2],neu_addr[3]} ),
 .exc_latched( exc_latched ),
 .exc_in( exc ),
 .req_in_array( req_inp_array ),
 .VDD( dVDD ),
 .GND( dGND )
);


monitor_select
x8 ( 
 .dVDD( dVDD ),
 .Da( Da ),
 .CLK( CLK ),
 .dGND( dGND ),
 .nRes( nRes ),
 .monOUT( monout ),
 .inputAnalog( {monout[0],monout[1],monout[2],monout[3],monout[4],monout[5],monout[6],monout[7],monout[8],monout[9],monout[10],monout[11],monout[12],monout[13],monout[14],monout[15]} )
);


input_neuron_address_decoder_16_to_1
x7 ( 
 .neu_addr( {neu_addr_latched[0],neu_addr_latched[1],neu_addr_latched[2],neu_addr_latched[3]} ),
 .req_neu( {neu_req[0],neu_req[1],neu_req[2],neu_req[3],neu_req[4],neu_req[5],neu_req[6],neu_req[7],neu_req[8],neu_req[9],neu_req[10],neu_req[11],neu_req[12],neu_req[13],neu_req[14],neu_req[15]} ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .req_inp( req_inp_array )
);

endmodule

// expanding   symbol:  neuro_synaptic_core_16neu_32syn_v1.sym # of pins=26
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/neuro_synaptic_core_16neu_32syn_v1.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/neuro_synaptic_core_16neu_32syn_v1.sch
module neuro_synaptic_core_16neu_32syn_v1
(
  input wire [0:3] JInhWp,
  input wire bufmonp,
  input wire ifdcp,
  input wire [0:3] JExcWn,
  input wire [0:3] W,
  input wire [0:3] syn_addr,
  input wire [0:15] ack_neu,
  input wire vleakn,
  input wire vipulseextp,
  input wire vepulseextp,
  inout wire [0:15] monout,
  input wire resetW,
  input wire [0:15] neu_req,
  input wire vrefn,
  output wire [0:15] req_neu_out,
  input wire vthrdn,
  input wire vthrdp,
  input wire setW,
  input wire exc,
  input wire vtaup,
  input wire vtaun,
  inout wire aGND,
  inout wire dGND,
  inout wire aVDD,
  inout wire dVDD,
  input wire nRes
);

neuron_32syn_v1
x4_0 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[0] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[0] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[0] ),
 .nRes( nRes ),
 .req( req_neu_out[0] )
);


neuron_32syn_v1
x4_1 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[1] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[1] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[1] ),
 .nRes( nRes ),
 .req( req_neu_out[1] )
);


neuron_32syn_v1
x4_2 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[2] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[2] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[2] ),
 .nRes( nRes ),
 .req( req_neu_out[2] )
);


neuron_32syn_v1
x4_3 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[3] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[3] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[3] ),
 .nRes( nRes ),
 .req( req_neu_out[3] )
);


neuron_32syn_v1
x4_4 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[4] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[4] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[4] ),
 .nRes( nRes ),
 .req( req_neu_out[4] )
);


neuron_32syn_v1
x4_5 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[5] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[5] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[5] ),
 .nRes( nRes ),
 .req( req_neu_out[5] )
);


neuron_32syn_v1
x4_6 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[6] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[6] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[6] ),
 .nRes( nRes ),
 .req( req_neu_out[6] )
);


neuron_32syn_v1
x4_7 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[7] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[7] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[7] ),
 .nRes( nRes ),
 .req( req_neu_out[7] )
);


neuron_32syn_v1
x4_8 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[8] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[8] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[8] ),
 .nRes( nRes ),
 .req( req_neu_out[8] )
);


neuron_32syn_v1
x4_9 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[9] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[9] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[9] ),
 .nRes( nRes ),
 .req( req_neu_out[9] )
);


neuron_32syn_v1
x4_10 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[10] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[10] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[10] ),
 .nRes( nRes ),
 .req( req_neu_out[10] )
);


neuron_32syn_v1
x4_11 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[11] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[11] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[11] ),
 .nRes( nRes ),
 .req( req_neu_out[11] )
);


neuron_32syn_v1
x4_12 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[12] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[12] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[12] ),
 .nRes( nRes ),
 .req( req_neu_out[12] )
);


neuron_32syn_v1
x4_13 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[13] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[13] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[13] ),
 .nRes( nRes ),
 .req( req_neu_out[13] )
);


neuron_32syn_v1
x4_14 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[14] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[14] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[14] ),
 .nRes( nRes ),
 .req( req_neu_out[14] )
);


neuron_32syn_v1
x4_15 ( 
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .ifdcp( ifdcp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .buffermonp( bufmonp ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vleakn( vleakn ),
 .vipulseextp( vipulseextp ),
 .monout( monout[15] ),
 .vepulseextp( vepulseextp ),
 .resetW( resetW ),
 .syn_req( neu_req[15] ),
 .vtaun( vtaun ),
 .vrefn( vrefn ),
 .setW( setW ),
 .vtaup( vtaup ),
 .vthrdp( vthrdp ),
 .exc( exc ),
 .vthrdn( vthrdn ),
 .dGND( dGND ),
 .dVDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND ),
 .ack_out( ack_neu[15] ),
 .nRes( nRes ),
 .req( req_neu_out[15] )
);

endmodule

// expanding   symbol:  arbiter_tree_sixteen_bits.sym # of pins=6
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/arbiter_tree_sixteen_bits.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/arbiter_tree_sixteen_bits.sch
module arbiter_tree_sixteen_bits
(
  input wire [0:15] req,
  input wire ack_cpu,
  output wire [0:15] ack,
  output wire req_cpu,
  inout wire VDD,
  inout wire GND
);
wire [7:0] net1 ;
wire [7:0] net2 ;
wire [3:0] net3 ;
wire [3:0] net4 ;
wire [1:0] net5 ;
wire [1:0] net6 ;


arbiter_two_bits
x3 ( 
 .req( net5 ),
 .ack_cpu( ack_cpu ),
 .ack( net6 ),
 .req_cpu( req_cpu ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x1_0 ( 
 .req( net4[3:2] ),
 .ack_cpu( net6[1] ),
 .ack( net3[3:2] ),
 .req_cpu( net5[1] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x1_1 ( 
 .req( net4[1:0] ),
 .ack_cpu( net6[0] ),
 .ack( net3[1:0] ),
 .req_cpu( net5[0] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x2_0 ( 
 .req( net1[7:6] ),
 .ack_cpu( net3[3] ),
 .ack( net2[7:6] ),
 .req_cpu( net4[3] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x2_1 ( 
 .req( net1[5:4] ),
 .ack_cpu( net3[2] ),
 .ack( net2[5:4] ),
 .req_cpu( net4[2] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x2_2 ( 
 .req( net1[3:2] ),
 .ack_cpu( net3[1] ),
 .ack( net2[3:2] ),
 .req_cpu( net4[1] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x2_3 ( 
 .req( net1[1:0] ),
 .ack_cpu( net3[0] ),
 .ack( net2[1:0] ),
 .req_cpu( net4[0] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x3_0 ( 
 .req( {req[0],req[1]} ),
 .ack_cpu( net2[7] ),
 .ack( {ack[0],ack[1]} ),
 .req_cpu( net1[7] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x3_1 ( 
 .req( {req[2],req[3]} ),
 .ack_cpu( net2[6] ),
 .ack( {ack[2],ack[3]} ),
 .req_cpu( net1[6] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x3_2 ( 
 .req( {req[4],req[5]} ),
 .ack_cpu( net2[5] ),
 .ack( {ack[4],ack[5]} ),
 .req_cpu( net1[5] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x3_3 ( 
 .req( {req[6],req[7]} ),
 .ack_cpu( net2[4] ),
 .ack( {ack[6],ack[7]} ),
 .req_cpu( net1[4] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x3_4 ( 
 .req( {req[8],req[9]} ),
 .ack_cpu( net2[3] ),
 .ack( {ack[8],ack[9]} ),
 .req_cpu( net1[3] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x3_5 ( 
 .req( {req[10],req[11]} ),
 .ack_cpu( net2[2] ),
 .ack( {ack[10],ack[11]} ),
 .req_cpu( net1[2] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x3_6 ( 
 .req( {req[12],req[13]} ),
 .ack_cpu( net2[1] ),
 .ack( {ack[12],ack[13]} ),
 .req_cpu( net1[1] ),
 .VDD( VDD ),
 .GND( GND )
);


arbiter_two_bits
x3_7 ( 
 .req( {req[14],req[15]} ),
 .ack_cpu( net2[0] ),
 .ack( {ack[14],ack[15]} ),
 .req_cpu( net1[0] ),
 .VDD( VDD ),
 .GND( GND )
);

endmodule

// expanding   symbol:  encoder_16_to_4.sym # of pins=4
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/encoder_16_to_4.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/encoder_16_to_4.sch
module encoder_16_to_4
(
  output wire [0:3] neu_addr,
  input wire [0:15] ack_neu,
  inout wire VDD,
  inout wire GND
);

or8
x1 ( 
 .h( ack_neu[8] ),
 .g( ack_neu[9] ),
 .f( ack_neu[10] ),
 .e( ack_neu[11] ),
 .out( neu_addr[3] ),
 .d( ack_neu[12] ),
 .c( ack_neu[13] ),
 .b( ack_neu[14] ),
 .a( ack_neu[15] ),
 .VDD( VDD ),
 .GND( GND )
);


or8
x2 ( 
 .h( ack_neu[4] ),
 .g( ack_neu[5] ),
 .f( ack_neu[6] ),
 .e( ack_neu[7] ),
 .out( neu_addr[2] ),
 .d( ack_neu[12] ),
 .c( ack_neu[13] ),
 .b( ack_neu[14] ),
 .a( ack_neu[15] ),
 .VDD( VDD ),
 .GND( GND )
);


or8
x3 ( 
 .h( ack_neu[2] ),
 .g( ack_neu[3] ),
 .f( ack_neu[6] ),
 .e( ack_neu[7] ),
 .out( neu_addr[1] ),
 .d( ack_neu[10] ),
 .c( ack_neu[11] ),
 .b( ack_neu[14] ),
 .a( ack_neu[15] ),
 .VDD( VDD ),
 .GND( GND )
);


or8
x4 ( 
 .h( ack_neu[1] ),
 .g( ack_neu[3] ),
 .f( ack_neu[5] ),
 .e( ack_neu[7] ),
 .out( neu_addr[0] ),
 .d( ack_neu[9] ),
 .c( ack_neu[11] ),
 .b( ack_neu[13] ),
 .a( ack_neu[15] ),
 .VDD( VDD ),
 .GND( GND )
);

endmodule

// expanding   symbol:  inputs_latch_16neu.sym # of pins=11
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/inputs_latch_16neu.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/inputs_latch_16neu.sch
module inputs_latch_16neu
(
  input wire req_inp,
  output wire [0:3] syn_addr_latched,
  input wire [0:3] syn_addr_in,
  input wire nRes,
  output wire [0:3] neu_addr_latched,
  input wire [0:3] neu_addr_in,
  output wire exc_latched,
  input wire exc_in,
  output wire req_in_array,
  inout wire VDD,
  inout wire GND
);
wire net1 ;
wire net2 ;
wire net3 ;


sky130_fd_sc_hd__dfrtp_1
x2_0 ( 
 .CLK( req_inp ),
 .D( syn_addr_in[0] ),
 .RESET_B( nRes ),
 .Q( syn_addr_latched[0] )
);


sky130_fd_sc_hd__dfrtp_1
x2_1 ( 
 .CLK( req_inp ),
 .D( syn_addr_in[1] ),
 .RESET_B( nRes ),
 .Q( syn_addr_latched[1] )
);


sky130_fd_sc_hd__dfrtp_1
x2_2 ( 
 .CLK( req_inp ),
 .D( syn_addr_in[2] ),
 .RESET_B( nRes ),
 .Q( syn_addr_latched[2] )
);


sky130_fd_sc_hd__dfrtp_1
x2_3 ( 
 .CLK( req_inp ),
 .D( syn_addr_in[3] ),
 .RESET_B( nRes ),
 .Q( syn_addr_latched[3] )
);


sky130_fd_sc_hd__dfrtp_1
x1_0 ( 
 .CLK( req_inp ),
 .D( neu_addr_in[0] ),
 .RESET_B( nRes ),
 .Q( neu_addr_latched[0] )
);


sky130_fd_sc_hd__dfrtp_1
x1_1 ( 
 .CLK( req_inp ),
 .D( neu_addr_in[1] ),
 .RESET_B( nRes ),
 .Q( neu_addr_latched[1] )
);


sky130_fd_sc_hd__dfrtp_1
x1_2 ( 
 .CLK( req_inp ),
 .D( neu_addr_in[2] ),
 .RESET_B( nRes ),
 .Q( neu_addr_latched[2] )
);


sky130_fd_sc_hd__dfrtp_1
x1_3 ( 
 .CLK( req_inp ),
 .D( neu_addr_in[3] ),
 .RESET_B( nRes ),
 .Q( neu_addr_latched[3] )
);


sky130_fd_sc_hd__dfrtp_1
x3 ( 
 .CLK( req_inp ),
 .D( exc_in ),
 .RESET_B( nRes ),
 .Q( exc_latched )
);


sky130_fd_sc_hd__inv_1
x7 ( 
 .A( req_inp ),
 .Y( net1 )
);


sky130_fd_sc_hd__inv_1
x1 ( 
 .A( net1 ),
 .Y( net2 )
);


sky130_fd_sc_hd__inv_1
x2 ( 
 .A( net2 ),
 .Y( net3 )
);


sky130_fd_sc_hd__inv_1
x4 ( 
 .A( net3 ),
 .Y( req_in_array )
);

endmodule

// expanding   symbol:  monitor_select.sym # of pins=7
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/monitor_select.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/monitor_select.sch
module monitor_select
(
  inout wire dVDD,
  input wire Da,
  input wire CLK,
  inout wire dGND,
  input wire nRes,
  inout wire monOUT,
  inout wire [0:15] inputAnalog
);
wire [3:0] net1 ;
wire [15:0] net2 ;
wire net3 ;


decoder_4_to_16
x1 ( 
 .A( net1 ),
 .D( net2 ),
 .req( dGND ),
 .req_syn( net3 ),
 .dVDD( dVDD ),
 .dGND( dGND )
);


analog_mux_16_to_1
x2 ( 
 .VDD( dVDD ),
 .inputAnalog( {inputAnalog[0],inputAnalog[1],inputAnalog[2],inputAnalog[3],inputAnalog[4],inputAnalog[5],inputAnalog[6],inputAnalog[7],inputAnalog[8],inputAnalog[9],inputAnalog[10],inputAnalog[11],inputAnalog[12],inputAnalog[13],inputAnalog[14],inputAnalog[15]} ),
 .GND( dGND ),
 .OUT( monOUT ),
 .inputAddress( net2 )
);


dflip_flop_chain_4_fc_nolatch
x3 ( 
 .D( net1 ),
 .Da( Da ),
 .CLK( CLK ),
 .nRes( nRes ),
 .VDD( dVDD ),
 .GND( dGND )
);

endmodule

// expanding   symbol:  input_neuron_address_decoder_16_to_1.sym # of pins=5
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/input_neuron_address_decoder_16_to_1.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/input_neuron_address_decoder_16_to_1.sch
module input_neuron_address_decoder_16_to_1
(
  input wire [0:3] neu_addr,
  output wire [0:15] req_neu,
  inout wire dGND,
  inout wire dVDD,
  input wire req_inp
);
wire net1 ;
wire [15:0] net2 ;


decoder_4_to_16
x2 ( 
 .A( {neu_addr[0],neu_addr[1],neu_addr[2],neu_addr[3]} ),
 .D( net2 ),
 .req( req_inp ),
 .req_syn( net1 ),
 .dVDD( dVDD ),
 .dGND( dGND )
);


request_logic_delay
x4 ( 
 .A( net2 ),
 .O( {req_neu[0],req_neu[1],req_neu[2],req_neu[3],req_neu[4],req_neu[5],req_neu[6],req_neu[7],req_neu[8],req_neu[9],req_neu[10],req_neu[11],req_neu[12],req_neu[13],req_neu[14],req_neu[15]} ),
 .req( net1 ),
 .dVDD( dVDD ),
 .dGND( dGND )
);

endmodule

// expanding   symbol:  neuron_32syn_v1.sym # of pins=26
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/neuron_32syn_v1.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/neuron_32syn_v1.sch
module neuron_32syn_v1
(
  input wire [0:3] JExcWn,
  input wire ifdcp,
  input wire [0:3] W,
  input wire [0:3] JInhWp,
  input wire buffermonp,
  input wire [0:3] syn_addr,
  input wire vleakn,
  input wire vipulseextp,
  inout wire monout,
  input wire vepulseextp,
  input wire resetW,
  input wire syn_req,
  input wire vtaun,
  input wire vrefn,
  input wire setW,
  input wire vtaup,
  input wire vthrdp,
  input wire exc,
  input wire vthrdn,
  inout wire dGND,
  inout wire dVDD,
  inout wire aVDD,
  inout wire aGND,
  input wire ack_out,
  input wire nRes,
  output wire req
);
wire resetWe ;
wire resetWi ;
wire ack_cel1 ;
wire reqe ;
wire reqi ;
wire nreq_neu1 ;
wire net1 ;
wire net2 ;
wire setWe ;
wire setWi ;
wire nExc ;


c_element_rj
x11 ( 
 .nrst( nRes ),
 .a( req ),
 .b( ack_out ),
 .c( ack_cel1 ),
 .dVDD( dVDD ),
 .dGND( dGND )
);


sky130_fd_sc_hd__and2_1
x4 ( 
 .A( setW ),
 .B( exc ),
 .X( setWe )
);


sky130_fd_sc_hd__inv_1
x5 ( 
 .A( exc ),
 .Y( nExc )
);


sky130_fd_sc_hd__and2_1
x6 ( 
 .A( setW ),
 .B( nExc ),
 .X( setWi )
);


sky130_fd_sc_hd__and2_1
x7 ( 
 .A( resetW ),
 .B( exc ),
 .X( resetWe )
);


sky130_fd_sc_hd__and2_1
x8 ( 
 .A( resetW ),
 .B( nExc ),
 .X( resetWi )
);


sky130_fd_sc_hd__and2_1
x10 ( 
 .A( syn_req ),
 .B( exc ),
 .X( reqe )
);


sky130_fd_sc_hd__and2_1
x12 ( 
 .A( syn_req ),
 .B( nExc ),
 .X( reqi )
);


sky130_fd_sc_hd__inv_1
x14 ( 
 .A( ack_cel1 ),
 .Y( net2 )
);


synapse_array_programmable_16_to_sout_v1
x1 ( 
 .W( {W[0],W[1],W[2],W[3]} ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .sout( net1 ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vpulseextp( vepulseextp ),
 .resetW( resetWe ),
 .req( reqe ),
 .setW( setWe ),
 .vthrdn( vthrdn ),
 .vtaup( vtaup ),
 .GND( dGND ),
 .VDD( dVDD ),
 .aGND( aGND ),
 .aVDD( aVDD )
);


synapse_array_programmable_inh_16_to_sout_v1
x2 ( 
 .sout( net1 ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .syn_addr( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .vpulseextp( vipulseextp ),
 .resetW( resetWi ),
 .req( reqi ),
 .vthrdp( vthrdp ),
 .setW( setWi ),
 .vtaun( vtaun ),
 .GND( dGND ),
 .VDD( dVDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


schmitt_trigger
x9 ( 
 .A( nreq_neu1 ),
 .Y( req ),
 .VDD( dVDD ),
 .GND( dGND )
);


neuron_analog_fc_v2_norail
x3 ( 
 .GND( aGND ),
 .VDD( aVDD ),
 .nreq( nreq_neu1 ),
 .ifdcp( ifdcp ),
 .nack( net2 ),
 .vmem( net1 ),
 .vleakn( vleakn ),
 .vrefn( vrefn )
);


buffer_mon_p_norail
x13 ( 
 .buf_p( buffermonp ),
 .out( monout ),
 .mon( net1 ),
 .GND( aGND ),
 .AVDD( aVDD )
);

endmodule

// expanding   symbol:  arbiter_two_bits.sym # of pins=6
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/arbiter_two_bits.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/arbiter_two_bits.sch
module arbiter_two_bits
(
  input wire [0:1] req,
  input wire ack_cpu,
  output wire [0:1] ack,
  output wire req_cpu,
  inout wire VDD,
  inout wire GND
);

arbiter_cell_two_bits_fc
x1 ( 
 .g1( ack[1] ),
 .g0( ack[0] ),
 .gc( ack_cpu ),
 .rc( req_cpu ),
 .r0( req[0] ),
 .r1( req[1] ),
 .VDD( VDD ),
 .GND( GND )
);

endmodule

// expanding   symbol:  or8.sym # of pins=11
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/or8.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/or8.sch
module or8
(
  input wire h,
  input wire g,
  input wire f,
  input wire e,
  output wire out,
  input wire d,
  input wire c,
  input wire b,
  input wire a,
  inout wire VDD,
  inout wire GND
);
wire net1 ;
wire net2 ;


sky130_fd_sc_hd__or4_1
x1 ( 
 .A( h ),
 .B( g ),
 .C( f ),
 .D( e ),
 .X( net1 )
);


sky130_fd_sc_hd__or4_1
x2 ( 
 .A( d ),
 .B( c ),
 .C( b ),
 .D( a ),
 .X( net2 )
);


sky130_fd_sc_hd__or2_1
x3 ( 
 .A( net1 ),
 .B( net2 ),
 .X( out )
);

endmodule

// expanding   symbol:  decoder_4_to_16.sym # of pins=6
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/decoder_4_to_16.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/decoder_4_to_16.sch
module decoder_4_to_16
(
  input wire [0:3] A,
  output wire [0:15] D,
  input wire req,
  output wire req_syn,
  inout wire dVDD,
  inout wire dGND
);
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire net5 ;
wire net6 ;
wire net7 ;


sky130_fd_sc_hd__inv_1
x21 ( 
 .A( req ),
 .Y( net5 )
);


sky130_fd_sc_hd__inv_1
x22 ( 
 .A( net5 ),
 .Y( net6 )
);


sky130_fd_sc_hd__inv_1
x23 ( 
 .A( net6 ),
 .Y( net7 )
);


sky130_fd_sc_hd__inv_1
x24 ( 
 .A( net7 ),
 .Y( req_syn )
);


sky130_fd_sc_hd__and4_1
x20 ( 
 .A( A[3] ),
 .B( A[2] ),
 .C( A[1] ),
 .D( A[0] ),
 .X( D[15] )
);


sky130_fd_sc_hd__and4_1
x19 ( 
 .A( A[3] ),
 .B( A[2] ),
 .C( A[1] ),
 .D( net4 ),
 .X( D[14] )
);


sky130_fd_sc_hd__and4_1
x18 ( 
 .A( A[3] ),
 .B( A[2] ),
 .C( net3 ),
 .D( A[0] ),
 .X( D[13] )
);


sky130_fd_sc_hd__and4_1
x17 ( 
 .A( A[3] ),
 .B( A[2] ),
 .C( net3 ),
 .D( net4 ),
 .X( D[12] )
);


sky130_fd_sc_hd__and4_1
x16 ( 
 .A( A[3] ),
 .B( net2 ),
 .C( A[1] ),
 .D( A[0] ),
 .X( D[11] )
);


sky130_fd_sc_hd__and4_1
x15 ( 
 .A( A[3] ),
 .B( net2 ),
 .C( A[1] ),
 .D( net4 ),
 .X( D[10] )
);


sky130_fd_sc_hd__and4_1
x13 ( 
 .A( A[3] ),
 .B( net2 ),
 .C( net3 ),
 .D( A[0] ),
 .X( D[9] )
);


sky130_fd_sc_hd__and4_1
x4 ( 
 .A( A[3] ),
 .B( net2 ),
 .C( net3 ),
 .D( net4 ),
 .X( D[8] )
);


sky130_fd_sc_hd__and4_1
x5 ( 
 .A( net1 ),
 .B( A[2] ),
 .C( A[1] ),
 .D( A[0] ),
 .X( D[7] )
);


sky130_fd_sc_hd__and4_1
x6 ( 
 .A( net1 ),
 .B( A[2] ),
 .C( A[1] ),
 .D( net4 ),
 .X( D[6] )
);


sky130_fd_sc_hd__and4_1
x8 ( 
 .A( net1 ),
 .B( A[2] ),
 .C( net3 ),
 .D( net4 ),
 .X( D[4] )
);


sky130_fd_sc_hd__and4_1
x9 ( 
 .A( net1 ),
 .B( net2 ),
 .C( A[1] ),
 .D( net4 ),
 .X( D[2] )
);


sky130_fd_sc_hd__and4_1
x10 ( 
 .A( net1 ),
 .B( net2 ),
 .C( net3 ),
 .D( net4 ),
 .X( D[0] )
);


sky130_fd_sc_hd__and4_1
x11 ( 
 .A( net1 ),
 .B( net2 ),
 .C( net3 ),
 .D( A[0] ),
 .X( D[1] )
);


sky130_fd_sc_hd__and4_1
x12 ( 
 .A( net1 ),
 .B( net2 ),
 .C( A[1] ),
 .D( A[0] ),
 .X( D[3] )
);


sky130_fd_sc_hd__and4_1
x14 ( 
 .A( net1 ),
 .B( A[2] ),
 .C( net3 ),
 .D( A[0] ),
 .X( D[5] )
);


sky130_fd_sc_hd__inv_4
x1 ( 
 .A( A[3] ),
 .Y( net1 )
);


sky130_fd_sc_hd__inv_4
x2 ( 
 .A( A[2] ),
 .Y( net2 )
);


sky130_fd_sc_hd__inv_4
x3 ( 
 .A( A[1] ),
 .Y( net3 )
);


sky130_fd_sc_hd__inv_4
x7 ( 
 .A( A[0] ),
 .Y( net4 )
);

endmodule

// expanding   symbol:  analog_mux_16_to_1.sym # of pins=5
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/analog_mux_16_to_1.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/analog_mux_16_to_1.sch
module analog_mux_16_to_1
(
  inout wire VDD,
  inout wire [0:15] inputAnalog,
  inout wire GND,
  inout wire OUT,
  input wire [0:15] inputAddress
);
wire [15:0] net1 ;


tg
x1_0 ( 
 .nEn( net1[15] ),
 .OUT( OUT ),
 .IN( inputAnalog[0] ),
 .EN( inputAddress[0] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_1 ( 
 .nEn( net1[14] ),
 .OUT( OUT ),
 .IN( inputAnalog[1] ),
 .EN( inputAddress[1] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_2 ( 
 .nEn( net1[13] ),
 .OUT( OUT ),
 .IN( inputAnalog[2] ),
 .EN( inputAddress[2] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_3 ( 
 .nEn( net1[12] ),
 .OUT( OUT ),
 .IN( inputAnalog[3] ),
 .EN( inputAddress[3] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_4 ( 
 .nEn( net1[11] ),
 .OUT( OUT ),
 .IN( inputAnalog[4] ),
 .EN( inputAddress[4] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_5 ( 
 .nEn( net1[10] ),
 .OUT( OUT ),
 .IN( inputAnalog[5] ),
 .EN( inputAddress[5] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_6 ( 
 .nEn( net1[9] ),
 .OUT( OUT ),
 .IN( inputAnalog[6] ),
 .EN( inputAddress[6] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_7 ( 
 .nEn( net1[8] ),
 .OUT( OUT ),
 .IN( inputAnalog[7] ),
 .EN( inputAddress[7] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_8 ( 
 .nEn( net1[7] ),
 .OUT( OUT ),
 .IN( inputAnalog[8] ),
 .EN( inputAddress[8] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_9 ( 
 .nEn( net1[6] ),
 .OUT( OUT ),
 .IN( inputAnalog[9] ),
 .EN( inputAddress[9] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_10 ( 
 .nEn( net1[5] ),
 .OUT( OUT ),
 .IN( inputAnalog[10] ),
 .EN( inputAddress[10] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_11 ( 
 .nEn( net1[4] ),
 .OUT( OUT ),
 .IN( inputAnalog[11] ),
 .EN( inputAddress[11] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_12 ( 
 .nEn( net1[3] ),
 .OUT( OUT ),
 .IN( inputAnalog[12] ),
 .EN( inputAddress[12] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_13 ( 
 .nEn( net1[2] ),
 .OUT( OUT ),
 .IN( inputAnalog[13] ),
 .EN( inputAddress[13] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_14 ( 
 .nEn( net1[1] ),
 .OUT( OUT ),
 .IN( inputAnalog[14] ),
 .EN( inputAddress[14] ),
 .GND( GND ),
 .VDD( VDD )
);


tg
x1_15 ( 
 .nEn( net1[0] ),
 .OUT( OUT ),
 .IN( inputAnalog[15] ),
 .EN( inputAddress[15] ),
 .GND( GND ),
 .VDD( VDD )
);


sky130_fd_sc_hd__inv_1
x16_0 ( 
 .A( inputAddress[0] ),
 .Y( net1[15] )
);


sky130_fd_sc_hd__inv_1
x16_1 ( 
 .A( inputAddress[1] ),
 .Y( net1[14] )
);


sky130_fd_sc_hd__inv_1
x16_2 ( 
 .A( inputAddress[2] ),
 .Y( net1[13] )
);


sky130_fd_sc_hd__inv_1
x16_3 ( 
 .A( inputAddress[3] ),
 .Y( net1[12] )
);


sky130_fd_sc_hd__inv_1
x16_4 ( 
 .A( inputAddress[4] ),
 .Y( net1[11] )
);


sky130_fd_sc_hd__inv_1
x16_5 ( 
 .A( inputAddress[5] ),
 .Y( net1[10] )
);


sky130_fd_sc_hd__inv_1
x16_6 ( 
 .A( inputAddress[6] ),
 .Y( net1[9] )
);


sky130_fd_sc_hd__inv_1
x16_7 ( 
 .A( inputAddress[7] ),
 .Y( net1[8] )
);


sky130_fd_sc_hd__inv_1
x16_8 ( 
 .A( inputAddress[8] ),
 .Y( net1[7] )
);


sky130_fd_sc_hd__inv_1
x16_9 ( 
 .A( inputAddress[9] ),
 .Y( net1[6] )
);


sky130_fd_sc_hd__inv_1
x16_10 ( 
 .A( inputAddress[10] ),
 .Y( net1[5] )
);


sky130_fd_sc_hd__inv_1
x16_11 ( 
 .A( inputAddress[11] ),
 .Y( net1[4] )
);


sky130_fd_sc_hd__inv_1
x16_12 ( 
 .A( inputAddress[12] ),
 .Y( net1[3] )
);


sky130_fd_sc_hd__inv_1
x16_13 ( 
 .A( inputAddress[13] ),
 .Y( net1[2] )
);


sky130_fd_sc_hd__inv_1
x16_14 ( 
 .A( inputAddress[14] ),
 .Y( net1[1] )
);


sky130_fd_sc_hd__inv_1
x16_15 ( 
 .A( inputAddress[15] ),
 .Y( net1[0] )
);

endmodule

// expanding   symbol:  dflip_flop_chain_4_fc_nolatch.sym # of pins=6
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/dflip_flop_chain_4_fc_nolatch.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/dflip_flop_chain_4_fc_nolatch.sch
module dflip_flop_chain_4_fc_nolatch
(
  output wire [0:3] D,
  input wire Da,
  input wire CLK,
  input wire nRes,
  inout wire VDD,
  inout wire GND
);

sky130_fd_sc_hd__dfrtp_1
x1_0 ( 
 .CLK( CLK ),
 .D( Da ),
 .RESET_B( nRes ),
 .Q( D[0] )
);


sky130_fd_sc_hd__dfrtp_1
x1_1 ( 
 .CLK( CLK ),
 .D( D[0] ),
 .RESET_B( nRes ),
 .Q( D[1] )
);


sky130_fd_sc_hd__dfrtp_1
x1_2 ( 
 .CLK( CLK ),
 .D( D[1] ),
 .RESET_B( nRes ),
 .Q( D[2] )
);


sky130_fd_sc_hd__dfrtp_1
x1_3 ( 
 .CLK( CLK ),
 .D( D[2] ),
 .RESET_B( nRes ),
 .Q( D[3] )
);

endmodule

// expanding   symbol:  request_logic_delay.sym # of pins=5
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/request_logic_delay.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/request_logic_delay.sch
module request_logic_delay
(
  input wire [0:15] A,
  output wire [0:15] O,
  input wire req,
  inout wire dVDD,
  inout wire dGND
);

sky130_fd_sc_hd__and2_1
x1_0 ( 
 .A( A[0] ),
 .B( req ),
 .X( O[0] )
);


sky130_fd_sc_hd__and2_1
x1_1 ( 
 .A( A[1] ),
 .B( req ),
 .X( O[1] )
);


sky130_fd_sc_hd__and2_1
x1_2 ( 
 .A( A[2] ),
 .B( req ),
 .X( O[2] )
);


sky130_fd_sc_hd__and2_1
x1_3 ( 
 .A( A[3] ),
 .B( req ),
 .X( O[3] )
);


sky130_fd_sc_hd__and2_1
x1_4 ( 
 .A( A[4] ),
 .B( req ),
 .X( O[4] )
);


sky130_fd_sc_hd__and2_1
x1_5 ( 
 .A( A[5] ),
 .B( req ),
 .X( O[5] )
);


sky130_fd_sc_hd__and2_1
x1_6 ( 
 .A( A[6] ),
 .B( req ),
 .X( O[6] )
);


sky130_fd_sc_hd__and2_1
x1_7 ( 
 .A( A[7] ),
 .B( req ),
 .X( O[7] )
);


sky130_fd_sc_hd__and2_1
x1_8 ( 
 .A( A[8] ),
 .B( req ),
 .X( O[8] )
);


sky130_fd_sc_hd__and2_1
x1_9 ( 
 .A( A[9] ),
 .B( req ),
 .X( O[9] )
);


sky130_fd_sc_hd__and2_1
x1_10 ( 
 .A( A[10] ),
 .B( req ),
 .X( O[10] )
);


sky130_fd_sc_hd__and2_1
x1_11 ( 
 .A( A[11] ),
 .B( req ),
 .X( O[11] )
);


sky130_fd_sc_hd__and2_1
x1_12 ( 
 .A( A[12] ),
 .B( req ),
 .X( O[12] )
);


sky130_fd_sc_hd__and2_1
x1_13 ( 
 .A( A[13] ),
 .B( req ),
 .X( O[13] )
);


sky130_fd_sc_hd__and2_1
x1_14 ( 
 .A( A[14] ),
 .B( req ),
 .X( O[14] )
);


sky130_fd_sc_hd__and2_1
x1_15 ( 
 .A( A[15] ),
 .B( req ),
 .X( O[15] )
);

endmodule

// expanding   symbol:  c_element_rj.sym # of pins=6
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/c_element_rj.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/c_element_rj.sch
module c_element_rj
(
  input wire nrst,
  input wire a,
  input wire b,
  output wire c,
  inout wire dVDD,
  inout wire dGND
);
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire net5 ;
wire net6 ;



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M14 ( 
 .D( c ),
 .G( net6 ),
 .S( dVDD ),
 .B( dVDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( net6 ),
 .G( nrst ),
 .S( dVDD ),
 .B( dVDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M6 ( 
 .D( net5 ),
 .G( b ),
 .S( dVDD ),
 .B( dVDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( net4 ),
 .G( a ),
 .S( dVDD ),
 .B( dVDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M7 ( 
 .D( net3 ),
 .G( b ),
 .S( net4 ),
 .B( dVDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M8 ( 
 .D( net3 ),
 .G( a ),
 .S( net5 ),
 .B( dVDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M10 ( 
 .D( net5 ),
 .G( c ),
 .S( net4 ),
 .B( dVDD )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M12 ( 
 .D( c ),
 .G( net6 ),
 .S( dGND ),
 .B( dGND )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( net3 ),
 .G( nrst ),
 .S( net6 ),
 .B( dGND )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( net3 ),
 .G( b ),
 .S( net1 ),
 .B( dGND )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( net3 ),
 .G( a ),
 .S( net2 ),
 .B( dGND )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M9 ( 
 .D( net2 ),
 .G( c ),
 .S( net1 ),
 .B( dGND )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M11 ( 
 .D( net1 ),
 .G( a ),
 .S( dGND ),
 .B( dGND )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M13 ( 
 .D( net2 ),
 .G( b ),
 .S( dGND ),
 .B( dGND )
);

endmodule

// expanding   symbol:  synapse_array_programmable_16_to_sout_v1.sym # of pins=14
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/synapse_array_programmable_16_to_sout_v1.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/synapse_array_programmable_16_to_sout_v1.sch
module synapse_array_programmable_16_to_sout_v1
(
  input wire [0:3] W,
  input wire [0:3] JExcWn,
  inout wire sout,
  input wire [0:3] syn_addr,
  input wire vpulseextp,
  input wire resetW,
  input wire req,
  input wire setW,
  input wire vthrdn,
  input wire vtaup,
  inout wire GND,
  inout wire VDD,
  inout wire aGND,
  inout wire aVDD
);
wire req_syn ;
wire [15:0] D ;
wire [15:0] net1 ;
wire [15:0] net2 ;


decoder_4_to_16
x3 ( 
 .A( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .D( {D[0],D[1],D[2],D[3],D[4],D[5],D[6],D[7],D[8],D[9],D[10],D[11],D[12],D[13],D[14],D[15]} ),
 .req( req ),
 .req_syn( req_syn ),
 .dVDD( VDD ),
 .dGND( GND )
);


sky130_fd_sc_hd__and2_1
x2_0 ( 
 .A( req_syn ),
 .B( D[0] ),
 .X( net1[15] )
);


sky130_fd_sc_hd__and2_1
x2_1 ( 
 .A( req_syn ),
 .B( D[1] ),
 .X( net1[14] )
);


sky130_fd_sc_hd__and2_1
x2_2 ( 
 .A( req_syn ),
 .B( D[2] ),
 .X( net1[13] )
);


sky130_fd_sc_hd__and2_1
x2_3 ( 
 .A( req_syn ),
 .B( D[3] ),
 .X( net1[12] )
);


sky130_fd_sc_hd__and2_1
x2_4 ( 
 .A( req_syn ),
 .B( D[4] ),
 .X( net1[11] )
);


sky130_fd_sc_hd__and2_1
x2_5 ( 
 .A( req_syn ),
 .B( D[5] ),
 .X( net1[10] )
);


sky130_fd_sc_hd__and2_1
x2_6 ( 
 .A( req_syn ),
 .B( D[6] ),
 .X( net1[9] )
);


sky130_fd_sc_hd__and2_1
x2_7 ( 
 .A( req_syn ),
 .B( D[7] ),
 .X( net1[8] )
);


sky130_fd_sc_hd__and2_1
x2_8 ( 
 .A( req_syn ),
 .B( D[8] ),
 .X( net1[7] )
);


sky130_fd_sc_hd__and2_1
x2_9 ( 
 .A( req_syn ),
 .B( D[9] ),
 .X( net1[6] )
);


sky130_fd_sc_hd__and2_1
x2_10 ( 
 .A( req_syn ),
 .B( D[10] ),
 .X( net1[5] )
);


sky130_fd_sc_hd__and2_1
x2_11 ( 
 .A( req_syn ),
 .B( D[11] ),
 .X( net1[4] )
);


sky130_fd_sc_hd__and2_1
x2_12 ( 
 .A( req_syn ),
 .B( D[12] ),
 .X( net1[3] )
);


sky130_fd_sc_hd__and2_1
x2_13 ( 
 .A( req_syn ),
 .B( D[13] ),
 .X( net1[2] )
);


sky130_fd_sc_hd__and2_1
x2_14 ( 
 .A( req_syn ),
 .B( D[14] ),
 .X( net1[1] )
);


sky130_fd_sc_hd__and2_1
x2_15 ( 
 .A( req_syn ),
 .B( D[15] ),
 .X( net1[0] )
);


synapse_4bit_memory_v1_norail
x1_0 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[15] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[15] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_1 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[14] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[14] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_2 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[13] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[13] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_3 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[12] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[12] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_4 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[11] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[11] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_5 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[10] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[10] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_6 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[9] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[9] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_7 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[8] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[8] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_8 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[7] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[7] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_9 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[6] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[6] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_10 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[5] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[5] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_11 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[4] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[4] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_12 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[3] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[3] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_13 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[2] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[2] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_14 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[1] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[1] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_v1_norail
x1_15 ( 
 .sout( sout ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .spk( net1[0] ),
 .resetW( resetW ),
 .vpulseextp( vpulseextp ),
 .setW( net2[0] ),
 .vthrdn( vthrdn ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaup( vtaup ),
 .VDD( VDD ),
 .GND( GND ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


sky130_fd_sc_hd__and2_1
x3_0 ( 
 .A( D[0] ),
 .B( setW ),
 .X( net2[15] )
);


sky130_fd_sc_hd__and2_1
x3_1 ( 
 .A( D[1] ),
 .B( setW ),
 .X( net2[14] )
);


sky130_fd_sc_hd__and2_1
x3_2 ( 
 .A( D[2] ),
 .B( setW ),
 .X( net2[13] )
);


sky130_fd_sc_hd__and2_1
x3_3 ( 
 .A( D[3] ),
 .B( setW ),
 .X( net2[12] )
);


sky130_fd_sc_hd__and2_1
x3_4 ( 
 .A( D[4] ),
 .B( setW ),
 .X( net2[11] )
);


sky130_fd_sc_hd__and2_1
x3_5 ( 
 .A( D[5] ),
 .B( setW ),
 .X( net2[10] )
);


sky130_fd_sc_hd__and2_1
x3_6 ( 
 .A( D[6] ),
 .B( setW ),
 .X( net2[9] )
);


sky130_fd_sc_hd__and2_1
x3_7 ( 
 .A( D[7] ),
 .B( setW ),
 .X( net2[8] )
);


sky130_fd_sc_hd__and2_1
x3_8 ( 
 .A( D[8] ),
 .B( setW ),
 .X( net2[7] )
);


sky130_fd_sc_hd__and2_1
x3_9 ( 
 .A( D[9] ),
 .B( setW ),
 .X( net2[6] )
);


sky130_fd_sc_hd__and2_1
x3_10 ( 
 .A( D[10] ),
 .B( setW ),
 .X( net2[5] )
);


sky130_fd_sc_hd__and2_1
x3_11 ( 
 .A( D[11] ),
 .B( setW ),
 .X( net2[4] )
);


sky130_fd_sc_hd__and2_1
x3_12 ( 
 .A( D[12] ),
 .B( setW ),
 .X( net2[3] )
);


sky130_fd_sc_hd__and2_1
x3_13 ( 
 .A( D[13] ),
 .B( setW ),
 .X( net2[2] )
);


sky130_fd_sc_hd__and2_1
x3_14 ( 
 .A( D[14] ),
 .B( setW ),
 .X( net2[1] )
);


sky130_fd_sc_hd__and2_1
x3_15 ( 
 .A( D[15] ),
 .B( setW ),
 .X( net2[0] )
);

endmodule

// expanding   symbol:  synapse_array_programmable_inh_16_to_sout_v1.sym # of pins=14
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/synapse_array_programmable_inh_16_to_sout_v1.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/synapse_array_programmable_inh_16_to_sout_v1.sch
module synapse_array_programmable_inh_16_to_sout_v1
(
  inout wire sout,
  input wire [0:3] W,
  input wire [0:3] JInhWp,
  input wire [0:3] syn_addr,
  input wire vpulseextp,
  input wire resetW,
  input wire req,
  input wire vthrdp,
  input wire setW,
  input wire vtaun,
  inout wire GND,
  inout wire VDD,
  inout wire aVDD,
  inout wire aGND
);
wire req_syn ;
wire [15:0] D ;
wire [15:0] net1 ;
wire [15:0] net2 ;


decoder_4_to_16
x3 ( 
 .A( {syn_addr[0],syn_addr[1],syn_addr[2],syn_addr[3]} ),
 .D( {D[0],D[1],D[2],D[3],D[4],D[5],D[6],D[7],D[8],D[9],D[10],D[11],D[12],D[13],D[14],D[15]} ),
 .req( req ),
 .req_syn( req_syn ),
 .dVDD( VDD ),
 .dGND( GND )
);


sky130_fd_sc_hd__and2_1
x2_0 ( 
 .A( req_syn ),
 .B( D[0] ),
 .X( net1[15] )
);


sky130_fd_sc_hd__and2_1
x2_1 ( 
 .A( req_syn ),
 .B( D[1] ),
 .X( net1[14] )
);


sky130_fd_sc_hd__and2_1
x2_2 ( 
 .A( req_syn ),
 .B( D[2] ),
 .X( net1[13] )
);


sky130_fd_sc_hd__and2_1
x2_3 ( 
 .A( req_syn ),
 .B( D[3] ),
 .X( net1[12] )
);


sky130_fd_sc_hd__and2_1
x2_4 ( 
 .A( req_syn ),
 .B( D[4] ),
 .X( net1[11] )
);


sky130_fd_sc_hd__and2_1
x2_5 ( 
 .A( req_syn ),
 .B( D[5] ),
 .X( net1[10] )
);


sky130_fd_sc_hd__and2_1
x2_6 ( 
 .A( req_syn ),
 .B( D[6] ),
 .X( net1[9] )
);


sky130_fd_sc_hd__and2_1
x2_7 ( 
 .A( req_syn ),
 .B( D[7] ),
 .X( net1[8] )
);


sky130_fd_sc_hd__and2_1
x2_8 ( 
 .A( req_syn ),
 .B( D[8] ),
 .X( net1[7] )
);


sky130_fd_sc_hd__and2_1
x2_9 ( 
 .A( req_syn ),
 .B( D[9] ),
 .X( net1[6] )
);


sky130_fd_sc_hd__and2_1
x2_10 ( 
 .A( req_syn ),
 .B( D[10] ),
 .X( net1[5] )
);


sky130_fd_sc_hd__and2_1
x2_11 ( 
 .A( req_syn ),
 .B( D[11] ),
 .X( net1[4] )
);


sky130_fd_sc_hd__and2_1
x2_12 ( 
 .A( req_syn ),
 .B( D[12] ),
 .X( net1[3] )
);


sky130_fd_sc_hd__and2_1
x2_13 ( 
 .A( req_syn ),
 .B( D[13] ),
 .X( net1[2] )
);


sky130_fd_sc_hd__and2_1
x2_14 ( 
 .A( req_syn ),
 .B( D[14] ),
 .X( net1[1] )
);


sky130_fd_sc_hd__and2_1
x2_15 ( 
 .A( req_syn ),
 .B( D[15] ),
 .X( net1[0] )
);


sky130_fd_sc_hd__and2_1
x3_0 ( 
 .A( D[0] ),
 .B( setW ),
 .X( net2[15] )
);


sky130_fd_sc_hd__and2_1
x3_1 ( 
 .A( D[1] ),
 .B( setW ),
 .X( net2[14] )
);


sky130_fd_sc_hd__and2_1
x3_2 ( 
 .A( D[2] ),
 .B( setW ),
 .X( net2[13] )
);


sky130_fd_sc_hd__and2_1
x3_3 ( 
 .A( D[3] ),
 .B( setW ),
 .X( net2[12] )
);


sky130_fd_sc_hd__and2_1
x3_4 ( 
 .A( D[4] ),
 .B( setW ),
 .X( net2[11] )
);


sky130_fd_sc_hd__and2_1
x3_5 ( 
 .A( D[5] ),
 .B( setW ),
 .X( net2[10] )
);


sky130_fd_sc_hd__and2_1
x3_6 ( 
 .A( D[6] ),
 .B( setW ),
 .X( net2[9] )
);


sky130_fd_sc_hd__and2_1
x3_7 ( 
 .A( D[7] ),
 .B( setW ),
 .X( net2[8] )
);


sky130_fd_sc_hd__and2_1
x3_8 ( 
 .A( D[8] ),
 .B( setW ),
 .X( net2[7] )
);


sky130_fd_sc_hd__and2_1
x3_9 ( 
 .A( D[9] ),
 .B( setW ),
 .X( net2[6] )
);


sky130_fd_sc_hd__and2_1
x3_10 ( 
 .A( D[10] ),
 .B( setW ),
 .X( net2[5] )
);


sky130_fd_sc_hd__and2_1
x3_11 ( 
 .A( D[11] ),
 .B( setW ),
 .X( net2[4] )
);


sky130_fd_sc_hd__and2_1
x3_12 ( 
 .A( D[12] ),
 .B( setW ),
 .X( net2[3] )
);


sky130_fd_sc_hd__and2_1
x3_13 ( 
 .A( D[13] ),
 .B( setW ),
 .X( net2[2] )
);


sky130_fd_sc_hd__and2_1
x3_14 ( 
 .A( D[14] ),
 .B( setW ),
 .X( net2[1] )
);


sky130_fd_sc_hd__and2_1
x3_15 ( 
 .A( D[15] ),
 .B( setW ),
 .X( net2[0] )
);


synapse_4bit_memory_inh_v1_norail
x1_0 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[15] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[15] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_1 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[14] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[14] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_2 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[13] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[13] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_3 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[12] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[12] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_4 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[11] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[11] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_5 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[10] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[10] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_6 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[9] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[9] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_7 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[8] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[8] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_8 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[7] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[7] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_9 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[6] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[6] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_10 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[5] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[5] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_11 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[4] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[4] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_12 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[3] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[3] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_13 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[2] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[2] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_14 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[1] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[1] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);


synapse_4bit_memory_inh_v1_norail
x1_15 ( 
 .sout( sout ),
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .resetW( resetW ),
 .spk( net1[0] ),
 .vpulseextp( vpulseextp ),
 .setW( net2[0] ),
 .vthrdp( vthrdp ),
 .W( {W[0],W[1],W[2],W[3]} ),
 .vtaun( vtaun ),
 .GND( GND ),
 .VDD( VDD ),
 .aVDD( aVDD ),
 .aGND( aGND )
);

endmodule

// expanding   symbol:  schmitt_trigger.sym # of pins=4
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/schmitt_trigger.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/schmitt_trigger.sch
module schmitt_trigger
(
  input wire A,
  output wire Y,
  inout wire VDD,
  inout wire GND
);
wire net1 ;
wire net2 ;



nfet_01v8
#(
.W ( 0.65 ) ,
.L ( 0.15 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( net2 ),
 .G( A ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.W ( 0.65 ) ,
.L ( 0.15 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( Y ),
 .G( A ),
 .S( net2 ),
 .B( GND )
);



nfet_01v8
#(
.W ( 0.42 ) ,
.L ( 0.15 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M7 ( 
 .D( VDD ),
 .G( Y ),
 .S( net2 ),
 .B( GND )
);



pfet_01v8
#(
.W ( 1 ) ,
.L ( 0.15 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( net1 ),
 .G( A ),
 .S( VDD ),
 .B( VDD )
);



pfet_01v8
#(
.W ( 1 ) ,
.L ( 0.15 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( Y ),
 .G( A ),
 .S( net1 ),
 .B( VDD )
);



pfet_01v8
#(
.W ( 0.82 ) ,
.L ( 0.15 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( GND ),
 .G( Y ),
 .S( net1 ),
 .B( VDD )
);

endmodule

// expanding   symbol:  neuron_analog_fc_v2_norail.sym # of pins=8
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/neuron_analog_fc_v2_norail.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/neuron_analog_fc_v2_norail.sch
module neuron_analog_fc_v2_norail
(
  inout wire GND,
  inout wire VDD,
  output wire nreq,
  input wire ifdcp,
  input wire nack,
  inout wire vmem,
  input wire vleakn,
  input wire vrefn
);
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire net5 ;



pfet_01v8
#(
.W ( 0.82 ) ,
.L ( 0.15 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( GND ),
 .G( Y ),
 .S( net1 ),
 .B( VDD )
);



pfet_01v8
#(
.L ( 2 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( vmem ),
 .G( ifdcp ),
 .S( VDD ),
 .B( VDD )
);



pfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( net2 ),
 .G( nreq ),
 .S( VDD ),
 .B( VDD )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.6 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M7 ( 
 .D( net3 ),
 .G( nreq ),
 .S( net4 ),
 .B( GND )
);



pfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M6 ( 
 .D( net5 ),
 .G( nack ),
 .S( VDD ),
 .B( VDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M9 ( 
 .D( nreq ),
 .G( vmem ),
 .S( net2 ),
 .B( VDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M10 ( 
 .D( net3 ),
 .G( nreq ),
 .S( net5 ),
 .B( VDD )
);



pfet_01v8
#(
.L ( 1 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( vmem ),
 .G( nreq ),
 .S( VDD ),
 .B( VDD )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.6 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( nreq ),
 .G( vmem ),
 .S( net1 ),
 .B( GND )
);



nfet_01v8
#(
.L ( 1 ) ,
.W ( 0.6 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( net4 ),
 .G( vrefn ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.6 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M8 ( 
 .D( net1 ),
 .G( net1 ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M11 ( 
 .D( vmem ),
 .G( net3 ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 2 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M12 ( 
 .D( vmem ),
 .G( vleakn ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 2 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M13 ( 
 .D( GND ),
 .G( net3 ),
 .S( GND ),
 .B( GND )
);

endmodule

// expanding   symbol:  buffer_mon_p_norail.sym # of pins=5
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/buffer_mon_p_norail.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/buffer_mon_p_norail.sch
module buffer_mon_p_norail
(
  input wire buf_p,
  output wire out,
  input wire mon,
  inout wire GND,
  inout wire AVDD
);
wire net1 ;
wire net2 ;



pfet_01v8
#(
.L ( 0.5 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( out ),
 .G( out ),
 .S( net2 ),
 .B( AVDD )
);



pfet_01v8
#(
.L ( 0.5 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( net1 ),
 .G( mon ),
 .S( net2 ),
 .B( AVDD )
);



pfet_01v8
#(
.L ( 0.3 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( net2 ),
 .G( buf_p ),
 .S( AVDD ),
 .B( AVDD )
);



nfet_01v8
#(
.L ( 0.5 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( out ),
 .G( net1 ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.5 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( net1 ),
 .G( net1 ),
 .S( GND ),
 .B( GND )
);

endmodule

// expanding   symbol:  arbiter_cell_two_bits_fc.sym # of pins=8
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/arbiter_cell_two_bits_fc.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/arbiter_cell_two_bits_fc.sch
module arbiter_cell_two_bits_fc
(
  output wire g1,
  output wire g0,
  input wire gc,
  output wire rc,
  input wire r0,
  input wire r1,
  inout wire VDD,
  inout wire GND
);
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire net5 ;
wire net6 ;
wire net7 ;
wire net8 ;
wire net9 ;


sky130_fd_sc_hd__nand2_1
x1 ( 
 .A( net6 ),
 .B( net5 ),
 .Y( net7 )
);


sky130_fd_sc_hd__or2_1
x2 ( 
 .A( r0 ),
 .B( gc ),
 .X( net4 )
);


sky130_fd_sc_hd__nor2_1
x3 ( 
 .A( net3 ),
 .B( net1 ),
 .Y( g0 )
);


sky130_fd_sc_hd__or4_1
x4 ( 
 .A( net6 ),
 .B( net6 ),
 .C( net6 ),
 .D( net6 ),
 .X( net3 )
);


sky130_fd_sc_hd__inv_1
x5 ( 
 .A( gc ),
 .Y( net1 )
);


sky130_fd_sc_hd__or2_1
x6 ( 
 .A( gc ),
 .B( r1 ),
 .X( net5 )
);


sky130_fd_sc_hd__nand2_1
x7 ( 
 .A( net4 ),
 .B( net7 ),
 .Y( net6 )
);


sky130_fd_sc_hd__or4_1
x8 ( 
 .A( net7 ),
 .B( net7 ),
 .C( net7 ),
 .D( net7 ),
 .X( net2 )
);


sky130_fd_sc_hd__nor2_1
x9 ( 
 .A( net1 ),
 .B( net2 ),
 .Y( g1 )
);


sky130_fd_sc_hd__nand2_1
x10 ( 
 .A( net2 ),
 .B( r0 ),
 .Y( net8 )
);


sky130_fd_sc_hd__nand2_1
x11 ( 
 .A( net3 ),
 .B( r1 ),
 .Y( net9 )
);


sky130_fd_sc_hd__nand2_1
x12 ( 
 .A( net8 ),
 .B( net9 ),
 .Y( rc )
);

endmodule

// expanding   symbol:  tg.sym # of pins=6
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/tg.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/tg.sch
module tg
(
  input wire nEn,
  inout wire OUT,
  inout wire IN,
  input wire EN,
  inout wire GND,
  inout wire VDD
);


nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M14 ( 
 .D( OUT ),
 .G( EN ),
 .S( IN ),
 .B( GND )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M13 ( 
 .D( IN ),
 .G( nEn ),
 .S( OUT ),
 .B( VDD )
);

endmodule

// expanding   symbol:  synapse_4bit_memory_v1_norail.sym # of pins=13
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/synapse_4bit_memory_v1_norail.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/synapse_4bit_memory_v1_norail.sch
module synapse_4bit_memory_v1_norail
(
  inout wire sout,
  input wire [0:3] JExcWn,
  input wire spk,
  input wire resetW,
  input wire vpulseextp,
  input wire setW,
  input wire vthrdn,
  input wire [0:3] W,
  input wire vtaup,
  inout wire VDD,
  inout wire GND,
  inout wire aVDD,
  inout wire aGND
);
wire net1 ;
wire [3:0] net2 ;
wire spke ;


sky130_fd_sc_hd__dfrtp_1
x2_0 ( 
 .CLK( setW ),
 .D( W[0] ),
 .RESET_B( net1 ),
 .Q( net2[3] )
);


sky130_fd_sc_hd__dfrtp_1
x2_1 ( 
 .CLK( setW ),
 .D( W[1] ),
 .RESET_B( net1 ),
 .Q( net2[2] )
);


sky130_fd_sc_hd__dfrtp_1
x2_2 ( 
 .CLK( setW ),
 .D( W[2] ),
 .RESET_B( net1 ),
 .Q( net2[1] )
);


sky130_fd_sc_hd__dfrtp_1
x2_3 ( 
 .CLK( setW ),
 .D( W[3] ),
 .RESET_B( net1 ),
 .Q( net2[0] )
);


sky130_fd_sc_hd__inv_1
x4 ( 
 .A( resetW ),
 .Y( net1 )
);


dpi_syn_exc_4bit_fc_v2
x2 ( 
 .vtaup( vtaup ),
 .sout( sout ),
 .vthn( vthrdn ),
 .spk( spke ),
 .JExcWn( {JExcWn[0],JExcWn[1],JExcWn[2],JExcWn[3]} ),
 .GND( aGND ),
 .aVDD( aVDD ),
 .weight( net2 )
);


spike_extender_with_trimming
x6 ( 
 .vpulseextp( vpulseextp ),
 .vspk( spk ),
 .GND( GND ),
 .spkext( spke ),
 .VDD( VDD )
);


sky130_fd_sc_hd__decap_4
x1 ( 
);


sky130_fd_sc_hd__decap_3
x3 ( 
);


sky130_fd_sc_hd__decap_3
x5 ( 
);


sky130_fd_sc_hd__decap_6
x7 ( 
);


sky130_fd_sc_hd__decap_3
x8 ( 
);


sky130_fd_sc_hd__decap_3
x9 ( 
);

endmodule

// expanding   symbol:  synapse_4bit_memory_inh_v1_norail.sym # of pins=13
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/synapse_4bit_memory_inh_v1_norail.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/synapse_4bit_memory_inh_v1_norail.sch
module synapse_4bit_memory_inh_v1_norail
(
  inout wire sout,
  input wire [0:3] JInhWp,
  input wire resetW,
  input wire spk,
  input wire vpulseextp,
  input wire setW,
  input wire vthrdp,
  input wire [0:3] W,
  input wire vtaun,
  inout wire GND,
  inout wire VDD,
  inout wire aVDD,
  inout wire aGND
);
wire net1 ;
wire [3:0] net2 ;
wire [3:0] net3 ;
wire spke ;


sky130_fd_sc_hd__inv_1
x11 ( 
 .A( resetW ),
 .Y( net1 )
);


dpi_syn_inh_4bit_fc_v2
x2 ( 
 .JInhWp( {JInhWp[0],JInhWp[1],JInhWp[2],JInhWp[3]} ),
 .weight_b( net2 ),
 .spk( spke ),
 .sout( sout ),
 .vthrdp( vthrdp ),
 .vtaun( vtaun ),
 .GND( aGND ),
 .aVDD( aVDD )
);


sky130_fd_sc_hd__dfrbp_1
x2_0 ( 
 .CLK( setW ),
 .D( W[0] ),
 .RESET_B( net1 ),
 .Q( net3[3] ),
 .Q_N( net2[3] )
);


sky130_fd_sc_hd__dfrbp_1
x2_1 ( 
 .CLK( setW ),
 .D( W[1] ),
 .RESET_B( net1 ),
 .Q( net3[2] ),
 .Q_N( net2[2] )
);


sky130_fd_sc_hd__dfrbp_1
x2_2 ( 
 .CLK( setW ),
 .D( W[2] ),
 .RESET_B( net1 ),
 .Q( net3[1] ),
 .Q_N( net2[1] )
);


sky130_fd_sc_hd__dfrbp_1
x2_3 ( 
 .CLK( setW ),
 .D( W[3] ),
 .RESET_B( net1 ),
 .Q( net3[0] ),
 .Q_N( net2[0] )
);


spike_extender_with_trimming
x4 ( 
 .vpulseextp( vpulseextp ),
 .vspk( spk ),
 .GND( GND ),
 .spkext( spke ),
 .VDD( VDD )
);


sky130_fd_sc_hd__decap_4
x1 ( 
);

endmodule

// expanding   symbol:  dpi_syn_exc_4bit_fc_v2.sym # of pins=8
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/dpi_syn_exc_4bit_fc_v2.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/dpi_syn_exc_4bit_fc_v2.sch
module dpi_syn_exc_4bit_fc_v2
(
  inout wire vtaup,
  output wire sout,
  inout wire vthn,
  input wire spk,
  inout wire [0:3] JExcWn,
  inout wire GND,
  inout wire aVDD,
  input wire [0:3] weight
);
wire vsin ;
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire net5 ;
wire net6 ;



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( net3 ),
 .G( spk ),
 .S( net1 ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( net3 ),
 .G( spk ),
 .S( net1 ),
 .B( GND )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( vsin ),
 .G( vtaup ),
 .S( aVDD ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M6 ( 
 .D( sout ),
 .G( vsin ),
 .S( aVDD ),
 .B( aVDD )
);



nfet_01v8
#(
.L ( 1 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( net1 ),
 .G( JExcWn[0] ),
 .S( net2 ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( vsin ),
 .G( vsin ),
 .S( net3 ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( aVDD ),
 .G( vthn ),
 .S( net3 ),
 .B( GND )
);



nfet_01v8
#(
.L ( 2 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M7 ( 
 .D( net1 ),
 .G( JExcWn[1] ),
 .S( net4 ),
 .B( GND )
);



nfet_01v8
#(
.L ( 4 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M8 ( 
 .D( net1 ),
 .G( JExcWn[2] ),
 .S( net5 ),
 .B( GND )
);



nfet_01v8
#(
.L ( 8 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M9 ( 
 .D( net1 ),
 .G( JExcWn[3] ),
 .S( net6 ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M10 ( 
 .D( net2 ),
 .G( weight[0] ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M11 ( 
 .D( net4 ),
 .G( weight[1] ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M12 ( 
 .D( net5 ),
 .G( weight[2] ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M13 ( 
 .D( net6 ),
 .G( weight[3] ),
 .S( GND ),
 .B( GND )
);

endmodule

// expanding   symbol:  spike_extender_with_trimming.sym # of pins=5
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/spike_extender_with_trimming.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/spike_extender_with_trimming.sch
module spike_extender_with_trimming
(
  input wire vpulseextp,
  input wire vspk,
  inout wire GND,
  output wire spkext,
  inout wire VDD
);
wire vpulseshort ;
wire net1 ;


spike_extender
x1 ( 
 .vpulseextp( vpulseextp ),
 .spk( vpulseshort ),
 .GND( GND ),
 .spkext( spkext ),
 .VDD( VDD )
);


sky130_fd_sc_hd__clkdlybuf4s50_1
x3 ( 
 .A( vspk ),
 .X( net1 )
);


sky130_fd_sc_hd__nor2b_1
x2 ( 
 .A( net1 ),
 .B_N( vspk ),
 .Y( vpulseshort )
);

endmodule

// expanding   symbol:  dpi_syn_inh_4bit_fc_v2.sym # of pins=8
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/dpi_syn_inh_4bit_fc_v2.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/dpi_syn_inh_4bit_fc_v2.sch
module dpi_syn_inh_4bit_fc_v2
(
  inout wire [0:3] JInhWp,
  input wire [0:3] weight_b,
  input wire spk,
  inout wire sout,
  inout wire vthrdp,
  inout wire vtaun,
  inout wire GND,
  inout wire aVDD
);
wire vsin ;
wire net1 ;
wire net2 ;
wire net3 ;
wire net4 ;
wire net5 ;
wire net6 ;
wire net7 ;



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( net2 ),
 .G( net3 ),
 .S( net1 ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( GND ),
 .G( vthrdp ),
 .S( net2 ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( vsin ),
 .G( vsin ),
 .S( net2 ),
 .B( aVDD )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( vsin ),
 .G( vtaun ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M6 ( 
 .D( sout ),
 .G( vsin ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.25 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M7 ( 
 .D( net3 ),
 .G( spk ),
 .S( GND ),
 .B( GND )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M8 ( 
 .D( net3 ),
 .G( spk ),
 .S( aVDD ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M8 ( 
 .D( net3 ),
 .G( spk ),
 .S( aVDD ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 1.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M9 ( 
 .D( net4 ),
 .G( JInhWp[0] ),
 .S( aVDD ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M10 ( 
 .D( net1 ),
 .G( weight_b[0] ),
 .S( net4 ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M11 ( 
 .D( net1 ),
 .G( weight_b[1] ),
 .S( net5 ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( net5 ),
 .G( JInhWp[1] ),
 .S( aVDD ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 4 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M12 ( 
 .D( net6 ),
 .G( JInhWp[2] ),
 .S( aVDD ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 8 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M13 ( 
 .D( net7 ),
 .G( JInhWp[3] ),
 .S( aVDD ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M14 ( 
 .D( net1 ),
 .G( weight_b[2] ),
 .S( net6 ),
 .B( aVDD )
);



pfet_01v8
#(
.L ( 0.2 ) ,
.W ( 1.2 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M15 ( 
 .D( net1 ),
 .G( weight_b[3] ),
 .S( net7 ),
 .B( aVDD )
);

endmodule

// expanding   symbol:  spike_extender.sym # of pins=5
// sym_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/spike_extender.sym
// sch_path: /home/jelmer/Documents/stage/ElectronicSystems/aVLSI-SkyWater130-2024/xschem/spike_extender.sch
module spike_extender
(
  input wire vpulseextp,
  input wire spk,
  inout wire GND,
  output wire spkext,
  inout wire VDD
);
wire net1 ;
wire net2 ;
wire net3 ;



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( net1 ),
 .G( spk ),
 .S( GND ),
 .B( GND )
);



pfet_01v8
#(
.L ( 2 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M6 ( 
 .D( net1 ),
 .G( vpulseextp ),
 .S( VDD ),
 .B( VDD )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( net3 ),
 .G( net2 ),
 .S( GND ),
 .B( GND )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M8 ( 
 .D( spkext ),
 .G( net3 ),
 .S( GND ),
 .B( GND )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( net3 ),
 .G( net2 ),
 .S( VDD ),
 .B( VDD )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M7 ( 
 .D( spkext ),
 .G( net3 ),
 .S( VDD ),
 .B( VDD )
);



nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( net2 ),
 .G( net1 ),
 .S( GND ),
 .B( GND )
);



pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 1 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( net2 ),
 .G( net1 ),
 .S( VDD ),
 .B( VDD )
);



nfet_01v8
#(
.L ( 1 ) ,
.W ( 0.65 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( 1 ) ,
.pd ( 2 ) ,
.as ( 1 ) ,
.ps ( 2 ) ,
.nrd ( 0.29 ) ,
.nrs ( 0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M9 ( 
 .D( GND ),
 .G( net1 ),
 .S( GND ),
 .B( GND )
);

endmodule
