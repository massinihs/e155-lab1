 module switcher(input logic reset, input logic [7:0] s, 
            output logic [13:0] seg, output logic [1:0] enable);
 
 logic int_osc;
    logic [24:0] counter;
    logic select_digit;
    logic [3:0] active_digit;
    logic [6:0] seg_out;

    // Internal high-speed oscillator
    HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (
        .CLKHFPU(1'b1), 
        .CLKHFEN(1'b1), 
        .CLKHF(int_osc)
    );

    // Counter
    always_ff @(posedge int_osc) begin
        if (reset)  
            counter <= 0;
        else
            counter <= counter + 1;
    end


    // Instantiate hardware for segment displays
    segment_display decoder(
    (active_digit),
    (seg_out)
    );

    assign select_digit = counter[15];  

    always_comb begin
        if (select_digit) begin
            enable = 2'b01;          // Activate first display
            active_digit = s[3:0];   // Lower nibble
            seg[6:0]   = seg_out;
            seg[13:7]  = 7'b1111111; // Turn off second digit
        end else begin
            enable = 2'b10;          // Activate second display
            active_digit = s[7:4];   // Upper nibble
            seg[6:0]   = 7'b1111111; // Turn off first digit
            seg[13:7]  = seg_out;
        end
    end


 endmodule