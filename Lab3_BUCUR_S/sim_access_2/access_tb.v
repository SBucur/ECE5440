`timescale 1ns/100ps
// ECE5440
// Author: Stefan Bucur
// access_tb.v
// Decription: Testbench for access.v. Testing cases:
//  1. Wrong password -> Load signals blocked
//  2. Correct Password -> Load signals pass through
//  3. Logout+Re-enter -> Re-blocks signals until correct sequence re-entered

module access_tb ();

    reg clk, rst;
    reg [3:0] passnum;
    reg load_p1, load_R, p_enter;
    reg timeout;
    wire enable, reconf;
    wire load1_out, loadR_out;
    wire passr, passg;
    wire [2:0] state_acc;

    access testmod(
        clk, rst,
        load_p1, load_R,
        passnum, p_enter,
        timeout,
        enable, reconf,
        load1_out, loadR_out,
        passr, passg, state_acc
    );

    // clock cycle
    always begin
        #10 clk = 0;
        #10 clk = 1;
    end

    initial begin
            rst = 1;
            load_p1 = 1;
            load_R = 0;
            p_enter = 0;
            timeout = 0;
        // Let FSM assume 1st state and show load_px is blocked (output loadx_out 0)
        @(posedge clk);
        @(posedge clk);
        // Test 1: Incorrect password -> 3453
            passnum = 3;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 4;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 5;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 3;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Test 2: Correct password -> 3153
            passnum = 3;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 1;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 5;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 3;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Test 3: reset, log in and attempt to start game
            rst = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
            rst = 1;

        passnum = 3;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 1;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 5;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            passnum = 3;
            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);

            p_enter = 1;
        @(posedge clk);
            p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
            timeout = 1;
        @(posedge clk);
        @(posedge clk);
            timeout = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        // reset
            rst = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
            rst = 1;
    end
endmodule
