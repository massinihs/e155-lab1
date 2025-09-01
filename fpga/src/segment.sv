module segment(input logic [3:0] s, output logic [6:0] seg);
	
		logic int_osc;	
	
// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	always_comb @(posedge int_osc) begin
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