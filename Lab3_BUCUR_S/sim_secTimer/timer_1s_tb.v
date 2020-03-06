// ECE5440
// Author: Stefan Bucur 3153
// Module: timer_1s_tb
// Description: testbench for the 1-secoond timer
//      count reset values are internally modified to simplify testing
`timescale 1ns/100ps

module timer_1s_tb();
    reg clk, rst, en;
    wire pulse;

    secTimer timer_test (clk, rst, en, pulse);

    always begin
        clk <= 0;
        #10;
        clk <= 1;
        #10;
    end

    initial begin
        rst = 0;
        en = 0;
        @(posedge clk);
        @(posedge clk);
        rst = 1;
        en = 1;
    end

endmodule
