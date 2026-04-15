#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Tue Apr 14 18:04:10 2026                
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
restoreDesign /home/thoshith/work_risc_v/scl6m/floorplanning/microprocessor_pad_top_placement.enc.dat microprocessor_pad_top
setDrawView fplan
encMessage warning 1
encMessage debug 0
setDrawView place
set init_top_cell microprocessor_pad_top
set_global report_timing_format {instance arc net cell slew delay arrival required} 
set_analysis_view -setup {worst_case} -hold {best_case} 
setAnalysisMode -analysisType onChipVariation -cppr both
setNanoRouteMode -drouteUseMultiCutViaEffort high
set_ccopt_property buffer_cells {bufbd1 bufbd2 bufbd3 bufbd4 bufbd7 bufbda bufbdf bufbdk}
set_ccopt_property inverter_cells {invbd2 invbd4 invbd7 invbda invbdf invbdk}
setDesignMode -topRoutingLayer 6
create_route_type -name leaf_rule -top_preferred_layer 3 -bottom_preferred_layer 1 -preferred_routing_layer_effort high
create_route_type -name trunk_rule -top_preferred_layer 6 -bottom_preferred_layer 4 -preferred_routing_layer_effort high
set_ccopt_property -net_type leaf route_type leaf_rule
set_ccopt_property -net_type trunk route_type trunk_rule
set_ccopt_property -net_type top route_type trunk_rule
set_ccopt_property primary_delay_corner max_delay
set_ccopt_property route_type_autotrim false
create_ccopt_clock_tree_spec -file /home/thoshith/work_risc_v/scl6m/cts/run/microprocessor_pad_top_ccopt.spec
get_ccopt_clock_trees
ccopt_check_and_flatten_ilms_no_restore
set_ccopt_property sink_type -pin CLKOUT_pad ignore
set_ccopt_property sink_type_reasons -pin CLKOUT_pad {implicit design_io}
set_ccopt_property cts_is_sdc_clock_root -pin clk_pad true
create_ccopt_clock_tree -name clk_pad -source clk_pad -no_skew_group
set_ccopt_property target_max_trans_sdc -delay_corner max_delay -early -clock_tree clk_pad 2.500
set_ccopt_property target_max_trans_sdc -delay_corner max_delay -late -clock_tree clk_pad 4.000
set_ccopt_property source_latency -delay_corner max_delay -early -rise -clock_tree clk_pad 0.800
set_ccopt_property source_latency -delay_corner max_delay -early -fall -clock_tree clk_pad 0.800
set_ccopt_property source_latency -delay_corner max_delay -late -rise -clock_tree clk_pad 2.000
set_ccopt_property source_latency -delay_corner max_delay -late -fall -clock_tree clk_pad 2.000
set_ccopt_property source_latency -delay_corner min_delay -early -rise -clock_tree clk_pad 0.800
set_ccopt_property source_latency -delay_corner min_delay -early -fall -clock_tree clk_pad 0.800
set_ccopt_property source_latency -delay_corner min_delay -late -rise -clock_tree clk_pad 2.000
set_ccopt_property source_latency -delay_corner min_delay -late -fall -clock_tree clk_pad 2.000
set_ccopt_property clock_period -pin clk_pad 20
set_ccopt_property timing_connectivity_info {}
create_ccopt_skew_group -name clk_pad/functional -sources clk_pad -auto_sinks
set_ccopt_property include_source_latency -skew_group clk_pad/functional true
set_ccopt_property extracted_from_clock_name -skew_group clk_pad/functional clk_pad
set_ccopt_property extracted_from_constraint_mode_name -skew_group clk_pad/functional functional
set_ccopt_property extracted_from_delay_corners -skew_group clk_pad/functional {max_delay min_delay}
check_ccopt_clock_tree_convergence
get_ccopt_property auto_design_state_for_ilms
get_ccopt_clock_trees *
ctd_win -id before_ccopt
set_ccopt_property -delay_corner max_delay -net_type top target_max_trans 2
set_ccopt_property -delay_corner min_delay -net_type top target_max_trans 2
set_ccopt_property -delay_corner max_delay -net_type trunk target_max_trans 2
set_ccopt_property -delay_corner min_delay -net_type trunk target_max_trans 2
set_ccopt_property -delay_corner max_delay -net_type leaf target_max_trans 2
set_ccopt_property -delay_corner min_delay -net_type leaf target_max_trans 2
set_ccopt_property -delay_corner min_delay target_skew 0.5
get_ccopt_skew_groups *
set_ccopt_property -skew_group clk_pad/functional -delay_corner min_delay target_skew 0.5
get_ccopt_clock_trees *
set_ccopt_property source_driver pc3d01_clk/CIN -clock_tree clk_pad
set_ccopt_property balance_mode cluster
ccopt_design -cts
ctd_win -id cluster_mode
set_ccopt_property balance_mode trial
ccopt_design -cts
ctd_win -id trial_mode
set_ccopt_property balance_mode full
ccopt_design -cts
ctd_win -id full_mode
report_ccopt_clock_trees -summary -file /home/thoshith/work_risc_v/scl6m/cts/reports/microprocessor_pad_top_clock_trees.rpt
report_ccopt_skew_groups -summary -file /home/thoshith/work_risc_v/scl6m/cts/reports/microprocessor_pad_top_skew_group.rpt
reportCongestion -overflow -hotSpot > /home/thoshith/work_risc_v/scl6m/cts/reports/microprocessor_pad_top_congestion.rpt
selectObject Net CLKOUT_pad
zoomSelected
deselectObject Net CLKOUT_pad
selectObject IO_Pin CLKOUT_pad
zoomSelected
deselectObject IO_Pin CLKOUT_pad
selectObject IO_Pin CLKOUT_pad
zoomSelected
deselectObject IO_Pin CLKOUT_pad
zoomBox 246.83400 1646.31200 251.91600 1648.86700
zoomBox 244.70400 1645.22000 254.44300 1650.11600
zoomBox 240.62800 1643.12900 259.28600 1652.50800
zoomBox 232.81900 1639.12200 268.56200 1657.09000
fit
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -pathReports -drvReports -slackReports -numPaths 500 -prefix microprocessor_pad_top_postCTS -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -hold -pathReports -slackReports -numPaths 500 -prefix microprocessor_pad_top_postCTS -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS -hold
saveDesign microprocessor_pad_top_cts.enc
setNanoRouteMode -quiet -routeInsertAntennaDiode 1
setNanoRouteMode -quiet -routeAntennaCellName ADIODE
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeWithSiDriven 1
setNanoRouteMode -quiet -routeTopRoutingLayer 6
setNanoRouteMode -quiet -routeBottomRoutingLayer 1
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true
routeDesign -globalDetail
zoomBox -1338.44500 -186.17700 3655.29300 2324.20500
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 500 -prefix microprocessor_pad_top_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 500 -prefix microprocessor_pad_top_postRoute -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
setDelayCalMode -engine default -siAware true
optDesign -postRoute -hold
verify_drc
zoomBox 5.01300 419.01400 2220.76200 1532.88400
zoomBox 424.54500 631.34900 1785.29200 1315.40500
zoomBox 962.80900 900.97000 1230.70700 1035.64400
zoomBox 1000.88900 923.85800 1194.44600 1021.16000
zoomBox 1028.62300 940.39500 1168.46800 1010.69600
zoomBox 1053.51100 958.06200 1139.39300 1001.23500
zoomBox 1064.51500 965.94300 1126.56700 997.13700
zoomBox 1069.36100 969.53100 1122.10600 996.04600
zoomBox 1076.97400 975.17100 1115.08300 994.32900
zoomBox 1079.94900 977.37400 1112.34400 993.65900
zoomBox 1082.42100 979.17000 1109.95700 993.01300
zoomBox 1081.10200 977.61000 1113.49900 993.89600
zoomBox 1079.55200 975.77400 1117.66600 994.93400
zoomBox 1081.21200 977.57500 1113.60900 993.86100
zoomBox 1085.95000 983.29200 1100.32600 990.51900
zoomBox 1087.06400 984.59700 1097.45100 989.81900
zoomBox 1087.86900 985.54100 1095.37500 989.31400
zoomBox 1088.53200 985.91100 1094.91300 989.11900
zoomBox 1089.09200 986.22700 1094.51700 988.95400
zoomBox 1089.56900 986.49600 1094.18000 988.81400
zoomBox 1089.09200 986.22700 1094.51700 988.95400
zoomBox 1087.87100 985.53800 1095.38100 989.31300
zoomBox 1087.09500 985.10100 1095.93000 989.54200
zoomBox 1086.18200 984.58600 1096.57600 989.81100
zoomBox 1087.87100 985.53800 1095.38100 989.31300
zoomBox 1087.31100 985.01500 1096.14600 989.45600
zoomBox 1085.87600 983.67600 1098.10600 989.82400
zoomBox 1083.89000 981.82300 1100.81800 990.33300
zoomBox 1085.21600 982.50200 1099.60600 989.73600
zoomBox 1083.87000 981.81600 1100.80000 990.32700
zoomBox 1082.17900 981.40500 1102.09700 991.41800
zoomBox 1077.85000 980.35100 1105.41800 994.21000
zoomBox 1079.77800 981.86500 1103.21300 993.64600
zoomBox 1081.41800 983.15200 1101.33800 993.16600
zoomBox 1075.57800 978.56900 1108.01400 994.87500
saveDesign microprocessor_pad_top_route.enc
getFillerMode -quiet
addFiller -cell feedth feedth3 feedth9 -prefix FILLER
zoomBox 1079.51400 981.81600 1102.94900 993.59700
zoomBox 1086.04400 983.98500 1100.43800 991.22100
zoomBox 1090.89500 985.48400 1098.41100 989.26200
zoomBox 1086.05700 983.94800 1100.45500 991.18600
zoomBox 1079.74700 981.83100 1103.19200 993.61700
zoomBox 1064.77000 976.80800 1109.68500 999.38700
zoomBox 1045.08300 970.20600 1118.22100 1006.97300
zoomBox 1005.35300 957.21100 1145.46400 1027.64600
zoomBox 853.03900 899.60200 1290.10400 1119.31700
zoomBox 548.24400 676.85500 1533.27900 1172.03800
zoomBox -138.68500 174.84000 2081.33600 1290.85800
zoomBox 784.00200 330.63700 1942.87000 913.20700
zoomBox 1141.78500 454.16200 1746.72100 758.26700
zoomBox 1188.81900 476.37000 1703.01500 734.85900
zoomBox 1291.10100 525.44200 1606.88200 684.18700
zoomBox 1357.36000 563.01800 1522.19900 645.88400
zoomBox 1397.94200 586.01100 1471.08400 622.78000
zoomBox 1406.87500 591.08800 1459.72100 617.65400
zoomBox 1415.85100 596.18900 1448.30500 612.50400
zoomBox 1417.99400 597.40600 1445.58000 611.27400
selectInst FILLER_T_1_9927
saveDesign microprocessor_pad_top_route_with_filler.enc
zoomBox 1419.55600 598.19700 1443.00500 609.98500
zoomBox 1416.13400 596.32400 1448.59200 612.64100
zoomBox 1404.68100 589.73500 1466.86400 620.99500
zoomBox 1381.31600 576.48200 1500.44100 636.36700
zoomBox 1362.11100 565.88900 1526.99100 648.77500
zoomBox 1349.89900 559.15300 1543.87500 656.66600
zoomBox 1275.34500 518.03000 1646.94600 704.83600
