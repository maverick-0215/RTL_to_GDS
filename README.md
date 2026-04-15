# RTL to GDS

This repository documents the RTL-to-GDS implementation flow for the `microprocessor_pad_top` design. The source RTL, synthesis collateral, implementation artifacts, signoff reports, and reference screenshots are organized so that each checklist step can be traced back to the corresponding output files.

## Flow Overview

1. RTL setup and preprocessing
	- Place the design sources in [rtl design/](rtl%20design/), along with the synthesis and implementation scripts.
	- The design entry points include the module sources, constraints, and run scripts needed for synthesis and place-and-route.

2. Synthesis in Genus
	- Run the Genus flow from the RTL directory using the provided TCL flow file.
	- The synthesis checkpoints are captured in the generic, mapped, optimized, and final reports under [genus files/](genus%20files/) and [rtl design/reports/](rtl%20design/reports/).
	- The outputs include generic netlists, mapped netlists, SDC files, area reports, gate reports, QoR reports, and timing reports.

3. Floorplanning and power planning in Innovus
	- The floorplan is built with explicit die/core sizing and core margins.
	- I/O fillers and pad ring connectivity are added before power network creation.
	- Power rings and stripes are then created on the top metal layers, followed by route-aware placement setup.

4. Placement, CTS, and optimization
	- Placement is performed with congestion-aware settings.
	- Pre-CTS timing is checked before optimization.
	- Clock tree synthesis is run with the CTS script, followed by post-CTS timing cleanup and optimization to reduce or remove violating paths.

5. Routing and signoff
	- Nano-routing completes the routed implementation.
	- Signoff checks cover DRC and netlist connectivity.
	- The final signoff netlists and GDS-related deliverables are stored under [innovus files/](innovus%20files/).

## What Each Folder Contains

### RTL Design Inputs and Intermediate Outputs

- [rtl design/](rtl%20design/) contains the RTL source hierarchy, synthesis/implementation scripts, constraints, and generated intermediate netlists used during the flow.
- [rtl design/outputs/](rtl%20design/outputs/) contains synthesis and equivalence collateral such as the generic, incremental, and mapped netlists, plus formal verification setup files.
- [rtl design/reports/](rtl%20design/reports/) contains the stage-by-stage synthesis reports from generic, mapped, optimized, and final runs.
- [rtl design/fv/microprocessor_pad_top/](rtl%20design/fv/microprocessor_pad_top/) contains formal equivalence mapping collateral.

### Genus Files

- [genus files/generic lists and gates/](genus%20files/generic%20lists%20and%20gates/) contains the generic gate-level netlist report used after initial synthesis.
- [genus files/map netlist files/](genus%20files/map%20netlist%20files/) contains the mapped netlist and timing constraint view used for technology mapping.
- [genus files/report gates and utlization/](genus%20files/report%20gates%20and%20utlization/) contains the final synthesis area, gate-count, and QoR reports.
- [genus files/slack and critical path/](genus%20files/slack%20and%20critical%20path/) contains the final timing report with the worst-case path.
- [genus files/screenshots and report files/images/](genus%20files/screenshots%20and%20report%20files/images/) contains implementation screenshots used to document synthesis and Innovus milestones.
- [genus files/screenshots and report files/reports/](genus%20files/screenshots%20and%20report%20files/reports/) contains the full synthesis report set mirrored from the flow.

### Innovus Files

- [innovus files/io_pins_and_top_file/](innovus%20files/io_pins_and_top_file/) contains the top-level pad-facing netlist and I/O definition files.
- [innovus files/netlist_to_gds/](innovus%20files/netlist_to_gds/) contains the signoff netlists, the netlist connectivity report, and intermediate implementation snapshots.
- [innovus files/gds related/](innovus%20files/gds%20related/) contains the final GDS layout file.
- [innovus files/drc/](innovus%20files/drc/) contains the final design rule check report.

### Work Directory

- [work/](work/) contains the tool-generated run database, implementation snapshots, signoff collateral, and logs produced during the RTL-to-GDS flow. It is the persistent flow workspace rather than a source directory.

## Report and Screenshot Index

### Synthesis Reports

- Generic stage: [generic_area.rpt](rtl%20design/reports/generic_area.rpt), [generic_gates.rpt](rtl%20design/reports/generic_gates.rpt), [generic_qor.rpt](rtl%20design/reports/generic_qor.rpt), [generic_time.rpt](rtl%20design/reports/generic_time.rpt)
- Map stage: [map_area.rpt](rtl%20design/reports/map_area.rpt), [map_gates.rpt](rtl%20design/reports/map_gates.rpt), [map_qor.rpt](rtl%20design/reports/map_qor.rpt), [map_time.rpt](rtl%20design/reports/map_time.rpt)
- Optimized stage: [syn_opt_area.rpt](rtl%20design/reports/syn_opt_area.rpt), [syn_opt_gates.rpt](rtl%20design/reports/syn_opt_gates.rpt), [syn_opt_qor.rpt](rtl%20design/reports/syn_opt_qor.rpt), [syn_opt_time.rpt](rtl%20design/reports/syn_opt_time.rpt)
- Final stage: [final_area.rpt](rtl%20design/reports/final_area.rpt), [final_gates.rpt](rtl%20design/reports/final_gates.rpt), [final_qor.rpt](rtl%20design/reports/final_qor.rpt), [final_time.rpt](rtl%20design/reports/final_time.rpt), [final.rpt](rtl%20design/reports/final.rpt)

### Genus Timing and Netlists

- [microprocessor_pad_top_generic.v](rtl%20design/outputs/microprocessor_pad_top_generic.v)
- [microprocessor_pad_top_incremental.v](rtl%20design/outputs/microprocessor_pad_top_incremental.v)
- [microprocessor_pad_top_map.v](rtl%20design/outputs/microprocessor_pad_top_map.v)
- [microprocessor_pad_top_generic.sdc](rtl%20design/outputs/microprocessor_pad_top_generic.sdc)
- [microprocessor_pad_top_incremental.sdc](rtl%20design/outputs/microprocessor_pad_top_incremental.sdc)
- [microprocessor_pad_top_map.sdc](rtl%20design/outputs/microprocessor_pad_top_map.sdc)
- Formal equivalence flow files: [rtl2intermediate.lec.do](rtl%20design/outputs/rtl2intermediate.lec.do), [intermediate2final.lec.do](rtl%20design/outputs/intermediate2final.lec.do)

### Innovus Signoff Reports

- [checknetlist.rpt](innovus%20files/netlist_to_gds/checknetlist.rpt)
- [microprocessor_pad_top.drc.rpt](innovus%20files/drc/microprocessor_pad_top.drc.rpt)

### Screenshot Gallery

- [CLT synthesis.png](genus%20files/screenshots%20and%20report%20files/images/CLT%20synthesis.png)
- [io_port_summary_innovus.png](genus%20files/screenshots%20and%20report%20files/images/io_port_summary_innovus.png)
- [vdd_vss_alternating.png](genus%20files/screenshots%20and%20report%20files/images/vdd_vss_alternating.png)
- [virtuoso_layout.png](genus%20files/screenshots%20and%20report%20files/images/virtuoso_layout.png)
- [virtuoso_layout_1.png](genus%20files/screenshots%20and%20report%20files/images/virtuoso_layout_1.png)
- [innovus_layout.png](genus%20files/screenshots%20and%20report%20files/images/innovus_layout.png)
- [connectivity.png](genus%20files/screenshots%20and%20report%20files/images/connectivity.png)
- [drc_checks_innovus.png](genus%20files/screenshots%20and%20report%20files/images/drc_checks_innovus.png)

## Key Results

- Final Genus synthesis produced 8,937 leaf instances, 2,692 sequential instances, and 6,245 combinational instances.
- Final synthesis total area is 379,586.276 with 10,457.992 net area.
- Final timing closes with zero total negative slack; the worst reported register-to-register path is MET with 1 ps slack.
- Worst-case path: ALU result register to program counter address register.
- Critical path source: u_microprocessor_core/u_core/u_executepipeline/alu_result_reg[2]/CP.
- Critical path destination: u_microprocessor_core/u_core/u_fetchstage/u_pc0/address_out_reg[0]/D.
- Critical path data path delay: 17,266 ps.
- Clock period: 20,000 ps, which corresponds to 50 MHz.
- Innovus checkDesign reports 57,139 standard cells, 260 I/O pad cells, 39 primary I/O ports, and no DRC violations in the final DRC report.
- The netlist connectivity report shows warnings for multiple tied input pins and unconnected nets, which should be reviewed as signoff documentation rather than ignored.

## Reading Order

1. Start with the flow overview in this README.
2. Inspect the synthesis reports under [rtl design/reports/](rtl%20design/reports/) and [genus files/](genus%20files/).
3. Review the screenshots in [genus files/screenshots and report files/images/](genus%20files/screenshots%20and%20report%20files/images/).
4. Check the signoff collateral in [innovus files/netlist_to_gds/](innovus%20files/netlist_to_gds/) and [innovus files/drc/](innovus%20files/drc/).
5. Use [work/](work/) if you need the full flow database or intermediate implementation state.