module lab1_mi(  input logic reset, input logic [3:0] s,
	            output logic [2:0] led, output logic [6:0] seg
			);
			
	logic int_osc;	
	logic [24:0] counter;
     // Internal high-speed oscillator
	   HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	assign led[0] = s[0] ^ s[1];
	assign led[1] = s[2] & s[3];
	
	// Counter
   always_ff @(posedge int_osc) begin
     if(reset == 0)  begin 
		 counter <= 0;
		 //led <= 24'b0;
	 end 
	 else if(counter == 24'd5000000)  led[2] <= ~led[2];
     else            counter <= counter + 1;
   end
  

	segment display_segment(s,seg);

endmodule

