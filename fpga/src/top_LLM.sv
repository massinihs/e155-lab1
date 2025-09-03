module led_blinker_2hz (
    output logic led
);

    // Instantiate the internal high-speed oscillator (HSOSC)
    logic clk_48mhz;

    // Lattice-specific oscillator primitive (from iCE40UP5K tech library)
    // Enable is tied high to keep oscillator running
    HSOSC #(
        .CLKHF_DIV("0b00") // 48 MHz
    ) internal_oscillator (
        .CLKHFEN(1'b1),
        .CLKHFPU(1'b1),
        .CLKHF(clk_48mhz)
    );

    // Parameters
    localparam int unsigned TOGGLE_COUNT = 24_000_000; // 0.5s @ 48 MHz

    // Internal counter
    logic [24:0] counter = 0;  // 25 bits to count up to 24 million
    logic led_state = 0;

    // Clock divider logic
    always_ff @(posedge clk_48mhz) begin
        if (counter == TOGGLE_COUNT - 1) begin
            counter   <= 0;
            led_state <= ~led_state;
        end else begin
            counter <= counter + 1;
        end
    end

    // Assign output
    assign led = led_state;

endmodule
