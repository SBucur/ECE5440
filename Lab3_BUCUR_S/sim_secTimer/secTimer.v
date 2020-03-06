// ECE5440
// Author: Stefan Bucur
// Module: secTimer
// Description: 1-second timer for the FPGA. Timer is assumed to be connected to a 50MHz oscillator.

module secTimer(clk, rst, pulse_1s);
    input clk, rst;
    output pulse_1s;
    wire pulse_1ms;

    cnt1000 counter (rst, pulse_1ms, pulse_1s);
    timer_1ms timer (clk, rst, pulse_1ms);
endmodule
