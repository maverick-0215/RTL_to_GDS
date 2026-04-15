#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Tue Apr 14 17:15:30 2026                
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
set init_gnd_net {VSS_CORE VSSO_CORE}
set init_lef_file {/opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/lef/scl18fs120_tech.lef /opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/lef/scl18fs120_std.lef /opt/tools/Cadence/Cadence_lib/scl_pdk_v3/SCLPDK_V3.0_KIT/scl180/iopad/cio150/6M1L/lef/tsl18cio150_6lm.lef}
set init_verilog microprocessor_pad_top_incremental.v
set init_mmmc_file microprocessor.view
set init_io_file microprocessor.io
set init_pwr_net {VDD_CORE VDDO_CORE}
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -d 1940 1940 125 125 125 125
uiSetTool select
getIoFlowFlag
fit
addIoFiller -cell pfeed30000 pfeed10000 pfeed02000 pfeed01000 pfeed00540 pfeed00120 pfeed00040 pfeed00010 -prefix FILLER -side n
zoomBox -612.69700 432.81400 2454.08200 1974.50200
zoomBox -222.74800 816.11000 1993.00100 1929.98000
addIoFiller -cell pfeed30000 pfeed10000 pfeed02000 pfeed01000 pfeed00540 pfeed00120 pfeed00040 pfeed00010 -prefix FILLER -side s
addIoFiller -cell pfeed30000 pfeed10000 pfeed02000 pfeed01000 pfeed00540 pfeed00120 pfeed00040 pfeed00010 -prefix FILLER -side w
addIoFiller -cell pfeed30000 pfeed10000 pfeed02000 pfeed01000 pfeed00540 pfeed00120 pfeed00040 pfeed00010 -prefix FILLER -side e
zoomBox 70.44200 876.86600 1953.82900 1823.65600
zoomBox 319.99300 928.50900 1920.87300 1733.28100
zoomBox 69.25100 876.86600 1952.64000 1823.65700
zoomBox -225.73900 816.10900 1990.01400 1929.98100
zoomBox -572.78600 744.63000 2033.98300 2055.06800
gui_select -rect {605.98100 1432.76700 311.29000 1658.48800}
fit
saveDesign microprocessor_pad_top_floorplanning.enc
globalNetConnect VDD_CORE -type pgpin -pin VDD -all
globalNetConnect VSS_CORE -type pgpin -pin VSS -all
globalNetConnect VDDO_CORE -type pgpin -pin VDDO -all
globalNetConnect VSSO_CORE -type pgpin -pin VSSO -all
globalNetConnect VDD_CORE -type tiehi
globalNetConnect VSS_CORE -type tielo
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer TOP_M -stacked_via_bottom_layer M1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD_CORE VSS_CORE} -type core_rings -follow core -layer {top M5 bottom M5 left TOP_M right TOP_M} -width {top 25 bottom 25 left 25 right 25} -spacing {top 10 bottom 10 left 10 right 10} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer TOP_M -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {VDD_CORE VSS_CORE} -layer TOP_M -direction vertical -width 10 -spacing 10 -set_to_set_distance 100 -start_from left -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit TOP_M -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit TOP_M -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { padPin corePin floatingStripe } -layerChangeRange { M1(1) TOP_M(6) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1(1) TOP_M(6) } -nets { VDD_CORE VSS_CORE } -allowLayerChange 1 -targetViaLayerRange { M1(1) TOP_M(6) }
zoomBox -853.02000 67.63900 2754.95600 1881.39000
zoomBox -42.05900 516.13300 1841.32800 1462.92300
zoomBox 369.16900 738.20600 1352.31000 1232.43700
zoomBox 431.33100 773.58800 1267.00200 1193.68500
zoomBox 567.25700 852.50700 1080.46600 1110.50000
zoomBox 672.52600 906.09400 987.70100 1064.53400
zoomBox 697.65700 918.88700 965.55500 1053.56100
zoomBox 752.54400 946.61100 917.06800 1029.31800
zoomBox 786.25200 963.63700 887.29100 1014.43000
zoomBox 794.29900 967.70200 880.18300 1010.87600
zoomBox 786.25200 963.63700 887.29200 1014.43000
zoomBox 776.78500 958.85400 895.65500 1018.61100
zoomBox 765.64600 953.22800 905.49400 1023.53000
zoomBox 777.54100 960.12800 896.41200 1019.88500
zoomBox 796.24600 971.14600 882.13000 1014.32000
zoomBox 751.65200 944.85200 916.17900 1027.56100
zoomBox 735.18700 935.14500 928.75000 1032.45000
zoomBox 693.03000 910.28800 960.93800 1044.96700
zoomBox 666.33500 894.42400 981.52100 1052.87000
zoomBox 634.92900 875.76100 1005.73600 1062.16800
zoomBox 503.93300 796.88300 1107.73100 1100.41600
zoomBox 444.02400 760.81000 1154.37600 1117.90800
zoomBox 464.27100 783.87600 1068.07000 1087.40900
zoomBox 481.48100 803.48200 994.71000 1061.48500
zoomBox 501.34000 825.19300 937.58500 1044.49600
zoomBox 518.89000 843.80500 889.69800 1030.21200
zoomBox 546.48600 873.07200 814.39500 1007.75100
zoomBox 586.63300 908.33900 726.48500 978.64300
zoomBox 603.74300 923.20100 689.63000 966.37700
zoomBox 596.15100 919.44600 697.19500 970.24100
zoomBox 587.21900 915.02700 706.09500 974.78700
zoomBox 576.63400 909.84200 716.49000 980.14800
zoomBox 546.59400 894.49900 740.16600 991.80900
zoomBox 527.49000 884.74200 755.22200 999.22400
zoomBox 468.63500 861.33800 839.46000 1047.75400
zoomBox 371.40000 820.84700 975.22700 1124.39400
zoomBox 140.31100 681.40900 1297.05100 1262.90900
zoomBox -157.65000 506.06100 1725.90900 1452.93700
zoomBox -672.18600 236.92700 2394.87700 1778.75800
zoomBox -905.87000 160.76800 2702.44000 1974.68700
zoomBox -1180.79100 71.17000 3064.27900 2205.19200
zoomBox -1504.22800 -34.24000 3489.97200 2476.37400
zoomBox -1180.79100 71.17000 3064.27900 2205.19200
saveDesign microprocessor_pad_top_pp.enc
setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true
setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -droutePostRouteSpreadWire 1
setNanoRouteMode -quiet -timingEngine {}
setUsefulSkewMode -noBoundary false -maxAllowedDelay 1
setPlaceMode -reset
setPlaceMode -congEffort high -timingDriven 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 0 -placeIOPins 0 -moduleAwareSpare 0 -preserveRouting 1 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0
setPlaceMode -fp false
place_design
setPlaceMode -fp false
place_design
getCTSMode -engine -quiet
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -prePlace -pathReports -drvReports -slackReports -numPaths 500 -prefix microprocessor_pad_top_prePlace -outDir timingReports
getCTSMode -engine -quiet
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -pathReports -drvReports -slackReports -numPaths 500 -prefix microprocessor_pad_top_preCTS -outDir timingReports
getCTSMode -engine -quiet
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -preCTS
saveDesign microprocessor_pad_top_placement.enc
