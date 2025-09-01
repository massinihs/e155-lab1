module lab1_mi( input  logic     clk,        input logic [3:0] s, 
	            output logic [2:0] led, output logic [5:0] seg
			);
			
	logic int_osc;	
	
    // Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	assign led[0] = s[0] ^ s[1];
	assign led[1] = s[1] & s[2];
	
	segment display_segment(s,seg);

endmodule


