module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	inout logic [35:0] GPIO_0;

	assign GPIO_0[33:0] = 34'd0;
	assign GPIO_0[35] = enter;
	assign GPIO_0[34] = exit;
	
	logic a, b, enter, exit, reset;
	logic [4:0] counter;
	
	assign a = SW[1];
	assign b = SW[0];
	assign reset = SW[9];
	
	// doing the clock
	logic [31:0] clk;
	parameter whichClock = 10;
	clock_divider cdiv (CLOCK_50, clk);
	
	FSM fsm (.clk(clk[whichClock]), .reset, .in({a, b}), .enter, .exit);
	
	up_counter count (.clk(clk[whichClock]), .reset, .enter, .exit, .counter);
	
	display disp (.clk(clk[whichClock]), .z(counter), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
	
endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
	input  logic          clock;
	output logic  [31:0]  divided_clocks = 0;

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
   end

endmodule

module DE1_SoC_testbench();
	
	logic 	   CLOCK_50; // 50MHz clock.
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; // True when not pressed, False when pressed
	logic [9:0] SW;
	logic [35:0] GPIO_0;
	
	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .GPIO_0);
	
	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	initial begin
											@(posedge CLOCK_50);
		SW[9] <= 1;						@(posedge CLOCK_50);
		SW[9] <= 0;						@(posedge CLOCK_50);
											@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
														@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 0;	@(posedge CLOCK_50);
						SW[1] <= 1; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 1;	@(posedge CLOCK_50);
						SW[1] <= 0; SW[0] <= 0;	@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
	
      $stop; // End the simulation.
   end
endmodule