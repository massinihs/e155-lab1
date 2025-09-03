`timescale 1ns/1ns
`default_nettype none
`define N_TV 8


module testbench(); 
		logic clk, reset;
		logic [3:0] s;
		logic [1:0] led, ledexpected;
		logic [6:0] seg;
		logic [31:0] vectornum, errors;
		logic [6:0] testvectors[10000:0];
		
lab1_mi dut(reset, s, led, seg); 

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