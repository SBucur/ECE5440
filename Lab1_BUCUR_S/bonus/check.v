// ECE5440
// Author: Stefan Bucur 3153
// Module: check
// Description: bonus for Lab 1 assignment
// use LEDs to indicate if the players successfully input numbers that add to 0xF
// FPGA has individual wires for different colored LEDs, output must have two signals

module check(
    //inputs
    sum,
    //outputs
    status);

    input [3:0] sum;
    // status[0] for green LED, status[1] for red
    output [1:0] status;
    reg [1:0] status;

    always @(sum)
    begin
        if( sum == 4'hf )
        begin
            status = 2'b01;
        end
        else
        begin
            status = 2'b10;
        end
    end
endmodule
