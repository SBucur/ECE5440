// ECE5440
// Author: Stefan Bucur 3153
// Lab2_BUCUR_S.v
// Description: Top-level module to be flashed onto an FPGA.
// Key: 3153

module Lab2_BUCUR_S(
    // inputs
    CLK, RST,
    p1_data, p2_data, acc_data,
    p1_sel, p2_sel, acc_sel,
    // outputs
    p1_digit, p2_digit, sum_digit,
    sum_r, sum_g, pass_r, pass_g,
    );

    input CLK, RST;
    input [3:0] p1_data, p2_data, acc_data;
    input p1_sel, p2_sel, acc_sel;

    output [6:0] p1_digit, p2_digit, sum_digit;
    output sun_r, sum_g, pass_r, pass_g;
    reg [6:0] p1_digit, p2_digit, sum_digit;
    reg sun_r, sum_g, pass_r, pass_g;

    wire p1_bpress, p2_bpress, acc_bpress;
    wire p1_acc, p2_acc;
    wire [2:0] acc_state;
    wire [3:0] p1_w, p2_w, add_w;

    decoder7 p1_dec(p1_w, p1_digit);
    decoder7 p2_dec(p2_w, p2_digit);
    decoder7 sum_dec(add_w, sum_digit);
    adder player_sum(p1_w, p2w, add_w);
    loadreg p1_num(CLK, RST, p1_data, p1_acc, p1_w);
    loadreg p2_num(CLK, RST, p2_data, p2_acc, p2_w);
    access acc_ctl(CLK, RST,
                   p1_bpress, p2_bpress,
                   acc_data, acc_bpress,
                   p1_acc, p2_acc,
                   pass_r, pass_g, acc_state
    );
    bshaper p1_button(CLK, RST, p1_sel, p1_bpress);
    bshaper p2_button(CLK, RST, p2_sel, p2_bpress);
    bshaper acc_button(CLK, RST, acc_sel, acc_bpress);
    

endmodule