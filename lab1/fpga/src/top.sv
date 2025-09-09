// Massin Ihs
// mihs@g.hmc.edu
// 8/30/2025
// Top-Level module that calls the led_display module and the segment_display module

module top( input logic reset, input logic [3:0] s,
	        output logic [2:0] led, output logic [6:0] seg
			);
			
	led_display display(reset, s, led); // performs led configuration
	segment_display segment(s,seg); // performs 7-segment configuration

endmodule

