module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic 			CLOCK_50; // 50MHz clock.
	input logic 	[3:0] KEY; // True when not pressed, False when pressed
	input logic 	[9:0] SW; 
	output logic 	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic 	[9:0] LEDR; 
	
	logic A_zero, A_0, s, reset, setA, resetResult, incrResult, shiftA, done;
	logic [7:0] A;
	logic [3:0] count;
	
	logic [31:0] clk;
	parameter whichClock = 2; //12 
	clock_divider cdiv (CLOCK_50, ~KEY[1], clk);  // Comment out for simulation
	
	assign A = SW[7:0];
	assign reset = ~KEY[0];
	assign s = SW[9];
	assign LEDR[9] = done;
	
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	seg7 yo (.z(count), .d(HEX0));
	
	controller c(.clk(clk[whichClock]), .s, .reset, .A_zero, .A_0, .A, .setA, .resetResult, 
						.incrResult, .shiftA, .done);
	
	datapath data(.clk(clk[whichClock]), .setA, .resetResult, .incrResult, .shiftA, .A,
				.count, .A_zero, .A_0);
				
	
endmodule

module DE1_SoC_testbench();
	logic  clk;
	logic [9:0] SW;
   logic [9:0] LEDR;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [3:0] KEY;
	logic [5:0] GPIO_0;
	
   DE1_SoC dut (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		KEY[0] = 1'b1; KEY[1] = KEY[0]; SW[7:0] <= 8'b00000011; SW[9] <= 1'b0;	@(posedge clk);  // Reset
		KEY[0] = 1'b0; KEY[1] = KEY[0]; 											   @(posedge clk);
		SW[9] <= 1'b1;														   @(posedge clk);  // Now it should start counting
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);   // the result should be 2 by the end
		KEY[0] = 1'b1; KEY[1] = KEY[0]; SW[7:0] <= 8'b00001111; SW[9] <= 1'b0;	@(posedge clk);  // Reset
		KEY[0] = 1'b0; KEY[1] = KEY[0]; 													   @(posedge clk);
		SW[9] <= 1'b1;														   @(posedge clk);  // Now it should start counting
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
		
		$stop;
   end
	
endmodule

