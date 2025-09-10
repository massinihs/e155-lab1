//module llm_2 (
    //input  logic        clk,          // oscillator clock input
    //input  logic [3:0]  in0,          // first 4-bit input
    //input  logic [3:0]  in1,          // second 4-bit input
    //output logic [6:0]  seg,          // seven segment outputs
    //output logic [1:0]  an            // anode control (2 digits)
//);

    // // Internal signals
    //logic [3:0] nibble;
    //logic       mux_sel;
    //logic [15:0] div_counter;

    // // Clock divider to get a slower refresh rate for multiplexing
    //always_ff @(posedge clk) begin
        //div_counter <= div_counter + 1;
        //mux_sel <= div_counter[15];   // toggle select at lower frequency
    //end

    // //Select which input nibble to display
    //always_comb begin
        //if (mux_sel == 1'b0) begin
            //nibble = in0;
            //an = 2'b10;   // enable first digit (active low)
        //end else begin
            //nibble = in1;
            //an = 2'b01;   // enable second digit (active low)
        //end
    //end

    // // Instantiate the provided seven segment decoder
    //sevenseg_decoder u_decoder (
        //.in   (nibble),
        //.seg  (seg)
    //);

// endmodule
