// ECE5440
// Author: Stefan Bucur 3153
// Module: Lab1_SBUCUR_S
// Description: Top-level module for Lab 1.

module Lab1_BUCUR_S(
        //inputs
        player1, player2,
        //outputs
        num1, num2, segsum, led);

        input [3:0] player1, player2;
        output [6:0] num1, num2, segsum;
        output [1:0] led;
        wire [3:0] sum;
        wire [1:0] led;

        adder playersum(player1, player2, sum);

        //run player inputs and sum to seven-segment displays
        decoder7 dec1(player1, num1);
        decoder7 dec2(player2, num2);
        decoder7 decsum(sum, segsum);
        check checkmatch(sum, led);
endmodule
