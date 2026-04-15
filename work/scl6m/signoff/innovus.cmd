#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Tue Apr 14 18:37:49 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.19-s058_1 (64bit) 04/04/2024 09:59 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.19-s058_1 NR231113-0413/21_19-UB (database version 18.20.605) {superthreading v2.17}
#@(#)CDS: AAE 21.19-s004 (64bit) 04/04/2024 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.19-s010_1 () Mar 27 2024 01:55:37 ( )
#@(#)CDS: SYNTECH 21.19-s002_1 () Sep  6 2023 22:17:00 ( )
#@(#)CDS: CPE v21.19-s026
#@(#)CDS: IQuantus/TQuantus 21.1.1-s966 (64bit) Wed Mar 8 10:22:20 PST 2023 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
encMessage warning 0
encMessage debug 0
is_common_ui_mode
restoreDesign /home/thoshith/work_risc_v/scl6m/cts/microprocessor_pad_top_route_with_filler.enc.dat microprocessor_pad_top
setDrawView fplan
encMessage warning 1
encMessage debug 0
setDrawView place
zoomBox -27.61200 99.58500 1998.44100 1913.33500
zoomBox 411.78200 504.69500 1656.03300 1618.56500
zoomBox 518.74200 597.65100 1576.35600 1544.44100
zoomBox 917.13000 915.04200 1256.17700 1218.56100
zoomBox 998.00200 985.83800 1174.98800 1144.27800
zoomBox 1035.97600 1037.35600 1114.50600 1107.65700
zoomBox 1038.25900 1048.77200 1094.99800 1099.56600
zoomBox 1039.90800 1057.02100 1080.90300 1093.72000
zoomBox 1042.18800 1067.33700 1063.59000 1086.49600
zoomBox 1042.56200 1069.02600 1060.75400 1085.31200
zoomBox 1045.37000 1071.81800 1058.51400 1083.58500
zoomBox 1047.39800 1073.81400 1056.89500 1082.31600
zoomBox 1048.47000 1074.56600 1056.54300 1081.79300
zoomBox 1050.15700 1075.74800 1055.99000 1080.97000
zoomBox 1050.79300 1076.21800 1055.75200 1080.65700
zoomBox 1050.18200 1075.71600 1056.01600 1080.93900
zoomBox 1047.63100 1073.63400 1057.13200 1082.13900
zoomBox 1039.46700 1066.95100 1060.88000 1086.12000
zoomBox 1026.36000 1056.16100 1067.38300 1092.88500
zoomBox 1022.05200 1053.05100 1070.31400 1096.25600
zoomBox 1025.15100 1056.64700 1066.17500 1093.37200
zoomBox 1009.06300 1037.88800 1087.65400 1108.24400
zoomBox 987.66000 1012.46200 1115.63400 1127.02600
zoomBox 964.95900 985.37300 1142.08700 1143.94000
zoomBox 746.54900 721.30700 1396.58900 1303.23200
zoomBox 250.75600 119.96700 1974.31900 1662.92400
zoomBox 110.28400 -50.40900 2138.00600 1764.83500
fit
reset_parasitics
extractRC
rcOut -spef microprocessor_pad_top.spef -rc_corner rc_best
getMultiCpuUsage -localCpu
get_verify_drc_mode -disable_rules -quiet
get_verify_drc_mode -quiet -area
get_verify_drc_mode -quiet -layer_range
get_verify_drc_mode -check_ndr_spacing -quiet
get_verify_drc_mode -check_only -quiet
get_verify_drc_mode -check_same_via_cell -quiet
get_verify_drc_mode -exclude_pg_net -quiet
get_verify_drc_mode -ignore_trial_route -quiet
get_verify_drc_mode -max_wrong_way_halo -quiet
get_verify_drc_mode -use_min_spacing_on_block_obs -quiet
get_verify_drc_mode -limit -quiet
set_verify_drc_mode -disable_rules {} -check_ndr_spacing auto -check_only default -check_same_via_cell true -exclude_pg_net false -ignore_trial_route false -ignore_cell_blockage false -use_min_spacing_on_block_obs auto -report microprocessor_pad_top.drc.rpt -limit 1000
verify_drc
set_verify_drc_mode -area {0 0 0 0}
verifyConnectivity -type all -error 1000 -warning 50
zoomBox -267.75300 636.77000 2339.01100 1947.20600
zoomBox -57.08100 811.93900 2158.67000 1925.81000
zoomBox 596.65400 1349.30700 1579.79600 1843.53800
zoomBox 825.26200 1548.24300 1338.47000 1806.23600
zoomBox 612.67300 1362.78200 1595.82100 1857.01600
zoomBox 333.47600 1121.37000 1934.36800 1926.14800
zoomBox -524.81900 427.25000 3083.19200 2241.01900
fit
checkDesign -io -netlist -physicalLibrary -powerGround -tieHilo -timingLibrary -spef -floorplan -place -outdir checkDesign
streamOut risc_v.gds -mapFile streamout_innovous_6M1L.map -libName DesignLib -units 1000 -mode ALL
saveNetlist -includePowerGround /home/thoshith/work_risc_v/scl6m/signoff/signoff/rv_signoff_withPG.v
saveNetlist -includePowerGround /home/thoshith/work_risc_v/scl6m/signoff/signoff/rv_signoff_withPG.v
saveNetlist -includePowerGround /home/thoshith/work_risc_v/scl6m/signoff/signoff/rv_signoff_withPG.v
saveNetlist /home/thoshith/work_risc_v/scl6m/signoff/signoff/rv_signoff_withoutPG.v
write_sdf -version 2.1 -edges noedge -recrem split -setuphold merge_when_paired /home/thoshith/work_risc_v/scl6m/signoff/signoff/rv_signoff_postroute_with_pad_delay.sdf 
saveDesign microprocessor_pad_top_signoff.enc
