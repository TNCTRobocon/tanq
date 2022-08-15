`timescale 1ns/100ps

module qei_test();

reg         clock,reset;
reg  [1:0]   quad;
wire [31:0]  position;

qei qei0(
    .clock(clock),.reset(reset),
    .qei_quad(quad),.qei_position(position));

always #1 begin
    clock<=!clock;
end

initial begin 
            $dumpfile("qei_test.vcd");
            $dumpvars(0, qei_test);
            reset<=1;
            clock<=0;
            quad<=2'b00;
        #1  reset<=0; #1
        #2  quad<=2'b01;
        #2  quad<=2'b11;
        #2  quad<=2'b10;
        #2  quad<=2'b00;
        #2  quad<=2'b00;
        #2  quad<=2'b10;
        #2  quad<=2'b11;
        #2  quad<=2'b01;
        #2  quad<=2'b00;
        #2  quad<=2'b11;
        #10
            $finish;
end

endmodule