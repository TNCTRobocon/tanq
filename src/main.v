module main(
	input base_clk, base_reset_n,
	output motor0_pulse,motor0_dir

);


// clock&reset,pll

parameter base_freq =  24_000_000;// 24MHz
parameter fast_freq = 120_000_000;//120MHz (pll base_freq x5)
wire base_reset = !base_reset_n;
wire fast_reset;
wire fast_clk;
wire fast_lock;

pll_120mhz pll_120mhz(
	.refclk(base_clk),
	.stdby(1'b1),
	.reset(base_reset),
	.extlock(fast_lock),
	.clk0_out(fast_clk)
	);

assign fast_reset = base_reset || !fast_lock;
// pwm
wire pwm0_dir,pwm0_pulse;
pwm pwm0(.reset(fast_reset),.clock(fast_clk),.peirod(fast_freq),.compare(fast_freq/2),.count(),.pulse(motor0_pulse));

endmodule
