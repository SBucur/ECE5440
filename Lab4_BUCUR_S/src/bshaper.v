// ECE5440
// Author: Stefan Bucur
// bshaper.v
// Decription: Changes the functionality of input buttons on the FPGA.
//      Changes between Login mode and Game mode
//      Two-Procedure FSM

// Button input is pulled up (active low)

module bshaper(
    CLK, RST,
    b_in, b_out
    );

    input b_in, CLK, RST;
    output b_out;
    reg b_out;

    //FSM
    reg [1:0] currentstate, nextstate;
    parameter Init = 2'b00, Edge = 2'b01, Wait = 2'b10;

    //Update state
    always @ (posedge CLK) begin
        if(RST == 1'b0)
        begin
            currentstate <= Init;
        end
        else begin
            currentstate <= nextstate;
        end
    end

    always @ (currentstate, b_in) begin
        case (currentstate)
            Init: begin
                b_out <= 1'b0;
                if(b_in == 1'b1)
                begin
                    nextstate <= Init;
                end
                else begin
                    nextstate <= Edge;
                end
            end
            Edge: begin
                b_out <= 1'b1;
                nextstate <= Wait;
            end
            Wait: begin
                b_out <= 1'b0;
                if(b_in == 1'b1)
                begin
                    nextstate <= Init;
                end
                else begin
                    nextstate <= Wait;
                end
            end
            default: begin
                nextstate <= Init;
            end
        endcase
    end
endmodule
