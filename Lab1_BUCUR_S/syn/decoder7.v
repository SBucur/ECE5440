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
//	 -3- .(DP, ignore maybe?)

module decoder7 (hex, seg7);
	input [3:0] hex;
	output [6:0] seg7;
	reg [6:0] seg7;
	always @ (hex, seg7)
	begin
		//decoder logic to convert hex to seg7
		//0=ON, 1=OFF
		case(hex)
			4'b0000: begin seg7 = 7'b0000001; end //0
			4'b0001: begin seg7 = 7'b1001111; end //1
			4'b0010: begin seg7 = 7'b0010011; end //2
			4'b0011: begin seg7 = 7'b0000110; end //3
			4'b0100: begin seg7 = 7'b1001100; end //4
			4'b0101: begin seg7 = 7'b0100100; end //5
			4'b0110: begin seg7 = 7'b0100000; end //6
			4'b0111: begin seg7 = 7'b0001111; end //7
			4'b1000: begin seg7 = 7'b0000000; end //8
			4'b1001: begin seg7 = 7'b0000100; end //9
			4'b1010: begin seg7 = 7'b0001000; end //A
			4'b1011: begin seg7 = 7'b1100000; end //B
			4'b1100: begin seg7 = 7'b0110001; end //C
			4'b1101: begin seg7 = 7'b1000010; end //D
			4'b1110: begin seg7 = 7'b0110000; end //E
			4'b1111: begin seg7 = 7'b0111000; end //F
		endcase
	end	
endmodule