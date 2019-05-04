module datapath(input logic clk, setA, resetResult, incrResult, shiftA,
					 input logic [7:0] A,
					 output logic [3:0] count,
					 output logic A_zero, A_0);
	
	logic [7:0] A_reg;
	logic [3:0] counter;
	
	assign count = counter;
	assign A_zero = (A_reg == 8'd0);
	assign A_0 = A_reg[0];
	
	always_ff @(posedge clk) begin
		if (setA) A_reg <= A;
		if (resetResult) counter <= 4'b0000;
		if (incrResult) counter <= counter + 1'b1;
		if (shiftA) A_reg <= A_reg >> 1;
	end
	
endmodule



module datapath_testbench();

	logic clk, setA, resetResult, incrResult, shiftA;
	logic [7:0] A;
	logic [3:0] count;
	logic A_zero, A_0;
	
	datapath dut(.clk, .setA, .resetResult, .incrResult, .shiftA, .A,
				.count, .A_zero, .A_0);
	

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		A <= 8'b00000011; setA <= 1'b1; resetResult <= 1'b1;
		incrResult <= 1'b0; shiftA <= 1'b0; 									@(posedge clk);  
																						@(posedge clk);
		setA <= 1'b0; resetResult <= 1'b0;	shiftA <= 1'b1;			@(posedge clk);
																						@(posedge clk);  // A_0 should be 0 till now
																						@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);  // A_0 should be 1 now
																						@(posedge clk);
																						@(posedge clk);  // A_0 - 0 and A_zero = 1
		incrResult <= 1'b1; 														@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);  // Count should be 4 by now
																						@(posedge clk);
		A <= 8'b00011111; setA <= 1'b1; resetResult <= 1'b1;
		incrResult <= 1'b0; shiftA <= 1'b0; 									@(posedge clk);  
																						@(posedge clk);
		setA <= 1'b0; resetResult <= 1'b0;	shiftA <= 1'b1;			@(posedge clk);
																						@(posedge clk);  // A_0 should be 0 till now
																						@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);  // A_0 should be 1 now
																						@(posedge clk);
																						@(posedge clk);  // A_0 - 0 and A_zero = 1
		incrResult <= 1'b1; 														@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);
																						@(posedge clk);  // Count should be 4 by now
																						@(posedge clk);
		
																						
		
		$stop;
   end
endmodule
