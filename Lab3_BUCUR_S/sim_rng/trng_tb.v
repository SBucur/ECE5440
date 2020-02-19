// ECE5440
// Author: Stefan Bucur 3153
// Module: trng_tb
// Description: Testbench for the true random number generator.

`timescale 1ns/100ps

module trng_tb();

    reg CLK, RST;
    reg button_in;
    wire [3:0] num;

    trng rand_num(CLK, RST, button_in, num);

    always begin
        #10 CLK = 0;
        #10 CLK = 1;
    end

    initial begin
        button_in = 1;
        RST = 1;
        @(posedge CLK);
        @(posedge CLK);
        #5 RST = 0;
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        #5 RST = 1;
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        #5 button_in = 0;
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        #5 button_in = 1;
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
    end
endmodule
