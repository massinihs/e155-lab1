module testbench(); 
		logic clk, 
		logic[3:0] s, 
		logic [2:0] led, ledexpected,
		logic [5:0] seg, segexpected,
		logic [31:0] vectornum, errors;
		logic [7:0] testvectors[10000:0];
		
lab1_xx dut(clk, s, led, seg); 

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
	 #1; {s, ledexpected, segexpected} = testvectors[vectornum]; 
	 end 

always @(negedge clk) 
	 if (~reset) begin 
		 if ({led,seg} !== {ledexpected, segexpected}) begin // check result 
			$display("Error: inputs = %b", {s});
			$display(" outputs = %b %b %b %b (%b %b expected)", 
			 led, seg, ledexpected, segexpected); 
		 errors = errors + 1; 
		 end 

		 vectornum = vectornum + 1;
		 if (testvectors[vectornum] === 8'bx) begin 
		 $display("%d tests completed with %d errors", vectornum, errors); 
		 $stop; 
		 end 
	 end 
endmodule 