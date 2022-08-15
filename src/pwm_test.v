
`timescale 1ns/100ps

module pwm_test();
    reg        reset,clock;
    reg [31:0] peirod;
    reg [31:0] compare;

    wire pulse,fetch;

    pwm pwm0(
            .clock(clock),.reset(reset),
            .pwm_peirod(peirod),.pwm_compare(compare),
            .pwm_pulse(pulse),.pwm_fetch(fetch));

    always #1 begin
        clock<=!clock;
    end

    initial begin
        $dumpfile("pwm_test.vcd");
        $dumpvars(0, pwm_test);
        clock<=0;reset<=1;
        peirod<=4;
        compare=2;
         #1 reset=0;
        #100 $finish;
    end

    

endmodule
