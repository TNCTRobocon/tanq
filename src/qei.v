module quad_diff(
        input           clock,reset,
        input   [1:0]   quad_now,quad_last,
        output  [1:0]   quad_up_down);

    reg [1:0] up_down;

    always @(posedge clock,posedge reset)begin
        if (reset)begin
            up_down<=0;
        end else begin
            case ({quad_last,quad_now})
                4'b00_01:   up_down<=2'b1_0;
                4'b00_10:   up_down<=2'b0_1;
                4'b01_11:   up_down<=2'b1_0;
                4'b01_00:   up_down<=2'b0_1;
                4'b11_10:   up_down<=2'b1_0;
                4'b11_01:   up_down<=2'b0_1;
                4'b10_00:   up_down<=2'b1_0;
                4'b10_11:   up_down<=2'b0_1;
                default:    up_down<=2'b0_0;
            endcase
        end
    end

    assign quad_up_down=up_down;
endmodule

// TODO: move helper and remake more generic
module quad_delay(
        input clock, reset,
        input  [1:0]  quad_in,
        output [1:0]  quad_out
    );

    // Double D-FF
    reg[1:0] delay;
    always @(posedge clock, posedge reset) begin
        if (reset) begin
            delay<=0;
        end else begin
            delay<=quad_in;
        end
    end
    assign quad_out=delay;
endmodule

module qei(
        input           clock,reset,
        input   [1:0]   qei_quad,
        output  [31:0]  qei_position);


    wire [1:0] quad_now,quad_last;//alias

    quad_delay quad_delay0(
                   .clock(clock),.reset(reset),
                   .quad_in(qei_quad),.quad_out(quad_now));

    quad_delay quad_delay1(
                   .clock(clock),.reset(reset),
                   .quad_in(quad_now),.quad_out(quad_last));

    wire [1:0] quad_up_down;
    quad_diff quad_diff0(
                  .clock(clock),.reset(reset),
                  .quad_now(quad_now),.quad_last(quad_last),
                  .quad_up_down(quad_up_down));

    reg [31:0]  position;
    always @(posedge clock,posedge reset) begin
        if (reset)begin
            position<=0;
        end else begin
            case (quad_up_down)
                2'b00: position <= position;
                2'b10: position <= position+1;
                2'b01: position <= position-1;
                2'b11: position <= position;
            endcase
        end
    end

    assign qei_position=position;
endmodule
