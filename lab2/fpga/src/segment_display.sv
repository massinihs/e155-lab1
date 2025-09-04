// Massin Ihs
// mihs@g.hmc.edu
// 9/3/2025
// Module to operate the configuration of the segments on the 7 segment led dislay 
// based on the inputs given by s which act as our DIP switches on the soldered board


module segment_display(input logic [3:0] s, output logic [6:0] seg);
	
	
	always_comb begin
		casez(s)
			4'b0000: seg = 7'b1111110;
			4'b0001: seg = 7'b0110000;
			4'b0010: seg = 7'b1101101;
			4'b0011: seg = 7'b1111001;
			4'b0100: seg = 7'b0110011;
			4'b0101: seg = 7'b1011011;
			4'b0110: seg = 7'b1011111;
			4'b0111: seg = 7'b1110010;
			4'b1000: seg = 7'b1111111;
			4'b1001: seg = 7'b1111011;
			4'b1010: seg = 7'b1110111;
			4'b1011: seg = 7'b0011111;
			4'b1100: seg = 7'b0001101;
			4'b1101: seg = 7'b0111101;
			4'b1110: seg = 7'b1001111;
			4'b1111: seg = 7'b1000111;
			default: seg = 7'b0;
		endcase
	end
endmodule