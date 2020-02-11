`timescale 10ns/100ps

module button_press_tb ();
	reg clk, rst, button_in;

	wire button_out;

	button_press player_tb (button_in, clk, rst, button_out);

	//establish clock cycle, repeats
	//clock period = 20 ticks
	always begin
		#10 clk = 1;
		#10 clk = 0;
	end

	initial begin
		#5
		rst = 1;
		button_in = 1;
		//before first rising edge, press button
		#20 button_in = 0;
		#10 button_in = 1;
		// try both buttons pressed
		#30 rst = 0;
			button_in = 0;
		#10 button_in = 1;
	end
endmodule
