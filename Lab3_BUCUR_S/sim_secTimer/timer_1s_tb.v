// ECE5440
// Author: Stefan Bucur
// Module: timer_1s_tb
// Description: testbench for the 1-secoond timer
//      count reset values are internally modified to simplify testing
`timescale 1ms/100ps

module timer_1s_tb();
    reg clk, rst;
    wire pulse;

    secTimer timer_test (clk, rst, pulse);

    always begin
        clk <= 0;
        #10
        clk <= 1;
        #10
    end

    initial begin
        // TODO
    end

endmodule
