module bitcount (clk, reset, start, data, count, done);

	input logic clk, reset, start;
	input logic [7:0] data;
	output logic done;
	output logic [3:0] count;
	
	logic [7:0] A;
	logic [3:0] result;
	logic [1:0] ps, ns;
	
	
	assign count = result;
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) ps <= 2'b00;
		else ps <= ns;
	end
	
	always_ff @(posedge clk) begin
		case (ps)
			2'b00: begin
					result <= 4'd0; // result = 0
					done <= 0;
					if (start) begin
						ns <= 2'b01;
					end else begin
						ns <= 2'b00;
						A <= data;
					end
				 end
			2'b01: begin 
					if (|A) begin
						if (A[0]) result <= result + 4'd1;
						ns <= 2'b01;
					end else begin
						ns <= 2'b10;
					end
					A <= {1'b0, A[7:1]};// right shift A
				 end
			2'b10: begin
					if (start) ns <= 2'b10;
					else ns <= 2'b00;
					done <= 1; //done
				 end
			default: ns <= 2'bxx;
		endcase
	end
	
endmodule

module bitcount_tb();

	logic clk, reset, start;
	logic [7:0] data;
	logic done;
	logic [3:0] count;
	
	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	bitcount dut (.clk, .reset, .start, .data, .count, .done);
	
	initial begin 
		reset <= 1;	data <= 8'b10101010;	start <= 0;	@(posedge clk);
		reset <= 0; data <= 8'b10101010;	start <= 0; @(posedge clk);
													start <= 1; @(posedge clk);
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
