set -e
iverilog -o test ../top_level.v ../input_fifo.v $1 
vvp test -fst
gtkwave tb_wishbone_nn.vcd