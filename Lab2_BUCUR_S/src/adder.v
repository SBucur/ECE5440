// ECE5440
// Author: Stefan Bucur 3153
// Module: adder
// Description: A two-number 4-bit addition module.

module adder (in1, in2, sum);

	input [3:0] in1, in2;
	output [3:0] sum;
	reg [3:0] sum;

	always @ (in1, in2)
		begin
			sum = in1 + in2;
		end
endmodule
