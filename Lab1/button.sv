module button (clk, reset, key, out);

	input  logic clk, reset, key;
	output logic out;
	
	logic [1:0] ps, ns;
	parameter A = 2'b00, B = 2'b11;
	
	always_comb begin
		case (ps)
			A:if   (key)  ns = A; 
			  else        ns = B;
			B:if   (key)  ns = A;
			  else		  ns = B;
			default:		  ns = A;
		endcase
	end
	
	assign out = ps[1] & ~ ps[0];

	always_ff @(posedge clk) begin
		if (reset) ps <= A;
		else       ps <= { ps[0], key };
	end
endmodule

module button_testbench();
	logic clk, reset, key, out

	button dut (.clk, .reset, .key, .out);

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
								@(posedge clk);
								@(posedge clk);
		reset <= 1;				@(posedge clk);
		reset <= 0; key <=1;	@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
					key <=0;	@(posedge clk);
								@(posedge clk);
					key <=1;	@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
					key <=0;	@(posedge clk);
								@(posedge clk);
      $stop; // End the simulation.
   end
endmodule
