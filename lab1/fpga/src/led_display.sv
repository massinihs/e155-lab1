// Massin Ihs
// mihs@g.hmc.edu
// 8/30/2025
// Module to operate the LEDs on the board based on different switch inputs

module led_display(  input logic reset, input logic [3:0] s,
           			 output logic [2:0] led
				  );

logic int_osc;
logic [24:0] counter;


     // Internal high-speed oscillator
  HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

assign led[0] = s[0] ^ s[1];
assign led[1] = s[2] & s[3];

// Counter
   always_ff @(posedge int_osc, negedge reset) begin
        if (!reset) begin
            counter <= 25'd0;
            led[2]  <= 1'b0;
        end else begin
			// frequency of 2.4 Hz
            if (counter == 25'd5000000) begin
                led[2]  <= ~led[2]; // toggle led 
                counter <= 25'd0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
 
endmodule