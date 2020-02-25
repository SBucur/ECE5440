// ECE5440
// Author: Stefan Bucur 3153
// Module: cnt4
// Description: 4-bit counter updating on each clock cycle.

module cnt4 (
    //inputs
    CLK, RST, sig_in,
    //outputs
    count
    );

    input CLK, RST;
    input sig_in;
    output [3:0] count;
    reg [3:0] count;

    always @ (posedge CLK) begin
        if(RST == 1'b0)
        begin
            count <= 4'b0000;
        end
        else begin
            if(sig_in == 1'b1)
            begin
                count <= count + 1;
            end
        end
    end
endmodule
