module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic 			CLOCK_50; // 50MHz clock.
	input logic 	[3:0] KEY;
	input logic 	[9:0] SW; 
	output logic 	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic 	[9:0] LEDR;
	
	// input and output logic
	logic [6:0] HEX_1, HEX_0;
	logic  reset, start, found;
	logic [7:0]  data;
	always_comb begin
		// input
		reset = ~KEY[0];
		data = SW[7:0];
		start = SW[9];
		//output
		//if (found) begin
			HEX0 = HEX_0;
			HEX1 = HEX_1;
//		end else begin
//			HEX0 = 7'b1111111;
//			HEX1 = 7'b1111111;
//		end
		HEX2 = 7'b1111111;
		HEX3 = 7'b1111111;
		HEX4 = 7'b1111111;
		HEX5 = 7'b1111111;
		LEDR[8:0] = 9'd0;
		LEDR[9] = found;
	end
	
	// creating new and slower clock
	logic [31:0] clk;
	parameter whichClock = 15; 
	clock_divider cdiv (CLOCK_50, clk);
	
	// logic to communicate with RAM
	logic [4:0]  rdaddress;
	logic	[7:0]  q;
	ram32x8 ram1 (.clock(CLOCK_50), .data(8'd0), .address(rdaddress), .wren(1'b0), .q);
	seg7 hex10 (.z(rdaddress), .d1(HEX_1), .d0(HEX_0));
	
	// datapath and controller logic
	logic set_high, set_low, reset_bounds;
	logic [7:0] current_data;
	
	datapath signal (.clk(clk[whichClock]), .reset_bounds, .set_high, .set_low , .q, .current_data, .rdaddress);			  
	controller control (.clk(clk[whichClock]), .start, .reset, .data, .current_data, .found, .set_high, .set_low, .reset_bounds);
	


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
module ram_testbench();

	logic CLOCK_50, wren;	
	logic [4:0]  address;
	logic [7:0]  data;
	
	logic	[7:0]  q;
	
	ram32x8 dut(.address, .clock(CLOCK_50), .data, .wren, .q);
	
	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	integer i;
	initial begin	
		address <= 0; data <= 0; wren <= 0; @(posedge CLOCK_50);
		for (i=0; i<2**5; i++) begin
			address <= i; 						   @(posedge CLOCK_50);
		end 
		 @(posedge CLOCK_50);
		$stop;
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

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	
	initial begin 
		KEY[0] <= 0; SW[7:0] <= 8'b00000001;	SW[9] <= 0;	@(posedge CLOCK_50);
		KEY[0] <= 1; 	SW[9] <= 0; @(posedge CLOCK_50);
													SW[1] <= 1; @(posedge CLOCK_50);
		//q <= 8'd15; @(posedge clk);
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
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		$stop;
	end
	
endmodule
