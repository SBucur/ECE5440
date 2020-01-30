`timescale 10ns/100ps

module check_tb();

    reg [3:0] sum_test;
    wire [1:0] status_test;

    check check_test(sum_test, status_test);

    initial
    begin
        sum_test = 4'hF;
        #1;
        sum_test = 4'hE;
        #1;
        sum_test = 4'hD;
        #1;
        sum_test = 4'h7;
        #1;
    end
endmodule
