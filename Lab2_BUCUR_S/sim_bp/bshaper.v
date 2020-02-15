// ECE5440
// Author: Stefan Bucur
// button_shaper.v
// Decription: Changes the functionality of input buttons on the FPGA.
//		Changes between Login mode and Game mode
//		Two-Procedure FSM

// Button input is pulled up (active low)
// FSM is based on Week 4 tutorial

module button_press(
	//inputs
	button_in, CLK, RST,
	//outputs
	button_out
	);

	input button_in, CLK, RST;
	output button_out;
	reg button_out;

	//FSM
	reg [1:0] currentstate;
	parameter Init = 2'b00, Edge = 2'b01, Wait = 2'b10;

	// sequential logic: update state on rising clock edge
	always @(posedge CLK) begin
		if(RST == 0)
		begin
			currentstate <= Init;
		end
		else case (currentstate)
			Init: begin
				if (button_in == 0) begin currentstate <= Edge; end
				if (button_in == 1) begin currentstate <= Init; end
			end
			Edge: begin
				if (button_in == 0) begin currentstate <= Wait; end
				if (button_in == 1) begin currentstate <= Wait; end
			end
			Wait: begin
				if (button_in == 0) begin currentstate <= Wait; end
				if (button_in == 1) begin currentstate <= Init; end
			end
			default: begin currentstate <= Init; end
		endcase
	end

	// combinational logic: update output on state change
	always @ (currentstate) begin
		case (currentstate)
			Init: begin button_out = 1'b0; end
			Edge: begin button_out = 1'b1; end
			Wait: begin button_out = 1'b0; end
			default: begin button_out = 1'b0; end
		endcase
	end
endmodule
