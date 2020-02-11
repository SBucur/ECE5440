`timescale 10ns/100ps

module loadreg_tb();

	reg clk, rst, sig_load;
	reg [3:0] data;
	wire [3:0] loadreg_out;

	loadreg load_tb(clk, rst, data, sig_load, loadreg_out);

	always begin
		#10 clk = 1;
		#10 clk = 0;
	end

	initial begin
		#5
		rst = 1;
		sig_load = 0;
		data = 4'b0000;
		#20 sig_load = 1;
		#10 sig_load = 0;
		#10 data = 4'b1010;
			sig_load = 1;
		#10 sig_load = 0;
			data = 4'b1111;
	end

endmodule
