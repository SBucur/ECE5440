// ECE5440
// Author: Stefan Bucur 3153
// Module: digitTimer_tb
// Description: testbench for the scalable digit timer.
// testbench will start at a value testing full communication between the internal digitTimers in digitTimer_2

`timescale 1ns/100ps
module digitTimer_tb();

    reg RST, borrow_dn, noborrow_up;
    // 29 'seconds' (ticks of the timer)
    reg [3:0] default_num = 4'b1111; // digitTimer should set 9
    wire borrow_up, noborrow_dn;
    wire [3:0] digit_count;

    digitTimer dT(
        RST, default_num,
        borrow_up, borrow_dn,
        noborrow_up, noborrow_dn,
        digit_count
        );

    always begin
        #10 borrow_dn = 1'b1;
        #2  borrow_dn = 1'b0;
    end

    initial begin
        noborrow_up = 1'b1;
        //load defaults into timer
            RST = 1'b0;
        #10 RST = 1'b1;
        #20 RST = 1'b0;

        // begin counting down
        // (always block takes care of it)
        // reset partway, should reset to 29
        #150 RST = 1'b0;
        #10 RST = 1'b1;
        #20 RST = 1'b0;
    end

endmodule
