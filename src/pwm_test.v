
`timescale 1ns/100ps

module pwm_test();
    reg        reset,clock;
    reg [31:0] peirod;
    reg [31:0] compare;
    wire [31:0] count;

    wire pulse;

    pwm pwm0(
            .reset(reset),.clock(clock),
            .peirod(peirod),.compare(compare),
            .count(count), .pulse(pulse));

    initial begin
        $dumpfile("pwm_test.vcd");
        $dumpvars(0, pwm_test);
        clock=0;
        peirod=4;
        compare=2;
        reset=1; #1 reset=0;
        #100 $finish;
    end

    always #0.5 begin
        clock=!clock;
    end

endmodule
