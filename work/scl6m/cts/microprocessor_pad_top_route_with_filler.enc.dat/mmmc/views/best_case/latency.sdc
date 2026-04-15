set_clock_latency -source -early -min  0.8 [get_clocks {clk_pad}]
set_clock_latency -source -early -max  1.6 [get_clocks {clk_pad}]
set_clock_latency -source -late -min  1 [get_clocks {clk_pad}]
set_clock_latency -source -late -max  2 [get_clocks {clk_pad}]
set_clock_latency -source -early -min -rise  -0.612344 [get_ports {clk_pad}] -clock clk_pad 
set_clock_latency -source -early -min -fall  -0.931316 [get_ports {clk_pad}] -clock clk_pad 
set_clock_latency -source -early -max -rise  0.187656 [get_ports {clk_pad}] -clock clk_pad 
set_clock_latency -source -early -max -fall  -0.131316 [get_ports {clk_pad}] -clock clk_pad 
set_clock_latency -source -late -min -rise  -0.412344 [get_ports {clk_pad}] -clock clk_pad 
set_clock_latency -source -late -min -fall  -0.731316 [get_ports {clk_pad}] -clock clk_pad 
set_clock_latency -source -late -max -rise  0.587656 [get_ports {clk_pad}] -clock clk_pad 
set_clock_latency -source -late -max -fall  0.268684 [get_ports {clk_pad}] -clock clk_pad 
