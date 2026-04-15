`timescale 1ns/1ps

module microprocessor_simple_tb;
    reg clk;
    reg rst;
    reg [1:0] mem_bank_sel;
    reg [1:0] dbg_sel;
    wire clkout;
    wire [31:0] dbg_out;

    integer cycles;
    integer errors;

    microprocessor #(
        .INSTR_MEM_FILE("verification/simple_rv32i.mem")
    ) dut (
        .clk(clk),
        .rst(rst),
        .mem_bank_sel(mem_bank_sel),
        .dbg_sel(dbg_sel),
        .CLKOUT(clkout),
        .dbg_out(dbg_out)
    );

    always #5 clk = ~clk;

    task check_eq;
        input [31:0] got;
        input [31:0] exp;
        input [255:0] msg;
        begin
            if (got !== exp) begin
                $display("FAIL: %0s got=0x%08h exp=0x%08h", msg, got, exp);
                errors = errors + 1;
            end
            else begin
                $display("PASS: %0s = 0x%08h", msg, got);
            end
        end
    endtask

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        mem_bank_sel = 2'b00;
        dbg_sel = 2'b00;
        cycles = 0;
        errors = 0;

        repeat (4) @(posedge clk);
        rst = 1'b1;

        repeat (60) begin
            @(posedge clk);
            cycles = cycles + 1;
        end

        check_eq(dut.u_core.u_decodestage.u_regfile0.register[1], 32'd5, "x1 (I-type addi)");
        check_eq(dut.u_core.u_decodestage.u_regfile0.register[2], 32'd3, "x2 (I-type addi)");
        check_eq(dut.u_core.u_decodestage.u_regfile0.register[3], 32'd8, "x3 (R-type add)");
        check_eq(dut.u_data_memory.u_memory.mem[0], 32'd8, "mem[0] after S-type sw");
        check_eq(dut.u_core.u_decodestage.u_regfile0.register[4], 32'd8, "x4 (I-type lw)");
        check_eq(dut.u_core.u_decodestage.u_regfile0.register[5], 32'd77, "x5 (B-type beq skip)");
        check_eq(dut.u_core.u_decodestage.u_regfile0.register[6], 32'h12345000, "x6 (U-type lui)");
        check_eq(dut.u_core.u_decodestage.u_regfile0.register[7], 32'd36, "x7 (J-type jal)");

        if (errors == 0) begin
            $display("RESULT: PASS (%0d cycles)", cycles);
        end
        else begin
            $display("RESULT: FAIL (%0d errors, %0d cycles)", errors, cycles);
        end

        $finish;
    end
endmodule
