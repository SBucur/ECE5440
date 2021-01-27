// ECE5440
// Author: Stefan Bucur
// loadreg_tb.v
// Decription: Testbench for loadreg module
//	Case 1: load 0101 to loadreg
//	Case 2: reset loadreg to 0
`timescale 1ns/100ps

module loadreg_tb();

	reg CLK, RST, sig_load;
	reg [3:0] data;
	wire [3:0] loadreg_out;

	loadreg load_tb(CLK, RST, data, sig_load, loadreg_out);

	always begin
		#10 CLK = 0;
		#10 CLK = 1;
	end

	initial begin
		RST = 1;
		sig_load = 0;
		data = 4'b0101;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		#5 sig_load = 1;
		@(posedge CLK);
		#5 sig_load = 0;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		#5 RST = 0;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		#5 RST = 1;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
	end
endmodule
