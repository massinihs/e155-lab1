// Massin Ihs
 // mihs@g.hmc.edu
 // 9/8/2025
 // Testbench to test the functionality of the sum module
 


`timescale 1ns/1ns
`default_nettype none
`define N_TV 8

module sum_tb;

    logic [7:0] s;
    logic [4:0] led;

  
    sum dut (s,led);

    // Run all test cases
    initial begin

        for (int i = 0; i < 256; i++) begin
            s = i;
            //#1; 

            static logic [4:0] expected = s[3:0] + s[7:4];
        end

        $finish;
    end

endmodule