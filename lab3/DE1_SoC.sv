module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR = SW;
	
	logic reset;
	assign reset = ~KEY[0];
	
	logic [31:0] clk;
	parameter whichClock = 21;
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(clk));
	
	logic [10:0] a = 100;
	logic [10:0] b = 300;
	logic [10:0] c = 400;
	logic [10:0] d = 300;
	logic [10:0] x, y;
	logic color;

	
	VGA_framebuffer fbwhite (.clk50(CLOCK_50), .reset(1'b0), .x, .y,
				.pixel_color(color), .pixel_write(1'b1),
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_n(VGA_BLANK_N), .VGA_SYNC_n(VGA_SYNC_N));
				
	line_drawer lineswhite (.clk(CLOCK_50), .reset(1'b0), .x0(a), .y0(b), .x1(c), .y1(d), .x, .y);
	
	logic [4:0] counter = 5'd0;
	logic direction = 1;
	always_ff @(posedge clk[whichClock]) begin
		if (direction) begin
			a <= a; b <= b; c <= c + 5; d <= d + 5;
		end else begin
			a <= a; b <= b; c <= c - 5; d <= d - 5;
		end
		counter <= counter + 1;
		if (counter == 5'b11111) begin
			direction <= ~direction;
			color <= ~color;
		end
	end
	
endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, reset, divided_clocks);
	input logic reset, clock;
	output logic [31:0] divided_clocks = 0;

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end 

endmodule
