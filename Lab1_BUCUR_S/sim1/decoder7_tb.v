// ECE5440
// Author: Stefan Bucur 3153
// Module: decoder7_tb
// Description: Testbench for decoder7.v; permuting through possible values and verifying functionality

`timescale 10ns/100ps

module decoder7_tb();

	reg [3:0] num;
	wire [6:0] display;

	decoder7 seg_1(num, display);

	initial
	begin
		num = 4'h0;
		#10;
		num = 4'h1;
		#10;
		num = 4'h2;
		#10;
		num = 4'h3;
		#10;
		num = 4'h4;
		#10;
		num = 4'h5;
		#10;
		num = 4'h6;
		#10;
		num = 4'h7;
		#10;
		num = 4'h8;
		#10;
		num = 4'h9;
		#10;
		num = 4'hA;
		#10;
		num = 4'hB;
		#10;
		num = 4'hC;
		#10;
		num = 4'hD;
		#10;
		num = 4'hE;
		#10;
		num = 4'hF;
		#10;
	end

endmodule
