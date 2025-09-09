module top(input logic reset, input logic [7:0] s, 
            output logic [13:0] seg, output logic [4:0] led, output logic [1:0] enable);

    switcher switch1(reset, s, seg, enable);
    sum adder(s, led);

endmodule
