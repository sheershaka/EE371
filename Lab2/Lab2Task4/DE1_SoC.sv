module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic 			CLOCK_50; // 50MHz clock.
	input logic 	[3:0] KEY;
	input logic 	[9:0] SW; 
	output logic 	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic 	[9:0] LEDR;
	
	logic [4:0]  rdaddress, wraddress;
	logic [3:0]  data;
	logic wren, reset;
	logic	[3:0]  q;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 25;
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(clk));
	
	logic [5:0] counter;
	
	always_ff @(posedge clk[whichClock]) begin
		if (reset) begin
			rdaddress <= 5'd0;
		end else begin
			rdaddress <= rdaddress + 5'd1;
		end
	end
	
	assign counter = rdaddress;
	
	always_ff @(posedge CLOCK_50) begin
		reset <= ~KEY[0];
		data <= SW[3:0];
		wraddress <= SW[8:4];
		wren <= SW[9];
	end
	
	ram32x4 ram1 (.clock(CLOCK_50), .data, .rdaddress, .wraddress, .wren, .q);
	
	seg7 hex54 (.z(wraddress), .d1(HEX5), .d0(HEX4));
	seg7 hex32 (.z(counter), .d1(HEX3), .d0(HEX2));
	hex7 hex0 (.z(q), .d(HEX0));
	hex7 hex1 (.z(data), .d(HEX1));
	assign LEDR = 10'd0;

endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, reset, divided_clocks);
 input logic reset, clock;
 output logic [31:0] divided_clocks = 0;

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end 

endmodule

`timescale 1 ps / 1 ps 
module DE1_SoC_testbench();

	logic 		CLOCK_50; // 50MHz clock.
	logic [3:0] KEY;
	logic [9:0] SW; 
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	
   DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

	// Set up the inputs to the design. Each line is a clock cycle.
	integer i;
	initial begin
		
		KEY[0] <= 1; 						@(posedge CLOCK_50);
		SW[9:0] <= 10'd0; KEY[0] <= 0;@(posedge CLOCK_50);
								KEY[0] <= 1;@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		SW[9] <= 1;							@(posedge CLOCK_50);
		for (i=0; i<2**5; i++) begin
			SW[8:4] <= i; SW[3:0] <= i + 1;  @(posedge CLOCK_50);
		end 
		SW[9] <= 0; @(posedge CLOCK_50);
		KEY[0] = 1; @(posedge CLOCK_50);
		SW[9:0] <= 10'd0; @(posedge CLOCK_50);
		$stop;
   end
endmodule
