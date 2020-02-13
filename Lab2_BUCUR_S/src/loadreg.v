// ECE5440
// Author: Stefan Bucur
// loadreg.v
// Decription: Holds player input value and updates upon receiving button confirmation
//      Clocked circuit
//		One-Procedure FSM

module loadreg(
	// inputs
    CLK, RST, data_in, sig_load,
	// outputs
    data_out
	);

	input CLK, RST, sig_load;
	input [3:0] data_in;
	output [3:0] data_out;
	reg [3:0] data_out;

	// FSM regs and parameters
	reg loadreg_state;
	parameter Store = 1'b0, Load = 1'b1;

	always @ (posedge CLK) begin
		if (RST == 0)
		begin
			loadreg_state <= 2'b00;
			data_out <= 4'b0000;
		end
		else begin case (loadreg_state)
				Store: begin
					if(sig_load == 1'b1)
					begin
						loadreg_state <= Load;
						data_out <= data_in;
					end
				end
				Load: begin
					if(sig_load == 1'b0)
					begin
						loadreg_state <= Store;
					end
					if(sig_load == 1'b1)
					begin
						loadreg_state <= Load;
						data_out <= data_in;
					end
				end
				default: begin loadreg_state <= Store; end
			endcase
		end
	end

endmodule
