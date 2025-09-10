module switcher(
    input  logic        reset,         // Active-low reset
    input  logic [7:0]  s,             // 8-bit input (two hex digits)
    output logic [6:0]  seg,           // 7-segment output (a to g)
    output logic [1:0]  enable         // Digit enable (active LOW)
);

    logic int_osc;                    
    logic [24:0] counter;              
    logic digit_sel;                 
    logic [3:0] active_digit;          

    // nternal high-speed oscillator
    HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (
        .CLKHFPU(1'b1), 
        .CLKHFEN(1'b1), 
        .CLKHF(int_osc)
    );

    // Instantiate 7-segment decoder
    segment_display decoder(active_digit, seg);

    // Time-multiplexing logic
    always_ff @(posedge int_osc, negedge reset) begin
        if (!reset) begin
            counter    <= 25'd0;
            digit_sel  <= 1'b0;
        end else begin
            if (counter == 25'd50000) begin 
                digit_sel <= ~digit_sel;
                counter   <= 25'd0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    // Select the digit value and active display
    assign active_digit = digit_sel ? s[7:4] : s[3:0];
    assign enable       = digit_sel ? 2'b01 : 2'b10;

endmodule