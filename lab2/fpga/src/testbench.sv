 // Massin Ihs
 // mihs@g.hmc.edu
 // 8/30/2025
 // Testbench to test the functionality of the led module. It tests whether the LEDs 
 // are getting configured correctly based on the switches as well as the onboard osscilator


`timescale 1ns/1ns
`default_nettype none
`define N_TV 8


module testbench(); 
		logic clk, reset;
		logic [3:0] s;
		logic [1:0] led, ledexpected;
		logic [31:0] vectornum, errors;
		logic [6:0] testvectors[10000:0];
		
led_display dut(reset, s, led); 

always 
	 begin
	 clk=1; #5; clk=0; #5; 
	 end 

initial 
	 begin
	 $readmemb("testvectors.tv", testvectors); 
	 vectornum = 0; errors = 0; reset = 1; #22; reset = 0; 
	 end 

always @(posedge clk) 
	 begin
		#1; {s, ledexpected[1:0]} = testvectors[vectornum]; 
	 end 

always @(negedge clk) 
	 if (~reset) begin 
		 if ({led[1:0]} !== {ledexpected[1:0]}) begin // check result 
			$display("Error: inputs = %b", {s});
			$display(" outputs =  %b ( %b expected)", led[1:0], ledexpected[1:0]); 
		 errors = errors + 1; 
		 end 

		 vectornum = vectornum + 1;
		 if (testvectors[vectornum] === 6'bx) begin 
		 $display("%d tests completed with %d errors", vectornum, errors); 
		 $stop; 
		 end 
	 end 
 endmodule 