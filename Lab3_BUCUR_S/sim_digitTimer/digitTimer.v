// ECE5440
// Author: Stefan Bucur 3153
// Module: digitTimer
// Description: scalable digit timer for the FPGA game.
//  timer talk to adjacent digits to determine next value

/*  Visual showing how the timer chains together.
    Larger digit from the left, lower from right.
                     _____
    borrow_up   <---|     |<--- borrow_dn
                    | d_T |
    noborrow_up --->|_____|---> noborrow_dn

    if counter receives signal to count down via borrow_dn (1),
        if current value is zero,
            if parent digit is not zero (noborrow_up == 0)
                send signal borrow_up
*/

module digitTimer (
    borrow_up, borrow_dn,
    noborrow_up, noborrow_dn
    );

    input borrow_dn, noborrow_up;
    output borrow_up, noborrow_dn;

    reg[3:0] count;

    // count down if receiving a signal from less siginificant digitTimer to count down one
    always @ (posedge CLK) begin
        if (RST == 1'b0)
        begin
            count <= 4'b0000;
            borrow_up <= 1'b1;
            noborrow_dn <= 1'b1;
        end
        else begin
            if (count == 4'b0000)
            begin
                borrow_up <= 1'b1;
                if (noborrow_up == 1'b0)
                begin
                    // back up to 9, signal to slave digit
                    cout <= 4'b1001;
                    noborrow_dn <= 1'b1;
                end
                
            end
            else begin
                count <= count - 4'b0001;
                borrow_up <= 1'b1;
            end
        end
    end

endmodule
