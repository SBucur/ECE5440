// ECE5440
// Author: Stefan Bucur 3153
// access.v
// Description: Controls access to the game's I/O through a login system.
// Key: 3153

// Moore Two-Procedure FSM

module access (
    //inputs
    RST, CLK, loadreg_1_in, loadreg_2_in, pword, pword_enter,
    //outputs
    loadreg_1_out, loadreg_2_out, pass_red, pass_green    //, current_digit //current_digit optional
    );

    input RST, CLK;
    input loadreg_1_in, loadreg_2_in;   // input accept buttons for the two load registers
    input [3:0] pword;				// user inputs 4-bit password digit  
    input pword_enter;

    output loadreg_1_out, loadreg_2_out;
    output pass_red, pass_green;
        
    reg loadreg_1_out, loadreg_2_out;
	reg [4:0] current_digit;		//optional: output previous digit entered
    reg pass_red, pass_green;

    //FSM regs & parameters
    reg [2:0] currentstate, nextstate;
    reg pass_OK;

    parameter Digit_1 = 3'b001, Digit_2 = 3'b010, Digit_3 = 3'b011, Digit_4 = 3'b100, OK = 3'b111;

    //FSM
	always @ (posedge CLK) begin
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
					end
					else begin
						if(pword != 4'b0011) //3
						begin
							pass_OK <= 1'b0;
						end
						nextstate <= Digit_2;
					end
				end
				Digit_2: begin
					if(pword_enter == 1'b0)
					begin
						pass_red <= 1'b1;
						pass_green <= 1'b0;
						loadreg_1_out <= 1'b0;
						loadreg_2_out <= 1'b0;
					end
					else begin
						if(pword != 4'b0001) //1
						begin
							pass_OK <= 1'b0;
						end
						nextstate <= Digit_3;
					end
				end
				Digit_3: begin
					if(pword_enter == 1'b0)
					begin
						pass_red <= 1'b1;
						pass_green <= 1'b0;
						loadreg_1_out <= 1'b0;
						loadreg_2_out <= 1'b0;
					end
					else begin
						if(pword != 4'b0101) //5
						begin
							pass_OK <= 1'b0;
						end
						nextstate <= Digit_4;
					end
				end
				Digit_4: begin
					if(pword_enter == 1'b0)
					begin
						pass_red <= 1'b1;
						pass_green <= 1'b0;
						loadreg_1_out <= 1'b0;
						loadreg_2_out <= 1'b0;
					end
					else begin
						if(pword != 4'b0011) //3
						begin
							pass_OK <= 1'b0;
						end
						else begin
							//Allow access if all 4 numbers match
							if(pass_OK == 1'b1)
							begin
								nextstate <= OK;
								pass_OK <= 1'b1;
							end
							else begin
								nextstate <= Digit_1;
							end
						end
					end
				end
				OK: begin
					pass_red <= 1'b0;
					pass_green <= 1'b1;
					loadreg_1_out <= loadreg_1_in;
					loadreg_2_out <= loadreg_2_in;
					nextstate <= OK;
				end
				default: begin nextstate <= Digit_1; end
			endcase
		end
		currentstate <= nextstate;
	end
endmodule
