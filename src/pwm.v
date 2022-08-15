module pwm(
        input				reset,clock,
        input	   [31:0] 	peirod,
        input 	   [31:0]   compare,
        output     [31:0]  	count,
        output 			    pulse
    );

    reg [31:0] 	current;

    always @(posedge clock)begin
        if (reset)begin
            current <=0;
        end else begin
            current <= (current+1 != peirod)?current+1:0;
        end
    end

    assign count=current;
    assign pulse= current<compare;

endmodule
