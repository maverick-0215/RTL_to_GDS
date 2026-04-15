set_clock_latency -source -early -min  0.8 [get_clocks {clk_pad}]
set_clock_latency -source -early -max  1.6 [get_clocks {clk_pad}]
set_clock_latency -source -late -min  1 [get_clocks {clk_pad}]
set_clock_latency -source -late -max  2 [get_clocks {clk_pad}]
