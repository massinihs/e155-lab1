module seven_segment_multiplexer (
    input  logic        clk,
    input  logic        reset,
    input  logic [3:0]  digit1,   // First digit input
    input  logic [3:0]  digit2,   // Second digit input
    output logic [6:0]  seg,      // Seven segment outputs (a to g)
    output logic [1:0]  an        // Anode signals (active low)
);

    // Internal clock divider for multiplexing (~1kHz suggested)
    logic [15:0] clk_div;
    logic        mux_clk;     // Slow clock for switching digits
    logic        sel;         // Digit selector

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            clk_div <= 0;
            mux_clk <= 0;
        end else begin
            clk_div <= clk_div + 1;
            if (clk_div == 0)
                mux_clk <= ~mux_clk;
        end
    end

    // Digit selector toggled by mux_clk
    always_ff @(posedge mux_clk or posedge reset) begin
        if (reset)
            sel <= 0;
        else
            sel <= ~sel;
    end

    // Digit selected based on sel
    logic [3:0] current_digit;
    always_comb begin
        case (sel)
            1'b0: begin
                current_digit = digit1;
                an = 2'b10;  // Enable digit1 (an[0] = 0), disable digit2
            end
            1'b1: begin
                current_digit = digit2;
                an = 2'b01;  // Enable digit2 (an[1] = 0), disable digit1
            end
        endcase
    end

    // Seven segment decoder (common anode: active LOW outputs)
    always_comb begin
        case (current_digit)
            4'h0: seg = 7'b0000001;
            4'h1: seg = 7'b1001111;
            4'h2: seg = 7'b0010010;
            4'h3: seg = 7'b0000110;
            4'h4: seg = 7'b1001100;
            4'h5: seg = 7'b0100100;
            4'h6: seg = 7'b0100000;
            4'h7: seg = 7'b0001111;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0000100;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b1100000;
            4'hC: seg = 7'b0110001;
            4'hD: seg = 7'b1000010;
            4'hE: seg = 7'b0110000;
            4'hF: seg = 7'b0111000;
            default: seg = 7'b1111111; // all off
        endcase
    end

endmodule
