// Massin Ihs
// mihs@g.hmc.edu
// 9/6/2025
// Module that configures the LED 
// based on the sum of two DIP switches

module sum( input logic [7:0] s, 
            output logic [4:0] led);
            
    assign led = s[3:0] + s[7:4];

endmodule