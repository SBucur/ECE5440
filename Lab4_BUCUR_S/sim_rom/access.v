// ECE5440
// Author: Stefan Bucur 3153
// access.v
// Description: Controls access to the game's I/O through a login system.
// Key: 3153

// Moore One-Procedure FSM

module access (
    //inputs
    CLK, RST,
	loadreg_1_in, loadreg_R_in,
	pword, pword_enter,
    timeout,
    rom_q,
    //outputs
    enable, reconf,
    loadreg_1_out, loadreg_R_out,
	pass_red, pass_green,
    currentstate,
    addr,
    //DEBUG
    pass_OK
    //END DEBUG
    );

    input RST, CLK, timeout;
    // input accept buttons for the two load registers
    input loadreg_1_in, loadreg_R_in;
    // user inputs 4-bit password digit
    input [3:0] pword;
    input pword_enter;
    

    // signals to wire out to player loadreg modules + digit timer reconf
    output enable, reconf;
    output loadreg_1_out, loadreg_R_out;

    //LED inficator of login pass/fail
    output pass_red, pass_green;
    
    
    // variables for communicating with the ROM module
    input [3:0] rom_q;
    output [1:0] addr;
    reg [1:0] addr;

    reg enable, reconf;
    reg loadreg_1_out, loadreg_R_out;
    reg pass_red, pass_green;

    //////////////////////////////////////////////DEBUG, comment out when not testbenching
    output pass_OK;
    // display current state for simulation and debugging pruposes
    // currentstate will not be wired to any modules or I/O
	output [2:0] currentstate;
    //////////////////////////////////////////////END DEBUG

    // FSM regs, parameters and states
    reg [3:0] currentstate; // enumerated state of the FSM
    reg pass_OK; // flag that tells if the current sequence is incorrect
    reg [3:0] pword_current; // internal variable recording player input
    reg [3:0] pword_rom; // internal variable recording ROM output
    // enumerated state values
    parameter   Init = 4'b0000, Next = 4'b0001, W1 = 4'b0010, W2 = 4'b0011,
                Get = 4'b0100, Equ = 4'b0101, Eval = 4'b0110, Pass = 4'b0111,
                OK = 4'b1000, SET = 4'b1001, PLAY = 4'b1010;

    // FSM
    // Key is retrieved from a ROM module that stores each digit as a 4-bit word
    // pass_OK acts as a flag detecting if input sequence has matched so far (default value 1)
	always @ (posedge CLK) begin
        // If RST triggered, switch case is ignored and FSM is forced to Init
		if (RST == 1'b0) begin
            addr <= 2'b00;
            pass_OK <= 1'b1;
            pass_red <= 1'b1;
            pass_green <= 1'b0;
            loadreg_1_out <= 1'b0;
            loadreg_R_out <= 1'b1;  // loadreg_R must be inverted because a 0 enables the RNG
            enable <= 1'b0;
            reconf <= 1'b0;
            currentstate <= Init;
		end
		else begin case (currentstate)
                Init: begin
                    addr <= 2'b00;
                    pass_OK <= 1'b1;
                    pass_red <= 1'b1;
                    pass_green <= 1'b0;
                    loadreg_1_out <= 1'b0;
                    loadreg_R_out <= 1'b1;
                    enable <= 1'b0;
                    reconf <= 1'b0;
                    currentstate <= Next;
                end
                Next: begin
                    //definition
                    pass_red <= 1'b1;
                    pass_green <= 1'b0;
                    loadreg_1_out <= 1'b0;
                    loadreg_R_out <= 1'b1;
                    enable <= 1'b0;
                    reconf <= 1'b0;
                    //transition
                    if(pword_enter == 1'b0)
                    begin
                        currentstate <= Next;
                    end
                    else begin
                        pword_current <= pword;
                        currentstate <= W1;
                    end
                end

                // wait two cycles for the ROM module to retrieve the data
                W1: begin
                    //definition
                    pass_red <= 1'b1;
                    pass_green <= 1'b0;
                    loadreg_1_out <= 1'b0;
                    loadreg_R_out <= 1'b1;
                    enable <= 1'b0;
                    reconf <= 1'b0;
                    //transition
                    currentstate <= W2;
                end
                W2: begin
                    //definition
                    pass_red <= 1'b1;
                    pass_green <= 1'b0;
                    loadreg_1_out <= 1'b0;
                    loadreg_R_out <= 1'b1;
                    enable <= 1'b0;
                    reconf <= 1'b0;
                    //transition
                    currentstate <= Get;
                end
                // ROM should have fetched the data by now, record the output from the memory module
                Get: begin
                    //definition
                    pass_red <= 1'b1;
                    pass_green <= 1'b0;
                    loadreg_1_out <= 1'b0;
                    loadreg_R_out <= 1'b1;
                    enable <= 1'b0;
                    reconf <= 1'b0;
                    //transition
                    pword_rom <= rom_q;
                    currentstate <= Eval;
                end
                // flag if the player input does not match what ROM returns
                Eval: begin
                    //definition
                    pass_red <= 1'b1;
                    pass_green <= 1'b0;
                    loadreg_1_out <= 1'b0;
                    loadreg_R_out <= 1'b1;
                    enable <= 1'b0;
                    reconf <= 1'b0;
                    //transition
                    if(pword_current != pword_rom) begin
                        pass_OK <= 1'b0;
                    end
                    currentstate <= Pass;
                end
                // if the sequence matched, goto game
                    // if not, reset and restart
                // if the sequence isn't finished, goto next address and loop back
                Pass: begin
                    //definition
                    pass_red <= 1'b1;
                    pass_green <= 1'b0;
                    loadreg_1_out <= 1'b0;
                    loadreg_R_out <= 1'b1;
                    enable <= 1'b0;
                    reconf <= 1'b0;
                    //transition
                    if(addr >= 2'b11) begin
                        if(pass_OK == 1'b1) begin
                            currentstate <= OK;
                        end
                        else begin
                            currentstate <= Init;
                        end
                    end
                    else begin
                        addr <= addr + 2'b01;
                        currentstate <= Next;
                    end
                end

                // game loop
                OK: begin
                    if(pword_enter == 1'b0)
                    begin
                        pass_red <= 1'b0;
                        pass_green <= 1'b1;
                        loadreg_1_out <= 1'b0;         
                        loadreg_R_out <= 1'b1;
                        enable <= 1'b0;
                        reconf <= 1'b0;
                        currentstate <= OK;
                    end
                    else begin
                        currentstate <= SET;
                    end
				end
                SET: begin
                    if(pword_enter == 1'b0)
                    begin
                        pass_red <= 1'b0;
                        pass_green <= 1'b1;
                        loadreg_1_out <= 1'b0;         
                        loadreg_R_out <= 1'b1;
                        enable <= 1'b0;
                        reconf <= 1'b1;
                        currentstate <= SET;
                    end
                    else begin
                        currentstate <= PLAY;
                    end
                end
                PLAY: begin
                    if(timeout == 1'b0)
                    begin
                        pass_red <= 1'b0;
                        pass_green <= 1'b1;
                        loadreg_1_out <= loadreg_1_in;
                        loadreg_R_out <= loadreg_R_in;
                        enable <= 1'b1;
                        reconf <= 1'b0;
                        currentstate <= PLAY;
                    end
                    else begin
                        if(timeout == 1'b1)
                        begin
                            currentstate <= OK;
                        end
                    end
                end
				default: begin currentstate <= Init; end
			endcase
		end
	end
endmodule
