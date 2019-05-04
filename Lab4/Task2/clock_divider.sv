// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
// HARDWARE ONLY - not to be used in simulation
module clock_divider (clock, divided_clocks);
	input clock;
	output [31:0] divided_clocks;
	reg [31:0] divided_clocks;

	initial
		divided_clocks = 0;

	always_ff @(posedge clock)
		divided_clocks = divided_clocks + 1;
	endmodule