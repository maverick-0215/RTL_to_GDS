add_search_path /opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/liberty/lib_flow_ff /opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/liberty/lib_flow_ss -library -both
read_library -liberty -both \
    /opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib \
    /opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/liberty/tsl18cio150_max.lib \
    /opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib \
    /opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/liberty/tsl18cio150_max.lib

