// ECE5440
// Author: Stefan Bucur
// access_tb.v
// Decription: Testbench for access.v. Testing cases:
//  1. Wrong password -> Load signals blocked
//  2. Correct Password -> Load signals pass through
//  3. Logout+Re-enter -> Re-blocks signals until correct sequence re-entered
`timescale 1ns/100ps

module Lab2_BUCUR_S_tb();
    reg CLOCK, RESET;
    reg [3:0] p1_data, p2_data, acc_data;
    reg p1_sel, p2_sel, acc_sel;

    wire [6:0] p1_digit, p2_digit, sum_digit;
    wire [1:0] sum_status;
    wire pass_r, pass_g;
    wire [2:0] acc_state;

    Lab2_BUCUR_S fpga_tb(
        // inputs
        CLOCK, RESET,
        p1_data, p2_data, acc_data,
        p1_sel, p2_sel, acc_sel,
        // outputs
        p1_digit, p2_digit, sum_digit,
        sum_status, pass_r, pass_g
    );    

    // clock cycle
    always begin
        #10 CLOCK = 0;
        #10 CLOCK = 1;
    end

    initial begin
            RESET = 1;
            p1_sel = 1;
            p2_sel = 1;
            acc_sel = 0;
        // Let FSM assume 1st state and show load_px is blocked (output loadx_out 0)
        @(posedge CLOCK);
        @(posedge CLOCK);
        // Test 1: Incorrect password -> 3453
        #5  acc_data = 3;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 4;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 5;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 3;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5 acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        // Test 2: Correct password -> 3153
        #5  acc_data = 3;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 1;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 5;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 3;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        // Test 3: Logout and re-enter correct sequence
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 3;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 1;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 5;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        #5  acc_data = 3;
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  acc_sel = 1;
        @(posedge CLOCK);
        #5  acc_sel = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);

        // reset
        #5  RESET = 0;
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        @(posedge CLOCK);
        #5  RESET = 1;
    end
endmodule
