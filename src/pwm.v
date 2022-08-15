module pwm(
        input				clock,reset,
        input      [31:0]   pwm_peirod,pwm_compare,
        output 			    pwm_pulse,
        output              pwm_fetch
    );

    reg [31:0] 	count,period,compare;
    always @(posedge clock,posedge reset)begin
        if (reset)begin
            count <=0;
            period<=0;
            compare<=0;
        end else begin
            if (count==period)begin
                count<=0;
                period<=pwm_peirod;
                compare<=pwm_compare;
            end else begin
                count<=count+1;
                period<=period;
                compare<=compare;
            end
        end
    end

    assign pwm_pulse=count<compare;
    assign pwm_fetch=count==0;

endmodule
