module controller(input logic clk, s, reset, A_zero, A_0,
						input logic [7:0] A,
						output logic setA, resetResult, incrResult, shiftA,
						done);
						
	enum logic [1:0] {S1=2'b00, S2=2'b01, S3=2'b10} ps, ns;
	
	// state change
	always_comb begin
		case (ps)
			S1: if (s) ns = S2;
				 else ns = S1;
			S2: if (A_zero) ns = S3;
				 else ns = S2;
			S3: if (s) ns = S3;
				 else ns = S1;
			default: ns = S1;
		endcase
	end
	
	// synchronous reset
	always_ff @(posedge clk) begin
		if (reset)
			ps <= S1;
		else 
			ps <= ns;
	end
	
	// Assigning the output signals for the datapath
	assign setA = (ps == S1) && (~s);
	assign resetResult = (ps == S1);
	assign shiftA = (ps == S2);
	assign incrResult = (ps == S2) && (~A_zero) && (A_0);
	assign done = (ps == S3) & (ps != S1);
	
endmodule


module controller_testbench();
	logic  clk, A_zero, A_0, s, reset;
	logic [7:0] A;
	logic setA, resetResult, incrResult, shiftA, done;
	
	controller dut(.clk, .s, .reset, .A_zero, .A_0, .A, .setA, .resetResult, 
						.incrResult, .shiftA, .done);
	

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		reset <= 1'b1; A <= 8'b00000011;
		s <= 1'b0; A_zero <= 1'b0; A_0 <= 0; 	@(posedge clk);  // Initial state
		reset <= 1'b0;				   				@(posedge clk);  // Should output set_A
															@(posedge clk);
															@(posedge clk);
		s <= 1'b1; 										@(posedge clk);  // Should emit shift_a
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		A_0 <= 1'b1;									@(posedge clk);  // Should emit incrResult
															@(posedge clk);
															@(posedge clk);
		A_zero <= 1'b1;								@(posedge clk);  // Should emit done
															@(posedge clk);
															@(posedge clk);
		s <= 1'b0;										@(posedge clk);  // done <= 0 and resetCount and LoadA
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		reset <= 1'b1; A <= 8'b00011111;
		s <= 1'b0; A_zero <= 1'b0; A_0 <= 0; 	@(posedge clk);  // Initial state
		reset <= 1'b0;				   				@(posedge clk);  // Should output set_A
															@(posedge clk);
															@(posedge clk);
		s <= 1'b1; 										@(posedge clk);  // Should emit shift_a
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		A_0 <= 1'b1;									@(posedge clk);  // Should emit incrResult
															@(posedge clk);
															@(posedge clk);
		A_zero <= 1'b1;								@(posedge clk);  // Should emit done
															@(posedge clk);
															@(posedge clk);
		s <= 1'b0;										@(posedge clk);  // done <= 0 and resetCount and LoadA
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		
		
		$stop;
   end
endmodule
