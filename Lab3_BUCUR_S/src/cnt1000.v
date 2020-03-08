// ECE5440
// Author: Stefan Bucur 3153
// Module: cnt1000
// Description: counter for the secTimer module; receives a pulse every 1ms


module cnt1000(rst, cnt_up, pulse_sec);
    input rst, cnt_up;
    output pulse_sec;
    reg pulse_sec;

    reg [9:0] cnt;

    always @ (posedge cnt_up) begin
        if(rst == 1'b0)
        begin
            cnt <= 0;
            pulse_sec <= 0;
        end
        else begin
            if(cnt >= 1000)
            begin
                cnt <= 0;
                pulse_sec <= 1;
            end
            else begin
                pulse_sec <= 0;
                cnt <= cnt + 10'b1;
            end
        end
    end
endmodule
