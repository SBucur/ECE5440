// ECE5440
// Author: Stefan Bucur 3153
// Module: decoder7
// Description: A 4-to-7 bit decoder for seven-segment displays.
//		It displays a 4-bit value as a hex digit.

// Visual mapping of reg seg to a seven-segment display:
//	 -0-
//	|   |
//	5   1
//	|   |
//	 -6-
//	|   |
//	4   2
//	 -3- .(DP, ignored)

module decoder7 (hex, seg7);
	input [3:0] hex;
	output [6:0] seg7;
	reg [6:0] seg7;
	
	always @ (hex, seg7)
	begin
		//decoder logic to convert hex to seg7
		//0=ON, 1=OFF
		case(hex)
			4'b0000: begin seg7 = 7'b1000000; end
			4'b0001: begin seg7 = 7'b1111001; end
			4'b0010: begin seg7 = 7'b0100100; end
			4'b0011: begin seg7 = 7'b0110000; end
			4'b0100: begin seg7 = 7'b0011001; end
			4'b0101: begin seg7 = 7'b0010010; end
			4'b0110: begin seg7 = 7'b0000010; end
			4'b0111: begin seg7 = 7'b1111000; end
			4'b1000: begin seg7 = 7'b0000000; end
			4'b1001: begin seg7 = 7'b0011000; end
			4'b1010: begin seg7 = 7'b0001000; end
			4'b1011: begin seg7 = 7'b0000011; end
			4'b1100: begin seg7 = 7'b1000110; end
			4'b1101: begin seg7 = 7'b0100001; end
			4'b1110: begin seg7 = 7'b0000110; end
			4'b1111: begin seg7 = 7'b0001110; end
		endcase
	end	
endmodule