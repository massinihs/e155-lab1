module testbench(); 
		logic clk, 
		logic[3:0] s, 
		logic [5:0] seg, segexpected,
		logic [31:0] vectornum, errors;
		logic [7:0] testvectors[10000:0];
		
segment dut( s, seg); 

always 
	 begin
	 clk=1; #5; clk=0; #5; 
	 end 

initial 
	 begin
	 $readmemb("testvectors_segment.tv", testvectors); 
	 vectornum = 0; errors = 0; reset = 1; #22; reset = 0; 
	 end 

always @(posedge clk) 
	 begin
	 #1; {s, segexpected} = testvectors[vectornum]; 
	 end 

always @(negedge clk) 
	 if (~reset) begin 
		 if ({seg} !== { segexpected}) begin // check result 
			$display("Error: inputs = %b", {s});
			$display(" outputs = %b (%b expected)", 
			 seg, segexpected); 
		 errors = errors + 1; 
		 end 

		 vectornum = vectornum + 1;
		 if (testvectors[vectornum] === 8'bx) begin 
		 $display("%d tests completed with %d errors", vectornum, errors); 
		 $stop; 
		 end 
	 end 
endmodule 