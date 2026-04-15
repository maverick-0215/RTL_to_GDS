# RTL to GDS

This repository documents the RTL-to-GDS implementation flow for the `microprocessor_pad_top` design. The source RTL, synthesis files, implementation outputs, signoff reports, and reference screenshots are organized so that each checklist step can be traced back to the corresponding results.

## Final Signoff Snapshot

- Final setup slack (worst R2R path): **+1 ps (MET)**
- Critical path: **ALU result register -> Program counter address register**
- Critical path source pin: **u_microprocessor_core/u_core/u_executepipeline/alu_result_reg[2]/CP**
- Critical path destination pin: **u_microprocessor_core/u_core/u_fetchstage/u_pc0/address_out_reg[0]/D**
- Critical data path delay: **17,266 ps**
- Clock period / frequency: **20,000 ps / 50 MHz**
- Final total area: **379,586.276**
- Final cell area: **369,128.284**
- Final net area: **10,457.992**
- Final synthesis instance count: **8,937 leaf** (2,692 sequential, 6,245 combinational)
- Final DRC status: **No DRC violations found**
- Connectivity check summary: **Warnings present in checkDesign/checknetlist reports; review required during signoff**

## Top-Level I/O and Debug Output Architecture

### Inputs

- 1 pin for clock
- 1 pin for reset
- 2 pins for instruction memory selection
- 2 pins for output selection

### Outputs

- 32 pins forming a single 32-bit output bus
- 1 pin for clk_out

### I/O Functionality

- A 2-bit input selects which instruction memory is active.
- A separate 2-bit input selects which internal signals are routed to the output.
- Based on the output-select input, a multiplexer routes different internal signals to the same 32-bit output bus.
- This allows pin reuse for visibility into multiple processor internals without dedicating separate external output groups.

### Output Modes (Output Select)

- Mode 0: Four register values (each 8 bits) packed into 32 bits.
- Mode 1: Lower 8 bits contain the program counter; upper 24 bits contain control signals.
- Mode 2: Full 32-bit current instruction output.
- Mode 3: ALU input 1 (8 bits), ALU input 2 (8 bits), ALU output (8 bits), and data memory output (8 bits), all packed into 32 bits.

### Instruction Memory Implementation

- Four separate instruction memories are implemented.
- Each instruction memory contains around 32 instructions.
- The memories are hardcoded in RTL (ROM-based).
- A dedicated 2-bit input selects which instruction memory is active.
- Each memory is intended to exercise a different processor function.
- Only one instruction memory is accessed at a time based on the selection input.

## Flow Overview

1. RTL setup and preprocessing
	- Place the design sources in [rtl design/](rtl%20design/), along with the synthesis and implementation scripts.
	- The design entry points include the module sources, constraints, and run scripts needed for synthesis and place-and-route.

2. Synthesis in Genus
	- Run the Genus flow from the RTL directory using the provided TCL flow file.
	- The synthesis checkpoints are captured in the generic, mapped, optimized, and final reports under [genus files/](genus%20files/) and [rtl design/reports/](rtl%20design/reports/).
	- The files include generic netlists, mapped netlists, SDC files, area reports, gate reports, QoR reports, and timing reports.

	![Genus synthesis stage](genus%20files/screenshots%20and%20report%20files/images/CLT%20synthesis.png)

3. Floorplanning and power planning in Innovus
	- The floorplan is built with explicit die/core sizing and core margins.
	- I/O fillers and pad ring connectivity are added before power network creation.
	- Power rings and stripes are then created on the top metal layers, followed by route-aware placement setup.

	![I/O port summary in Innovus](genus%20files/screenshots%20and%20report%20files/images/io_port_summary_innovus.png)
	![VDD and VSS ring/rail planning](genus%20files/screenshots%20and%20report%20files/images/vdd_vss_alternating.png)

4. Placement, CTS, and optimization
	- Placement is performed with congestion-aware settings.
	- Pre-CTS timing is checked before optimization.
	- Clock tree synthesis is run with the CTS script, followed by post-CTS timing cleanup and optimization to reduce or remove violating paths.

	![Innovus placed and routed layout view](genus%20files/screenshots%20and%20report%20files/images/innovus_layout.png)

5. Routing and signoff
	- Nano-routing completes the routed implementation.
	- Signoff checks cover DRC and netlist connectivity.
	- The final signoff netlists and GDS-related files are stored under [innovus files/](innovus%20files/).

	![Connectivity check](genus%20files/screenshots%20and%20report%20files/images/connectivity.png)
	![DRC check](genus%20files/screenshots%20and%20report%20files/images/drc_checks_innovus.png)
	![Final layout view in Virtuoso](genus%20files/screenshots%20and%20report%20files/images/virtuoso_layout.png)
	![Alternate final layout view](genus%20files/screenshots%20and%20report%20files/images/virtuoso_layout_1.png)

## What Each Folder Contains

### RTL Design Inputs and Intermediate Outputs

- [rtl design/](rtl%20design/) contains the RTL source hierarchy, synthesis/implementation scripts, constraints, and generated intermediate netlists used during the flow.
- [rtl design/outputs/](rtl%20design/outputs/) contains synthesis and equivalence files such as the generic, incremental, and mapped netlists, plus formal verification setup files.
- [rtl design/reports/](rtl%20design/reports/) contains the stage-by-stage synthesis reports from generic, mapped, optimized, and final runs.
- [rtl design/fv/microprocessor_pad_top/](rtl%20design/fv/microprocessor_pad_top/) contains formal equivalence mapping files.

### Genus Files

- [genus files/generic lists and gates/](genus%20files/generic%20lists%20and%20gates/) contains the generic gate-level netlist report used after initial synthesis.
- [genus files/map netlist files/](genus%20files/map%20netlist%20files/) contains the mapped netlist and timing constraint view used for technology mapping.
- [genus files/report gates and utlization/](genus%20files/report%20gates%20and%20utlization/) contains the final synthesis area, gate-count, and QoR reports.
- [genus files/slack and critical path/](genus%20files/slack%20and%20critical%20path/) contains the final timing report with the worst-case path.
- [genus files/screenshots and report files/images/](genus%20files/screenshots%20and%20report%20files/images/) contains the screenshots used to document synthesis and Innovus milestones.
- [genus files/screenshots and report files/reports/](genus%20files/screenshots%20and%20report%20files/reports/) contains the full synthesis report set mirrored from the flow.

### Innovus Files

- [innovus files/io_pins_and_top_file/](innovus%20files/io_pins_and_top_file/) contains the top-level pad-facing netlist and I/O definition files.
- [innovus files/netlist_to_gds/](innovus%20files/netlist_to_gds/) contains the signoff netlists, the netlist connectivity report, and intermediate implementation snapshots.
- [innovus files/gds related/](innovus%20files/gds%20related/) contains the final GDS layout file.
- [innovus files/drc/](innovus%20files/drc/) contains the final design rule check report.

### Work Directory

- [work/](work/) contains the tool-generated run database, implementation snapshots, signoff files, and logs produced during the RTL-to-GDS flow. It is the persistent flow workspace rather than a source directory.

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

### Power Report


---

#### Key Observations
- **Total Power**: **24.19 mW**
- **Registers dominate (~97.6%)**
- **Memory Power**: 0 (inactive/not exercised)




---


### Visual References

- All flow screenshots are embedded directly in the Flow Overview steps above.

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
- The netlist connectivity report shows warnings for multiple tied input pins and unconnected nets, which should be reviewed during signoff.

## Reading Order

1. Start with the flow overview in this README.
2. Inspect the synthesis reports under [rtl design/reports/](rtl%20design/reports/) and [genus files/](genus%20files/).
3. Review the screenshots in [genus files/screenshots and report files/images/](genus%20files/screenshots%20and%20report%20files/images/).
4. Check the signoff files in [innovus files/netlist_to_gds/](innovus%20files/netlist_to_gds/) and [innovus files/drc/](innovus%20files/drc/).
5. Use [work/](work/) if you need the full flow database or intermediate implementation state.
