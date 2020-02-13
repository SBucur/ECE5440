`timescale 10ns/100ps
// ECE5440
// Author: Stefan Bucur
// access_tb.v
// Decription: Testbench for access.v. Testing cases:
//  1. Wrong password -> Load signals blocked
//  2. Correct Password -> Load signals pass through

module access_tb ();

    reg clk, rst;
    reg [3:0] passnum;
    reg load_p1, load_p2, p_enter;
    wire load1_out, load2_out;
    wire passr, passg;
    wire [2:0] state_acc;

    access testmod(
        rst, clk,
        load_p1, load_p2,
        passnum, p_enter,
        load1_out, load2_out,
        passr, passg, state_acc
    );

    always begin
        #10 clk = 0;
        #10 clk = 1;
    end

    initial begin
        #5
        rst = 1;
        load_p1 = 1;
        load_p2 = 1;
        p_enter = 0;
        #50 passnum = 3;
            p_enter = 1;
        #10 p_enter = 0;

        #50 passnum = 1;
            p_enter = 1;
        #10 p_enter = 0;

        #50 passnum = 5;
            p_enter = 1;
        #10 p_enter = 0;

        #50 passnum = 3;
            p_enter = 1;
        #10 p_enter = 0;
    end
endmodule
