// ECE5440
// Author: Stefan Bucur 3153
// Module: secTimer
// Description: 1-second timer for the FPGA. Timer is assumed to be connected to a 50MHz oscillator.

module secTimer(clk, rst, en, pulse_1s);
    input clk, rst, en;
    output pulse_1s;
    wire pulse_1ms;

    cnt1000 counter (rst, pulse_1ms, pulse_1s);
    timer_1ms timer (clk, rst, en, pulse_1ms);
endmodule
