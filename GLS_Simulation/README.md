## GLS Simulation Results

The GLS simulation was completed using the pad-level top testbench `microprocessor_pad_top_tb`, and the generated VCD files are available in `GLS_Simulation/fft_gls/microprocessor_tb.vcd` and `GLS_Simulation/fft_sim/microprocessor_tb.vcd`.

### Simulation Top And Signals
- **Testbench top module:** `microprocessor_pad_top_tb`
- **DUT instance:** `uut`
- **VCD timescale:** 1 ps

### Instructions Exercised In GLS
The GLS instruction memory covers a mixed program with the following instruction types:
- **I-type:** `addi`, `xori`, `andi`, `slli`
- **R-type:** `add`, `sub`, `and`, `or`, `sll`
- **S-type:** `sw`
- **U-type:** `lui`, `auipc`
- **B-type:** `beq`, `bne`, `blt`, `bge`, `bltu`
- **J-type:** `jal`


### GLS Note
- GLS simulation was run successfully with instruction and waveform evidence in the `GLS_Simulation/` folder.
- The waveform database captures the pad-level top module and the DUT hierarchy needed for simulation screenshots and VCD-based verification.
- The instruction stream includes arithmetic, logical, memory, branch, and jump operations, and the expected register updates are visible from the program behavior.
