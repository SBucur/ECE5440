// ECE5440
// Author: Stefan Bucur 3153
// Name: ROM_ctrl.v
// Description: ROM controller module for a 4-bit, 4 word ROM module

module ROM_ctrl(RST, CLK, inc, data);

    input RST, CLK, inc;
    output[3:0] data;

    reg[1:0] addr;

    ROM_BUCUR_S ROM_inst(addr, CLK, data);

    always @ (posedge CLK) begin
        if(RST == 0)
        begin
            addr <= 0;
        end
        else if(inc == 1)
        begin
            addr <= addr + 1;
        end
    end

endmodule