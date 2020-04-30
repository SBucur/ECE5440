`timescale 1ns/100ps
// ECE5440
// Author: Stefan Bucur
// access_tb.v
// Decription: Testbench for access.v. Testing cases:
//  1. Wrong password -> Load signals blocked
//  2. Correct Password -> Load signals pass through
//      2.1. 

module access_tb ();

    reg CLK, RST;
    reg [3:0] pword;
    reg loadreg_1_in, loadreg_R_in, pword_enter;
    reg timeout;
    wire enable, reconf;
    wire loadreg_1_out, loadreg_R_out;
    wire pass_red, pass_green;
    wire [3:0] currentstate, rom_q;
    wire [1:0] addr;

    wire pass_OK;

    access testmod(
        CLK, RST,
        loadreg_1_in, loadreg_R_in,
        pword, pword_enter,
        timeout,
        rom_q,
        enable, reconf,
        loadreg_1_out, loadreg_R_out,
        pass_red, pass_green, currentstate,
        addr,
        pass_OK
    );

    ROM_BUCUR_S ROM_DUT(addr, CLK, rom_q);

    // clock cycle
    always begin
        #10 CLK = 0;
        #10 CLK = 1;
    end

    initial begin
            RST = 1;
            loadreg_1_in = 1;
            loadreg_R_in = 0;
            pword_enter = 0;
            timeout = 0;
        // Let FSM assume 1st state and show load_px is blocked (output loadx_out 0)
        repeat(4) @(posedge CLK);

        // Test 1: Incorrect password -> 3453
            pword = 3;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(10) @(posedge CLK);

            pword = 4;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(10) @(posedge CLK);   //pass_OK should flag 0 here

            pword = 5;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(10) @(posedge CLK);

            pword = 3;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(10) @(posedge CLK);
        
        // Test 2: Correct password -> 3153
            pword = 3;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(10) @(posedge CLK);

            pword = 1;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(10) @(posedge CLK);

            pword = 5;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(10) @(posedge CLK);

            pword = 3;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(10) @(posedge CLK);

        // Test 3: reset, log in and attempt to start game
            RST = 0;
        repeat(4) @(posedge CLK);
            RST = 1;
        @(posedge CLK);

            pword = 3;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(8) @(posedge CLK);

            pword = 1;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(8) @(posedge CLK);

            pword = 5;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(8) @(posedge CLK);

            pword = 3;
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(8) @(posedge CLK);

        // game loop
            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(8) @(posedge CLK);

            pword_enter = 1;
        @(posedge CLK);
            pword_enter = 0;
        repeat(8) @(posedge CLK);
            timeout = 1;
        @(posedge CLK);
        @(posedge CLK);
            timeout = 0;
        @(posedge CLK);
        @(posedge CLK);
        // reset
            RST = 0;
        repeat(4) @(posedge CLK);
            RST = 1;
    end
endmodule
