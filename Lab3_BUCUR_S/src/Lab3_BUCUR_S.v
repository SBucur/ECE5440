// ECE5440
// Author: Stefan Bucur 3153
// Lab3_BUCUR_S.v
// Description: Top-level module to be flashed onto an FPGA.
// Key: 3153

module Lab3_BUCUR_S(
    // inputs
    CLOCK, RESET,
    player_data, acc_data,
    bot_sel, player_sel, acc_sel,
    // outputs
    bot_digit, player_digit, sum_digit,
    sum_status, pass_r, pass_g
    );

    input CLOCK, RESET;
    input [3:0] player_data, acc_data;
    input bot_sel, player_sel, acc_sel;

    output [6:0] bot_digit, player_digit, sum_digit;
    output [1:0] sum_status;
    output pass_r, pass_g;
    wire [2:0] acc_state;

    wire bot_bpress, player_bpress, acc_bpress;
    wire bot_acc, player_acc;
    wire [3:0] bot_w, player_w, add_w, rand_w;

    decoder7 bot_dec(bot_w, bot_digit);
    decoder7 player_dec(player_w, player_digit);
    decoder7 sum_dec(add_w, sum_digit);
    adder player_sum(bot_w, player_w, add_w);
    check sum_result(add_w, sum_status);
    trng pbot(CLOCK, RESET, bot_sel, rand_w);
    loadreg bot_num(CLOCK, RESET, rand_w, bot_sel, bot_w);
    loadreg player_num(CLOCK, RESET, player_data, player_acc, player_w);
    access acc_ctl(CLOCK, RESET,
                   bot_bpress, player_bpress,
                   acc_data, acc_bpress,
                   bot_acc, player_acc,
                   pass_r, pass_g, acc_state
    );
    bshaper player_button(CLOCK, RESET, player_sel, player_bpress);
    bshaper acc_button(CLOCK, RESET, acc_sel, acc_bpress);
endmodule
