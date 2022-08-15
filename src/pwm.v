module pwm#(
        parameter width = 32
    )(
        input               clock,reset,
        input [width-1:0]   pwm_period,pwm_compare,
        output  		    pwm_pulse,
        output              pwm_done
    );

    reg  [width-1:0] count,period,compare;
    wire [width-1:0] next=count+1'b1;
    always @(posedge clock,posedge reset)begin
        if (reset)begin
            count<=0;
            period<=pwm_period;
            compare<=pwm_compare;
        end else begin
            if (next==period || period==0)begin
                count<=0;
                period<=pwm_period;
                compare<=pwm_compare;
            end else begin
                count<=next;
                period<=period;
                compare<=compare;
            end
        end
    end

    assign pwm_pulse=count<compare;
    assign pwm_done=count==0;

endmodule
