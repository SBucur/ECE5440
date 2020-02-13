// ECE5440
// Author: Stefan Bucur 3153
// Lab2_BUCUR_S.v
// Description: Top-level module to be flashed onto an FPGA.
// Key: 3153

module Lab2_BUCUR_S(
    //inputs
    CLK, RST, player1_num, player2_num, load_p1, load_p2, access_num, access_in,
    //outputs
    player1_dec, player2_dec, result_dec, pass_r, pass_g
    );

    input [3:0] player1_num, player2_num, access_num;
    input load_p1, load_p2, access_in, RST;
    output [6:0] player1_dec, player2_dec, result_dec;
    output pass_r, pass_g;
    reg [6:0] player1_dec, player2_dec, result_dec;
    reg pass_r, pass_g;

    wire [3:0] loadreg_out_w, adder_out_w;
    wire p1_w, p2_w, access_w;
    wire [2:0] access_state;

    //TODO: wire this mess
    adder add_sum(p1_w, p2_w, adder_out_w);
    decoder7 p1_dec(p1_w, player1_num);
    decoder7 p2_dec(p2_w, player2_dec);
    decoder7 sum_dec(adder_out_w, result_dec);
    loadreg p1_num(CLK, RST, player1_num, load_p1);
    loadreg p2_num(CLK, RST, player2_num, load_p2);
    button_press p1_bpress(CLK, RST, load_p1, p1_w, );
    button_press p2_bpress(CLK, RST, load_p2, p2_w);
    button_press access_bpress(CLK, RST, access_in, access_w);
    access acc_ctl(CLK, RST, );

endmodule