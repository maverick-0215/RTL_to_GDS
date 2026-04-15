module instruction_memory #(
    parameter INIT_FILE = ""
) (
    input wire        request,
    input wire [7:0]  address,
    input wire [1:0]  bank_sel,
    output reg [31:0] data_out
);
    localparam [31:0] NOP = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000

    wire [4:0] addr_idx;
    // cadence translate_off
    wire [7:0] sim_addr_idx;
    // cadence translate_on
    wire addr_out_of_range;
    reg [31:0] bank_data;

    // cadence translate_off
    // Keep simulation-visible memory arrays for existing TB hierarchical pokes.
    reg [31:0] mem [0:255];
    reg [31:0] mem_bank1 [0:255];
    reg [31:0] mem_bank2 [0:255];
    reg [31:0] mem_bank3 [0:255];
    reg [31:0] sim_bank_data;
    integer i;
    // cadence translate_on

    assign addr_idx = address[4:0];
    // cadence translate_off
    assign sim_addr_idx = address;
    // cadence translate_on
    // Fabrication mode uses 32 words per bank; higher word addresses read NOP.
    assign addr_out_of_range = |address[7:5];

    function automatic [31:0] bank0_rom;
        input [4:0] idx;
        begin
            case (idx)
                5'd0: bank0_rom = 32'h00500293; // addi x5, x0, 5 | exp: x5=0x00000005
                5'd1: bank0_rom = 32'h00700313; // addi x6, x0, 7 | exp: x6=0x00000007
                5'd2: bank0_rom = 32'h006283B3; // add x7, x5, x6 | exp: x7=0x0000000C
                5'd3: bank0_rom = 32'h12345437; // lui x8, 0x12345 | exp: x8=0x12345000
                5'd4: bank0_rom = 32'h00702023; // sw x7, 0(x0) | exp: M[0x00]=0x0000000C
                5'd5: bank0_rom = 32'h00002483; // lw x9, 0(x0) | exp: x9=0x0000000C
                5'd6: bank0_rom = 32'h00748663; // beq x9, x7, +12 | exp: taken -> skip idx7,8
                5'd7: bank0_rom = 32'h01100513; // addi x10, x0, 0x11 | exp: skipped
                5'd8: bank0_rom = 32'h02200513; // addi x10, x0, 0x22 | exp: skipped
                5'd9: bank0_rom = 32'h00C002EF; // jal x5, +12 | exp: x5=0x00000028, skip idx10,11
                5'd10: bank0_rom = 32'h03300313; // addi x6, x0, 0x33 | exp: skipped
                5'd11: bank0_rom = 32'h04400313; // addi x6, x0, 0x44 | exp: skipped
                5'd12: bank0_rom = 32'h05500393; // addi x7, x0, 0x55 | exp: x7=0x00000055
                5'd13: bank0_rom = 32'h0000006F; // jal x0, 0 | exp: PC holds (self-loop)
                5'd14: bank0_rom = NOP;
                5'd15: bank0_rom = NOP;
                5'd16: bank0_rom = NOP;
                5'd17: bank0_rom = NOP;
                5'd18: bank0_rom = NOP;
                5'd19: bank0_rom = NOP;
                5'd20: bank0_rom = NOP;
                5'd21: bank0_rom = NOP;
                5'd22: bank0_rom = NOP;
                5'd23: bank0_rom = NOP;
                5'd24: bank0_rom = NOP;
                5'd25: bank0_rom = NOP;
                5'd26: bank0_rom = NOP;
                5'd27: bank0_rom = NOP;
                5'd28: bank0_rom = NOP;
                5'd29: bank0_rom = NOP;
                5'd30: bank0_rom = NOP;
                5'd31: bank0_rom = NOP;
                default: bank0_rom = NOP;
            endcase
        end
    endfunction

    function automatic [31:0] bank1_rom;
        input [4:0] idx;
        begin
            case (idx)
                5'd0: bank1_rom = 32'h00500093; // addi x1, x0, 5 | exp: x1=0x00000005
                5'd1: bank1_rom = 32'h00500113; // addi x2, x0, 5 | exp: x2=0x00000005
                5'd2: bank1_rom = 32'h00100193; // addi x3, x0, 1 | exp: x3=0x00000001
                5'd3: bank1_rom = 32'h00000F93; // addi x31, x0, 0 | exp: x31=0x00000000
                5'd4: bank1_rom = 32'h00208663; // beq x1, x2, +12 | exp: taken -> skip idx5,6
                5'd5: bank1_rom = 32'h001F8F93; // addi x31, x31, 1 | exp: (skipped here)
                5'd6: bank1_rom = 32'h001F8F93; // addi x31, x31, 1 | exp: (skipped here)
                5'd7: bank1_rom = 32'h00209463; // bne x1, x2, +8 | exp: not taken
                5'd8: bank1_rom = 32'h002F8F93; // addi x31, x31, 2 | exp: x31=0x00000002
                5'd9: bank1_rom = 32'h0021C463; // blt x3, x2, +8 | exp: taken
                5'd10: bank1_rom = 32'h004F8F93; // addi x31, x31, 4 | exp: (skipped here)
                5'd11: bank1_rom = 32'h00115463; // bge x2, x1, +8 | exp: taken
                5'd12: bank1_rom = 32'h008F8F93; // addi x31, x31, 8 | exp: (skipped here)
                5'd13: bank1_rom = 32'h0021E463; // bltu x3, x2, +8 | exp: taken
                5'd14: bank1_rom = 32'h010F8F93; // addi x31, x31, 1 | exp: (skipped here)6
                5'd15: bank1_rom = 32'h00317463; // bgeu x2, x3, +8 | exp: taken
                5'd16: bank1_rom = 32'h020F8F93; // addi x31, x31, 32 | exp: (skipped here)
                5'd17: bank1_rom = 32'h00000717; // auipc x14, 0 | exp: x14=0x00000044
                5'd18: bank1_rom = 32'h00C0036F; // jal x6, +12 | exp: x6=0x0000004C
                5'd19: bank1_rom = 32'h040F8F93; // addi x31, x31, 64 | exp: (idx19/20 skipped, idx23 skipped, idx26 skipped)
                5'd20: bank1_rom = 32'h040F8F93; // addi x31, x31, 64 | exp: (idx19/20 skipped, idx23 skipped, idx26 skipped)
                5'd21: bank1_rom = 32'h04D00793; // addi x15, x0, 77 | exp: x15=0x0000004D
                5'd22: bank1_rom = 32'h01C703E7; // jalr x7, 28(x14) | exp: x7=0x0000005C, PC=0x00000060
                5'd23: bank1_rom = 32'h040F8F93; // addi x31, x31, 64 | exp: (idx19/20 skipped, idx23 skipped, idx26 skipped)
                5'd24: bank1_rom = 32'h05800813; // addi x16, x0, 88 | exp: x16=0x00000058
                5'd25: bank1_rom = 32'h00000463; // beq x0, x0, +8 | exp: taken
                5'd26: bank1_rom = 32'h040F8F93; // addi x31, x31, 64 | exp: (idx19/20 skipped, idx23 skipped, idx26 skipped)
                5'd27: bank1_rom = 32'h06300893; // addi x17, x0, 99 | exp: x17=0x00000063
                5'd28: bank1_rom = 32'h0000006F; // jal x0, 0 | exp: PC holds (self-loop)
                default: bank1_rom = NOP;
            endcase
        end
    endfunction

    function automatic [31:0] bank2_rom;
        input [4:0] idx;
        begin
            case (idx)
                5'd0: bank2_rom = 32'h00700093; // addi x1, x0, 7 | exp: x1=0x00000007
                5'd1: bank2_rom = 32'h00900113; // addi x2, x0, 9 | exp: x2=0x00000009
                5'd2: bank2_rom = 32'h002081B3; // add x3, x1, x2 | exp: x3=0x00000010
                5'd3: bank2_rom = 32'h40118233; // sub x4, x3, x1 | exp: x4=0x00000009
                5'd4: bank2_rom = 32'h00520293; // addi x5, x4, 5 | exp: x5=0x0000000E
                5'd5: bank2_rom = 32'h00502023; // sw x5, 0(x0) | exp: M[0x00]=0x0000000E
                5'd6: bank2_rom = 32'h00002303; // lw x6, 0(x0) | exp: x6=0x0000000E
                5'd7: bank2_rom = 32'h002303B3; // add x7, x6, x2 | exp: x7=0x00000017
                5'd8: bank2_rom = 32'h00138413; // addi x8, x7, 1 | exp: x8=0x00000018
                5'd9: bank2_rom = 32'h003404B3; // add x9, x8, x3 | exp: x9=0x00000028
                5'd10: bank2_rom = 32'h00902223; // sw x9, 4(x0) | exp: M[0x04]=0x00000028
                5'd11: bank2_rom = 32'h00402503; // lw x10, 4(x0) | exp: x10=0x00000028
                5'd12: bank2_rom = 32'h00950463; // beq x10, x9, +8 | exp: taken
                5'd13: bank2_rom = 32'h06300593; // addi x11, x0, 99 | exp: (skipped here)
                5'd14: bank2_rom = 32'h03700593; // addi x11, x0, 55 | exp: x11=0x00000037
                5'd15: bank2_rom = 32'h00300613; // addi x12, x0, 3 | exp: x12=0x00000003
                5'd16: bank2_rom = 32'h00B606B3; // add x13, x12, x11 | exp: x13=0x0000003A
                5'd17: bank2_rom = 32'h00D02423; // sw x13, 8(x0) | exp: M[0x08]=0x0000003A
                5'd18: bank2_rom = 32'h00802703; // lw x14, 8(x0) | exp: x14=0x0000003A
                5'd19: bank2_rom = 32'h001707B3; // add x15, x14, x1 | exp: x15=0x00000041
                5'd20: bank2_rom = 32'h00078A13; // addi x20, x15, 0 | exp: x20=0x00000041
                5'd21: bank2_rom = 32'h00050A93; // addi x21, x10, 0 | exp: x21=0x00000028
                5'd22: bank2_rom = 32'h00030B13; // addi x22, x6, 0 | exp: x22=0x0000000E
                5'd23: bank2_rom = 32'h0000006F; // jal x0, 0 | exp: PC holds (self-loop)
                default: bank2_rom = NOP;
            endcase
        end
    endfunction

    function automatic [31:0] bank3_rom;
        input [4:0] idx;
        begin
            case (idx)
                5'd0: bank3_rom = 32'h00A00093; // addi x1, x0, 10 | exp: x1=0x0000000A
                5'd1: bank3_rom = 32'h00000113; // addi x2, x0, 0 | exp: x2=0x00000000
                5'd2: bank3_rom = 32'h00100193; // addi x3, x0, 1 | exp: x3=0x00000001
                5'd3: bank3_rom = 32'h00000213; // addi x4, x0, 0 | exp: x4=0x00000000
                5'd4: bank3_rom = 32'h00120C63; // beq x4, x1, +24 | exp: taken when x4 reaches 0x0000000A
                5'd5: bank3_rom = 32'h003102B3; // add x5, x2, x3 | exp: final x5=0x00000059
                5'd6: bank3_rom = 32'h00018113; // addi x2, x3, 0 | exp: final x2=0x00000037
                5'd7: bank3_rom = 32'h00028193; // addi x3, x5, 0 | exp: final x3=0x00000059
                5'd8: bank3_rom = 32'h00120213; // addi x4, x4, 1 | exp: final x4=0x0000000A
                5'd9: bank3_rom = 32'hFEDFF06F; // jal x0, -20 | exp: loop back until x4==x1
                5'd10: bank3_rom = 32'h00202023; // sw x2, 0(x0) | exp: M[0x00]=0x00000037
                5'd11: bank3_rom = 32'h00010513; // addi x10, x2, 0 | exp: x10=0x00000037
                5'd12: bank3_rom = 32'h00018593; // addi x11, x3, 0 | exp: x11=0x00000059
                5'd13: bank3_rom = 32'h00020613; // addi x12, x4, 0 | exp: x12=0x0000000A
                5'd14: bank3_rom = 32'h00008693; // addi x13, x1, 0 | exp: x13=0x0000000A
                5'd15: bank3_rom = 32'h0000006F; // jal x0, 0 | exp: PC holds (self-loop)
                default: bank3_rom = NOP;
            endcase
        end
    endfunction

    always @(*) begin
        case (bank_sel)
            2'b00: bank_data = bank0_rom(addr_idx);
            2'b01: bank_data = bank1_rom(addr_idx);
            2'b10: bank_data = bank2_rom(addr_idx);
            2'b11: bank_data = bank3_rom(addr_idx);
            default: bank_data = NOP;
        endcase
    end

    // cadence translate_off
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i]       = NOP;
            mem_bank1[i] = NOP;
            mem_bank2[i] = NOP;
            mem_bank3[i] = NOP;
        end

        if (INIT_FILE != "") begin
            $readmemh(INIT_FILE, mem);
        end
        else begin
            mem[0] = 32'h00500293; // addi x5, x0, 5 | exp: x5=0x00000005
            mem[1] = 32'h00700313; // addi x6, x0, 7 | exp: x6=0x00000007
            mem[2] = 32'h006283B3; // add x7, x5, x6 | exp: x7=0x0000000C
            mem[3] = 32'h12345437; // lui x8, 0x12345 | exp: x8=0x12345000
            mem[4] = 32'h00702023; // sw x7, 0(x0) | exp: M[0x00]=0x0000000C
            mem[5] = 32'h00002483; // lw x9, 0(x0) | exp: x9=0x0000000C
            mem[6] = 32'h00748663; // beq x9, x7, +12 | exp: taken -> skip idx7,8
            mem[7] = 32'h01100513; // addi x10, x0, 0x11 | exp: skipped
            mem[8] = 32'h02200513; // addi x10, x0, 0x22 | exp: skipped
            mem[9] = 32'h00C002EF; // jal x5, +12 | exp: x5=0x00000028, skip idx10,11
            mem[10] = 32'h03300313; // addi x6, x0, 0x33 | exp: skipped
            mem[11] = 32'h04400313; // addi x6, x0, 0x44 | exp: skipped
            mem[12] = 32'h05500393; // addi x7, x0, 0x55 | exp: x7=0x00000055
            mem[13] = 32'h0000006F; // jal x0, 0 | exp: PC holds (self-loop)
            mem[14] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[15] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[16] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[17] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[18] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[19] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[20] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[21] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[22] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[23] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[24] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[25] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[26] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[27] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[28] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[29] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[30] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
            mem[31] = 32'h00000013; // addi x0, x0, 0 | exp: x0=0x00000000
        end

        mem_bank1[0] = 32'h00500093; // addi x1, x0, 5 | exp: x1=0x00000005
        mem_bank1[1] = 32'h00500113; // addi x2, x0, 5 | exp: x2=0x00000005
        mem_bank1[2] = 32'h00100193; // addi x3, x0, 1 | exp: x3=0x00000001
        mem_bank1[3] = 32'h00000F93; // addi x31, x0, 0 | exp: x31=0x00000000
        mem_bank1[4] = 32'h00208663; // beq x1, x2, +12 | exp: taken -> skip idx5,6
        mem_bank1[5] = 32'h001F8F93; // addi x31, x31, 1 | exp: (skipped here)
        mem_bank1[6] = 32'h001F8F93; // addi x31, x31, 1 | exp: (skipped here)
        mem_bank1[7] = 32'h00209463; // bne x1, x2, +8 | exp: not taken
        mem_bank1[8] = 32'h002F8F93; // addi x31, x31, 2 | exp: x31=0x00000002
        mem_bank1[9] = 32'h0021C463; // blt x3, x2, +8 | exp: taken
        mem_bank1[10] = 32'h004F8F93; // addi x31, x31, 4 | exp: (skipped here)
        mem_bank1[11] = 32'h00115463; // bge x2, x1, +8 | exp: taken
        mem_bank1[12] = 32'h008F8F93; // addi x31, x31, 8 | exp: (skipped here)
        mem_bank1[13] = 32'h0021E463; // bltu x3, x2, +8 | exp: taken
        mem_bank1[14] = 32'h010F8F93; // addi x31, x31, 1 | exp: (skipped here)6
        mem_bank1[15] = 32'h00317463; // bgeu x2, x3, +8 | exp: taken
        mem_bank1[16] = 32'h020F8F93; // addi x31, x31, 32 | exp: (skipped here)
        mem_bank1[17] = 32'h00000717; // auipc x14, 0 | exp: x14=0x00000044
        mem_bank1[18] = 32'h00C0036F; // jal x6, +12 | exp: x6=0x0000004C
        mem_bank1[19] = 32'h040F8F93; // addi x31, x31, 64 | exp: (idx19/20 skipped, idx23 skipped, idx26 skipped)
        mem_bank1[20] = 32'h040F8F93; // addi x31, x31, 64 | exp: (idx19/20 skipped, idx23 skipped, idx26 skipped)
        mem_bank1[21] = 32'h04D00793; // addi x15, x0, 77 | exp: x15=0x0000004D
        mem_bank1[22] = 32'h01C703E7; // jalr x7, 28(x14) | exp: x7=0x0000005C, PC=0x00000060
        mem_bank1[23] = 32'h040F8F93; // addi x31, x31, 64 | exp: (idx19/20 skipped, idx23 skipped, idx26 skipped)
        mem_bank1[24] = 32'h05800813; // addi x16, x0, 88 | exp: x16=0x00000058
        mem_bank1[25] = 32'h00000463; // beq x0, x0, +8 | exp: taken
        mem_bank1[26] = 32'h040F8F93; // addi x31, x31, 64 | exp: (idx19/20 skipped, idx23 skipped, idx26 skipped)
        mem_bank1[27] = 32'h06300893; // addi x17, x0, 99 | exp: x17=0x00000063
        mem_bank1[28] = 32'h0000006F; // jal x0, 0 | exp: PC holds (self-loop)

        mem_bank2[0] = 32'h00700093; // addi x1, x0, 7 | exp: x1=0x00000007
        mem_bank2[1] = 32'h00900113; // addi x2, x0, 9 | exp: x2=0x00000009
        mem_bank2[2] = 32'h002081B3; // add x3, x1, x2 | exp: x3=0x00000010
        mem_bank2[3] = 32'h40118233; // sub x4, x3, x1 | exp: x4=0x00000009
        mem_bank2[4] = 32'h00520293; // addi x5, x4, 5 | exp: x5=0x0000000E
        mem_bank2[5] = 32'h00502023; // sw x5, 0(x0) | exp: M[0x00]=0x0000000E
        mem_bank2[6] = 32'h00002303; // lw x6, 0(x0) | exp: x6=0x0000000E
        mem_bank2[7] = 32'h002303B3; // add x7, x6, x2 | exp: x7=0x00000017
        mem_bank2[8] = 32'h00138413; // addi x8, x7, 1 | exp: x8=0x00000018
        mem_bank2[9] = 32'h003404B3; // add x9, x8, x3 | exp: x9=0x00000028
        mem_bank2[10] = 32'h00902223; // sw x9, 4(x0) | exp: M[0x04]=0x00000028
        mem_bank2[11] = 32'h00402503; // lw x10, 4(x0) | exp: x10=0x00000028
        mem_bank2[12] = 32'h00950463; // beq x10, x9, +8 | exp: taken
        mem_bank2[13] = 32'h06300593; // addi x11, x0, 99 | exp: (skipped here)
        mem_bank2[14] = 32'h03700593; // addi x11, x0, 55 | exp: x11=0x00000037
        mem_bank2[15] = 32'h00300613; // addi x12, x0, 3 | exp: x12=0x00000003
        mem_bank2[16] = 32'h00B606B3; // add x13, x12, x11 | exp: x13=0x0000003A
        mem_bank2[17] = 32'h00D02423; // sw x13, 8(x0) | exp: M[0x08]=0x0000003A
        mem_bank2[18] = 32'h00802703; // lw x14, 8(x0) | exp: x14=0x0000003A
        mem_bank2[19] = 32'h001707B3; // add x15, x14, x1 | exp: x15=0x00000041
        mem_bank2[20] = 32'h00078A13; // addi x20, x15, 0 | exp: x20=0x00000041
        mem_bank2[21] = 32'h00050A93; // addi x21, x10, 0 | exp: x21=0x00000028
        mem_bank2[22] = 32'h00030B13; // addi x22, x6, 0 | exp: x22=0x0000000E
        mem_bank2[23] = 32'h0000006F; // jal x0, 0 | exp: PC holds (self-loop)

        mem_bank3[0] = 32'h00A00093; // addi x1, x0, 10 | exp: x1=0x0000000A
        mem_bank3[1] = 32'h00000113; // addi x2, x0, 0 | exp: x2=0x00000000
        mem_bank3[2] = 32'h00100193; // addi x3, x0, 1 | exp: x3=0x00000001
        mem_bank3[3] = 32'h00000213; // addi x4, x0, 0 | exp: x4=0x00000000
        mem_bank3[4] = 32'h00120C63; // beq x4, x1, +24 | exp: taken when x4 reaches 0x0000000A
        mem_bank3[5] = 32'h003102B3; // add x5, x2, x3 | exp: final x5=0x00000059
        mem_bank3[6] = 32'h00018113; // addi x2, x3, 0 | exp: final x2=0x00000037
        mem_bank3[7] = 32'h00028193; // addi x3, x5, 0 | exp: final x3=0x00000059
        mem_bank3[8] = 32'h00120213; // addi x4, x4, 1 | exp: final x4=0x0000000A
        mem_bank3[9] = 32'hFEDFF06F; // jal x0, -20 | exp: loop back until x4==x1
        mem_bank3[10] = 32'h00202023; // sw x2, 0(x0) | exp: M[0x00]=0x00000037
        mem_bank3[11] = 32'h00010513; // addi x10, x2, 0 | exp: x10=0x00000037
        mem_bank3[12] = 32'h00018593; // addi x11, x3, 0 | exp: x11=0x00000059
        mem_bank3[13] = 32'h00020613; // addi x12, x4, 0 | exp: x12=0x0000000A
        mem_bank3[14] = 32'h00008693; // addi x13, x1, 0 | exp: x13=0x0000000A
        mem_bank3[15] = 32'h0000006F; // jal x0, 0 | exp: PC holds (self-loop)
    end

    always @(*) begin
        case (bank_sel)
            2'b00: sim_bank_data = mem[sim_addr_idx];
            2'b01: sim_bank_data = mem_bank1[sim_addr_idx];
            2'b10: sim_bank_data = mem_bank2[sim_addr_idx];
            2'b11: sim_bank_data = mem_bank3[sim_addr_idx];
            default: sim_bank_data = mem[sim_addr_idx];
        endcase
    end
    // cadence translate_on

    always @(*) begin
        if (request) begin
            data_out = NOP;
            if (addr_out_of_range) begin
                data_out = NOP;
            end
            else begin
                data_out = bank_data;
            end
            // cadence translate_off
            data_out = sim_bank_data;
            // cadence translate_on
        end
        else begin
            data_out = 32'b0;
        end
    end

endmodule
