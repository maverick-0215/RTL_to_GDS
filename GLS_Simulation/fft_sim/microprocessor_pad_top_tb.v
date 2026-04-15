`timescale 1ns/1ps

module microprocessor_pad_top_tb;

    // -----------------------------------------------------------
    // Testbench Signals
    // -----------------------------------------------------------
    reg         tb_clk_pad;
    reg         tb_rst_pad;
    reg  [1:0]  tb_mem_bank_sel_pad;
    reg  [1:0]  tb_dbg_sel_pad;
    
    wire        tb_CLKOUT_pad;
    wire [31:0] tb_dbg_out_pad;

    // -----------------------------------------------------------
    // Device Under Test (DUT) Instantiation
    // -----------------------------------------------------------
    microprocessor_pad_top uut (
        .clk_pad          (tb_clk_pad),
        .rst_pad          (tb_rst_pad),
        .mem_bank_sel_pad (tb_mem_bank_sel_pad),
        .dbg_sel_pad      (tb_dbg_sel_pad),
        .CLKOUT_pad       (tb_CLKOUT_pad),
        .dbg_out_pad      (tb_dbg_out_pad)
    );

    // -----------------------------------------------------------
    // Clock Generation (100 MHz / 10ns period)
    // -----------------------------------------------------------
    initial begin
        tb_clk_pad = 1'b0;
        forever #5 tb_clk_pad = ~tb_clk_pad; 
    end

    // -----------------------------------------------------------
    // Waveform Dumping (For GTKWave / ModelSim / Vivado)
    // -----------------------------------------------------------
    initial begin
        $dumpfile("microprocessor_tb.vcd");
        $dumpvars(0, microprocessor_pad_top_tb);
    end

    // -----------------------------------------------------------
    // Test Stimulus
    // -----------------------------------------------------------
    initial begin
        // 1. Initialize Inputs
        tb_rst_pad          = 1'b1; // Assuming active-low reset based on common pad usage
        tb_mem_bank_sel_pad = 2'b00;
        tb_dbg_sel_pad      = 2'b00;

        // 2. Apply Reset
        $display("[%0t] Applying Reset...", $time);
        #15;
        tb_rst_pad = 1'b0; // Assert reset
        #20;
        tb_rst_pad = 1'b1; // De-assert reset
        $display("[%0t] Reset Complete. CPU running...", $time);

        // 3. Test sequence: Run Bank 0
        #100;
        $display("[%0t] Switching to Debug View 1...", $time);
        tb_dbg_sel_pad = 2'b01;
        
        #100;
        $display("[%0t] Switching to Debug View 2...", $time);
        tb_dbg_sel_pad = 2'b10;

        // 4. Switch Memory Banks
        #100;
        $display("[%0t] Switching to Memory Bank 1...", $time);
        tb_mem_bank_sel_pad = 2'b01;
        tb_dbg_sel_pad      = 2'b00; // Reset debug view

        #100;
        $display("[%0t] Switching to Memory Bank 2...", $time);
        tb_mem_bank_sel_pad = 2'b10;

        #100;
        $display("[%0t] Switching to Memory Bank 3...", $time);
        tb_mem_bank_sel_pad = 2'b11;

        // Allow some time for final instructions to execute
        #200;
        
        $display("[%0t] Simulation Complete.", $time);
        $finish;
    end

    // -----------------------------------------------------------
    // Monitor Outputs
    // -----------------------------------------------------------
    initial begin
        $monitor("Time: %0t | RST: %b | BankSel: %b | DbgSel: %b | DBG_OUT: %h", 
                 $time, tb_rst_pad, tb_mem_bank_sel_pad, tb_dbg_sel_pad, tb_dbg_out_pad);
    end

endmodule
