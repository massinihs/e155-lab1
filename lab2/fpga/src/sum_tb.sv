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
            #1; 

            logic [4:0] expected = s[3:0] + s[7:4];
            string passfail = (led === expected) ? "PASS" : "FAIL";

            $display("%0t\t %08b\t %0d + %0d = %0d\t %s",
                $time, s, s[7:4], s[3:0], led, passfail);

            if (passfail == "FAIL") begin
                $display("ERROR at input %08b: Expected %0d, got %0d", s, expected, led);
            end
        end

        $finish;
    end

endmodule