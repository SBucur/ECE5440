`timescale 10ns/100ps

module bshaper_tb ();
	reg CLK, RST, button_in;

	wire button_out;

	bshaper button_tb (button_in, CLK, RST, button_out);

	//define clock cycle
	always begin
		#10 CLK = 0;
		#10 CLK = 1;
	end

	initial begin
			RST = 1;
			button_in = 1;
		// button press = pulse for 1 clock cycle
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		#5 button_in = 0;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		#5 button_in = 1;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		#5 button_in = 0;
		   RST = 0;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		#5 RST = 1;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		#5 button_in = 1;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);		

	end
endmodule
