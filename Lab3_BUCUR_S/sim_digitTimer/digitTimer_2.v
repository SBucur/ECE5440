// ECE5440
// Author: Stefan Bucur 3153
// Module: digitTimer_2
// Description: two-digit timer for use in an FPGA game.
/*  Visual showing how the timers chain together.
    Larger-value digit from the left, lower from right.
                     _____                  _____
      borrow_up <---|     |<-borrow_mid----|     |<--- borrow_dn
                    | ten |                | one |
    noborrow_up --->|_____|--noborrow_mid->|_____|---> noborrow_dn
*/
module digitTimer_2(
    reconf, count_default1, count_default2,
    borrow_up, borrow_dn,
    noborrow_up, done,
    count_tens, count_ones
    );

    input reconf, borrow_dn, noborrow_up;
    input [3:0] count_default1, count_default2;
    //connect the two digitTimers together
    wire borrow_mid, noborrow_mid;
    wire noborrow_dn;
    output borrow_up;
    output done;
    output [3:0] count_tens, count_ones;
    reg done;

    digitTimer tens(
        reconf, count_default1,
        borrow_up, borrow_mid,
        noborrow_up, noborrow_mid,
        count_tens
    );
    digitTimer ones(
        reconf, count_default2,
        borrow_mid, borrow_dn,
        noborrow_mid, noborrow_dn,
        count_ones
    );

    always @ (count_tens, count_ones, reconf) begin
        if(count_tens == 4'b0000 && count_ones == 4'b0000 && reconf == 1'b0)
        begin
            done <= 1'b1;
        end
        else begin
            done <= 1'b0;
        end
    end
endmodule