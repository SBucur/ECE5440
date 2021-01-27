// ECE5440
// Author: Stefan Bucur
// access_tb.v
// Decription: Testbench for access.v. Testing cases:
//  1. Wrong password -> Load signals blocked
//  2. Correct Password -> Load signals pass through
//  3. Logout+Re-enter -> Re-blocks signals until correct sequence re-entered
`timescale 1ns/100ps

module access_tb ();
    reg clk, rst;
    reg [3:0] passnum;
    reg load_p1, load_p2, p_enter;
    wire load1_out, load2_out;
    wire passr, passg;
    wire [2:0] state_acc;

    access acc_tb(
        rst, clk,
        load_p1, load_p2,
        passnum, p_enter,
        load1_out, load2_out,
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
            load_p2 = 1;
            p_enter = 0;
        // Let FSM assume 1st state and show load_px is blocked (output loadx_out 0)
        @(posedge clk);
        @(posedge clk);
        // Test 1: Incorrect password -> 3453
        #5  passnum = 3;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 4;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 5;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 3;
        @(posedge clk);
        @(posedge clk);
        #5 p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Test 2: Correct password -> 3153
        #5  passnum = 3;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 1;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 5;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 3;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // Test 3: Logout and re-enter correct sequence
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 3;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 1;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 5;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5  passnum = 3;
        @(posedge clk);
        @(posedge clk);
        #5  p_enter = 1;
        @(posedge clk);
        #5  p_enter = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // reset
        #5  rst = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5  rst = 1;
    end
endmodule
