`timescale 1ns/100ps

module ROM_tb();

    reg[1:0] addr;
    reg CLK;
    wire[3:0] data;

    ROM_BUCUR_S ROM_DUT(addr, CLK, data);

    always begin
        CLK <= 0;
        #5;
        CLK <=1;
        #5;
    end

    initial begin
        addr <= 0;
        #50;
        @(posedge CLK);
        addr <= 1;
        @(posedge CLK);
        addr <= 2;
        @(posedge CLK);
        addr <= 3;
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);
    end

endmodule