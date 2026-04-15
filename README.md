# RTL to GDS

## Directory Structure

### Genus Files (Synthesis)
- **generic_lists_and_gates/:** Generic gate-level netlist
- **map_netlist_files/:** Mapped netlist with SDC constraints
- **report_gates_and_utilization/:** Design metrics and utilization reports
- **slack_and_critical_path/:** Timing reports including critical path analysis
- **screenshots_and_report_files/:** Comprehensive timing, area, QoR reports

### Innovus Files (Place & Route)
- **io_pins_and_top_file/:** Top module and IO pin definitions
- **netlist_to_gds/:** Final signoff netlists (with/without power grid) and intermediate snapshots
- **gds_related/:** Final GDS layout (risc_v.gds)
- **drc/:** Design Rule Check reports

---

## Critical Path Information

**Worst-Case Path:** ALU Result Register → Program Counter Address Register  
- **Source:** `u_microprocessor_core/u_core/u_executepipeline/alu_result_reg[2]/CP`
- **Destination:** `u_microprocessor_core/u_core/u_fetchstage/u_pc0/address_out_reg[0]/D`
- **Data Path Delay:** 17,266 ps
- **Slack:** 1 ps (MET)
- **Clock Period:** 20,000 ps (50 MHz)
- **Operating Condition:** tsl18cio150_max (worst_case_tree)

---