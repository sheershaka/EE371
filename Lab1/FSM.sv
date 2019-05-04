module FSM (clk, reset, in, enter, exit);

	input logic clk, reset;
	input logic [1:0] in;
	output logic enter, exit;
	
	logic [1:0] ps, ns;
	
	parameter A = 2'b00;
	parameter B = 2'b10;
	parameter C = 2'b01;
	parameter D = 2'b11;
	
	assign enter = ~in[0] & ~in[1] & ~ps[0] & ps[1];
	assign exit = ~in[0] & ~in[1] & ps[0] & ~ps[1];
	assign ns[0] = in[0];
	assign ns[1] = in[1];
	
	always_ff @(posedge clk) begin
		if (reset) ps <= A;
		else ps <= ns;
	end
	
endmodule

module FSM_testbench();

	logic clk, reset;
	logic [1:0] in;
	logic enter, exit;
	
	FSM dut (.clk, .reset, .in, .enter, .exit);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end
	
	initial begin
						@(posedge clk);
	reset <= 1;		@(posedge clk);
						@(posedge clk);
	reset <= 0;		@(posedge clk);
						@(posedge clk);
			in[0] = 0; in[1] = 0;	@(posedge clk);
			in[0] = 0; in[1] = 0;	@(posedge clk);
			in[0] = 1; in[1] = 0;	@(posedge clk);
			in[0] = 1; in[1] = 0;	@(posedge clk);
			in[0] = 1; in[1] = 1;	@(posedge clk);
			in[0] = 1; in[1] = 1;	@(posedge clk);
			in[0] = 0; in[1] = 1;	@(posedge clk);
			in[0] = 0; in[1] = 1;	@(posedge clk);
			in[0] = 0; in[1] = 0;	@(posedge clk);
			in[0] = 0; in[1] = 0;	@(posedge clk);
			in[0] = 0; in[1] = 1;	@(posedge clk);
			in[0] = 0; in[1] = 1;	@(posedge clk);
			in[0] = 1; in[1] = 1;	@(posedge clk);
			in[0] = 1; in[1] = 1;	@(posedge clk);
			in[0] = 1; in[1] = 0;	@(posedge clk);
			in[0] = 1; in[1] = 0;	@(posedge clk);
			in[0] = 0; in[1] = 0;	@(posedge clk);
			in[0] = 0; in[1] = 0;	@(posedge clk);
		$stop;
	end

endmodule
