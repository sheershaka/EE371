module line_drawer(
	input logic clk, reset,
	input logic [10:0]	x0, y0, x1, y1, //the end points of the line
	output logic [10:0]	x, y	//outputs corresponding to the pair (x, y)
	);
	
	/*
	 * You'll need to create some registers to keep track of things
	 * such as error and direction
	 * Example: */
	logic signed [11:0] error, delta_x, delta_y;
	logic signed [1:0] ystep;
	logic steep;
	logic [1:0] state;
	
	logic [10:0] a0, b0, a1, b1, a, b;
	assign steep = ((y1 > y0) ? (y1 - y0) : (y0 - y1)) > ((x1 > x0) ? (x1 - x0) : (x0 - x1));
	assign ystep = (y0 < y1 ? 1 : -1);

	
	always_ff @(posedge clk)  begin
		case (state)
			2'd0: begin
						/*if (reset) begin
							a0 <= -1; b0 <= -1; a1 <= -1; b1 <= -1;
						end else begin*/
							if (steep) begin
								if (y0 > y1) begin
									a0 <= y1; b0 <= x1; a1 <= y0; b1 <= x0;
									delta_x <= y0 - y1;
								end else begin
									a0 <= y0; b0 <= x0; a1 <= y1; b1 <= x1;
									delta_x <= y1 - y0;
								end
								delta_y <= (x1 > x0) ? (x1 - x0) : (x0 - x1);
							end else begin
								if (x0 > x1) begin
									a0 <= x1; b0 <= y1; a1 <= x0; b1 <= y0;
									delta_x <= x0 - x1;
								end else begin
									a0 <= x0; b0 <= y0; a1 <= x1; b1 <= y1;
									delta_x <= x1 - x0;
								end
								delta_y <= (y1 > y0) ? (y1 - y0) : (y0 - y1);
							end
						//end
						state <= 2'd1;
					end
			2'd1: begin
						error <= {delta_x[11], delta_x[11:1]}; // error = deta_x/2
						a <= a0;
						b <= b0;
						state <= 2'd2;
					end
			2'd2: begin 
						if (steep) begin
							x <= b; y <= a;
						end else begin 
							x <= a; y <= b;
						end
						a <= a + 11'd1;
						if (error - delta_y < 0) begin
							error <= error - delta_y + delta_x;
							b <= b + ystep;
						end else begin
							error <= error - delta_y;
						end
						if (a == a1) begin
							state <= 2'd0;
						end
					end
			default: state <= 2'd0;
		endcase
	end
	/*if(~steep) begin
			if ((a0 > a1 ? a1: a0) <= i && i <= (a1 > a0 ? a1: a0)) begin
				if (a0 == b0 && a1 == b1) begin
					x <= i; y <= i;
				end else if (a0 == b1 && a1 == b0) begin 
					x <= i; y <= a0 + b0 - i;
				end else begin
					x <= i; y <= slope*(i - a0) + b0;
				end
			end
		end else begin
		
		end
	end*/
	
endmodule

module line_drawer_testbench();

	logic clk, reset;
	logic [10:0] x0, y0, x1, y1; //the end points of the line
	logic [10:0]	x, y;//outputs corresponding to the pair (x, y)
	
	line_drawer dut(.clk, .reset, .x0, .y0, .x1, .y1, .x, .y);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end
	
	integer i;
	initial begin
		x0 <= 0; x1 <= 240; y0 <= 0; y1 <= 240; @(posedge clk);
		for (int i = 0; i < 640; i++) begin
			@(posedge clk);
		end
	$stop;
	end

endmodule
