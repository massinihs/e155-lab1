module top(input logic reset, input logic [7:0] s, 
            output logic [13:0] seg, output logic [4:0] led);

	logic int_osc;	
	logic [24:0] counter;

     // Internal high-speed oscillator
	   HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	


	// Counter
   always_ff @(posedge int_osc) begin
     if(reset == 0)  begin 
		 counter <= 0;
		 //led <= 24'b0;
	 end ;
     else            counter <= counter + 1;


   end 





assign led = s[3:0] + s[4:7];







endmodule