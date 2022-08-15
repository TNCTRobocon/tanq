
`timescale 1ns/100ps

module pwm_test();
    reg         reset,clock;
    reg [31:0]  period,compare;
    wire        pulse,done;

    pwm pwm0(
            .clock(clock),.reset(reset),
            .pwm_period(period),.pwm_compare(compare),
            .pwm_pulse(pulse),.pwm_done(done));

    always #1 begin
        clock<=!clock;
    end

    initial begin
        $dumpfile("pwm_test.vcd");
        $dumpvars(0, pwm_test);
        clock<=0;reset<=1;
        period<=4;
        compare=2;
        #1 reset<=0;
        #8 period<=6;
        #8 period<=0;
        #13 period<=4;
        #40 $finish;
    end

    

endmodule
