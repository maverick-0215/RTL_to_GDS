-gui
# 1. ADD THIS LINE - The actual logic gates (standard cells)
/opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/verilog/vcs_sim_model/tsl18fs120_scl.v

# 2. Keep the IO Pad models you already have
/opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/verilog/tsl18cio150/zero/pc3d01.v
/opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/verilog/tsl18cio150/zero/pc3o05.v
/opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/verilog/tsl18cio150/zero/pvdi.v
/opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/verilog/tsl18cio150/zero/pv0i.v
/opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/verilog/tsl18cio150/zero/pvda.v
/opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/verilog/tsl18cio150/zero/pv0a.v

# 3. Rest of your files (Netlist and TB)
microprocessor_pad_top_incremental.v
microprocessor_pad_top_tb.v

# 4. Simulation Options
-access +rwc
-timescale 1ns/10ps
-relax
+delay_mode_zero
