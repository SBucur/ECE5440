// ECE5440
// Author: Stefan Bucur 3153
// Lab2_BUCUR_S.v
// Description: Top-level module to be flashed onto an FPGA.
// Key: 3153

module Lab2_BUCUR_S(
    // inputs
    CLOCK, RESET,
    p1_data, p2_data, acc_data,
    p1_sel, p2_sel, acc_sel,
    // outputs
    p1_digit, p2_digit, sum_digit,
    sum_status, pass_r, pass_g
    );

    input CLOCK, RESET;
    input [3:0] p1_data, p2_data, acc_data;
    input p1_sel, p2_sel, acc_sel;

    output [6:0] p1_digit, p2_digit, sum_digit;
    output [1:0] sum_status;
    output pass_r, pass_g;
    wire [2:0] acc_state;

    wire p1_bpress, p2_bpress, acc_bpress;
    wire p1_acc, p2_acc;
    wire [3:0] p1_w, p2_w, add_w, bot_w;

    decoder7 p1_dec(p1_w, p1_digit);
    decoder7 p2_dec(p2_w, p2_digit);
    decoder7 sum_dec(add_w, sum_digit);
    adder player_sum(p1_w, p2_w, add_w);
    check sum_result(add_w, sum_status);
    trng pbot(CLOCK, RESET, p1_sel, bot_w);
    loadreg p1_num(CLOCK, RESET, bot_w, p1_sel, p1_w);
    loadreg p2_num(CLOCK, RESET, p2_data, p2_acc, p2_w);
    access acc_ctl(CLOCK, RESET,
                   p1_bpress, p2_bpress,
                   acc_data, acc_bpress,
                   p1_acc, p2_acc,
                   pass_r, pass_g, acc_state
    );
    bshaper p1_button(CLOCK, RESET, p1_sel, p1_bpress);
    bshaper p2_button(CLOCK, RESET, p2_sel, p2_bpress);
    bshaper acc_button(CLOCK, RESET, acc_sel, acc_bpress);
endmodule
