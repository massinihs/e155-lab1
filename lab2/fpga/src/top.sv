// Massin Ihs
// mihs@g.hmc.edu
// 8/30/2025
// Top-Level module that calls the switcher and sum module


module top(input logic reset, input logic [7:0] s, 
            output logic [13:0] seg, output logic [4:0] led, output logic [1:0] enable);

    switcher switch1(reset, s, seg, enable);
    sum add1(s, led);

endmodule
