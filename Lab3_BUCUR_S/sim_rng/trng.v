// ECE5440
// Author: Stefan Bucur 3153
// Module: trng
// Description: True random 4-bit number generator.

module trng (
    //inputs
    CLK, RST,
    button_trng,
    //outputs
    rand
    );

    input CLK, RST;
    input button_trng;
    wire counter_in_internal;
    output [3:0] rand;

    assign counter_in_internal = ~button_trng;
    cnt4 counter(CLK, RST, counter_in_internal, rand);
    
endmodule
