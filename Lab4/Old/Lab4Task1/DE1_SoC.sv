module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic 			CLOCK_50; // 50MHz clock.
	input logic 	[3:0] KEY;
	input logic 	[9:0] SW; 
	output logic 	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic 	[9:0] LEDR;
	
	logic [7:0]  data;
	logic	[3:0]  count;
	logic  start, reset, done;
	
	always_ff @(posedge CLOCK_50) begin
		data <= SW[7:0];
		reset <= ~KEY[0];
		start <= SW[9];
		LEDR[9] <= done;
	end
	
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	seg7 yo (.z(count), .d(HEX0));
	bitcount count1 (.clk(CLOCK_50), .reset, .start, .data, .count, .done);

endmodule

`timescale 1 ps / 1 ps 
module DE1_SoC_testbench();

	logic 		CLOCK_50; // 50MHz clock.
	logic [3:0] KEY;
	logic [9:0] SW; 
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	
	
	parameter CLOCK_PERIOD=100; 
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
   DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	initial begin 
			@(posedge CLOCK_50);
		KEY[0] <= 0; SW[7:0] <= 8'b10101010;	SW[9] <= 0;	@(posedge CLOCK_50);
		KEY[0] <= 1; SW[7:0] <= 8'b10101010;	SW[9] <= 0; @(posedge CLOCK_50);
															SW[9] <= 1; @(posedge CLOCK_50);
		/*@(posedge CLOCK_50);
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
		@(posedge CLOCK_50);*/
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
