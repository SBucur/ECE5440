// ECE5440
// Author: Stefan Bucur 3153
// access.v
// Description: Controls access to the game's I/O through a login system.
// Key: 3153

// Moore One-Procedure FSM

module access (
    //inputs
    RST, CLK,
	loadreg_1_in, loadreg_2_in,
	pword, pword_enter,
    //outputs
    loadreg_1_out, loadreg_2_out,
	pass_red, pass_green, currentstate
    );

    input RST, CLK;
    // input accept buttons for the two load registers
    input loadreg_1_in, loadreg_2_in;
    // user inputs 4-bit password digit
    input [3:0] pword;
    input pword_enter;

    // signals to wire out to player loadreg modules
    output loadreg_1_out, loadreg_2_out;
    output pass_red, pass_green;
    // display current state for simulation and debugging pruposes
    // currentstate will not be wired to any modules or I/O
	output [2:0] currentstate;
    
    reg loadreg_1_out, loadreg_2_out;
    reg pass_red, pass_green;

    // FSM regs, parameters and states
    reg [2:0] currentstate, nextstate;
    reg pass_OK;
    parameter Digit_1 = 3'b001, Digit_2 = 3'b010;
	parameter Digit_3 = 3'b011, Digit_4 = 3'b100, OK = 3'b111;

    // FSM
    // Key is hardcoded to each state with comments denoting each digit
    // pass_OK acts as a flag detecting if input sequence matches key (default value 1)
	always @ (posedge CLK) begin
        // If RST triggered, switch case is ignored and FSM is forced to Digit_1
		if (RST == 1'b0) begin
			currentstate <= Digit_1;
			pass_OK <= 1'b1;
			pass_red <= 1'b1;
			pass_green <= 1'b0;
			loadreg_1_out <= 1'b0;
			loadreg_2_out <= 1'b0;
		end
		else begin case (currentstate)
				Digit_1: begin
					pass_OK <= 1'b1;
					if(pword_enter == 1'b0)
					begin
						pass_red <= 1'b1;
						pass_green <= 1'b0;
						loadreg_1_out <= 1'b0;
						loadreg_2_out <= 1'b0;
						currentstate <= Digit_1;
					end
					else begin
						if(pword !== 4'b0011) //3
						begin
							pass_OK <= 1'b0;
						end
						currentstate <= Digit_2;
					end
				end
				Digit_2: begin
					if(pword_enter == 1'b0)
					begin
						pass_red <= 1'b1;
						pass_green <= 1'b0;
						loadreg_1_out <= 1'b0;
						loadreg_2_out <= 1'b0;
						currentstate <= Digit_2;
					end
					else begin
						if(pword !== 4'b0001) //1
						begin
							pass_OK <= 1'b0;
						end
						currentstate <= Digit_3;
					end
				end
				Digit_3: begin
					if(pword_enter == 1'b0)
					begin
						pass_red <= 1'b1;
						pass_green <= 1'b0;
						loadreg_1_out <= 1'b0;
						loadreg_2_out <= 1'b0;
						currentstate <= Digit_3;
					end
					else begin
						if(pword !== 4'b0101) //5
						begin
							pass_OK <= 1'b0;
						end
						currentstate <= Digit_4;
					end
				end
				Digit_4: begin
					if(pword_enter == 1'b0)
					begin
						pass_red <= 1'b1;
						pass_green <= 1'b0;
						loadreg_1_out <= 1'b0;
						loadreg_2_out <= 1'b0;
						currentstate <= Digit_4;
					end
					else begin
						if(pword !== 4'b0011) //3
						begin
							pass_OK <= 1'b0;
						end
						else begin
							// Determines if input sequence is a match
							if(pass_OK == 1'b1)
							begin
								currentstate <= OK;
								pass_OK <= 1'b1;
							end
							else begin
								currentstate <= Digit_1;
							end
						end
					end
				end
				OK: begin
					pass_red <= 1'b0;
					pass_green <= 1'b1;
					loadreg_1_out <= loadreg_1_in;
					loadreg_2_out <= loadreg_2_in;
                    // Bonus assignment: press pword_enter again to logout of the system
                    // Logout in this case means resetting to Digit_1
                    if(pword_enter == 1'b1)
                    begin
                        currentstate <= Digit_1;
                    end
                    else begin
                        currentstate <= OK;
                    end
				end
				default: begin currentstate <= Digit_1; end
			endcase
		end
	end
endmodule
