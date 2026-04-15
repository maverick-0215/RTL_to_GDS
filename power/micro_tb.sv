`timescale 1ns/10ps

module micro_tb;

    // ================= PARAMETERS =================
    localparam CLK_PERIOD = 20;

    // ================= SIGNALS =================
    reg clk;
    reg rst;
    reg [1:0] mem_bank_sel;
    reg [1:0] dbg_sel;

    wire CLKOUT;
    wire [31:0] dbg_out;

    // ================= CLOCK =================
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // ================= DUT ===================
    microprocessor dut (
        .clk(clk),
        .rst(rst),
        .mem_bank_sel(mem_bank_sel),
        .dbg_sel(dbg_sel),
        .CLKOUT(CLKOUT),
        .dbg_out(dbg_out)
    );

    // ================= TEST ==================
    initial begin

        // -------- VCD (VERY IMPORTANT FOR POWER) --------
        $dumpfile("micro_gls.vcd");

        // minimal + full hierarchy dump
        $dumpvars(1, clk);
        $dumpvars(0, micro_tb);
        $dumpvars(0, micro_tb.dut);

        $display("==== GLS MICROPROCESSOR TESTBENCH ====");

        // -------- INIT --------
        rst = 0;
        mem_bank_sel = 2'b00;
        dbg_sel = 2'b00;

        // -------- RESET --------
        #100;
        rst = 1;
        #100;

        $display("==== RESET DONE ====");

        // -------- RUN WORKLOAD --------
        // Let CPU execute instructions (hardcoded in incremental netlist)

        #1000;
        dbg_sel = 2'b01;

        #1000;
        dbg_sel = 2'b10;

        #1000;
        dbg_sel = 2'b11;

        // long run ? needed for POWER accuracy
        #10000;

        $display("==== TEST COMPLETED ====");
        $finish;
    end

endmodule