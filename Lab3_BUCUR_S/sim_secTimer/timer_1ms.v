// ECE5440
// Author: Stefan Bucur
// Module: timer_1ms
// Description: Sends a short pulse every 1millisecond.
//      timer assumed to be connected to a 50MHz oscillator

module timer_1ms(clk, rst, pulse_1ms);
    input clk, rst;
    output pulse_1ms;
    reg pulse_1ms;

    reg [31:0] cnt;

    always @ (posedge clk) begin
        if(rst == 0)
        begin
            pulse_1ms <= 0;
            cnt <= 0;
        end
        else begin
            if(cnt >= 50000)
            begin
                cnt <= 0;
                pulse_1ms <= 1;
            end
            else begin
                cnt <= cnt + 1;
                pulse_1ms <= 0;
            end
        end
    end 
endmodule
