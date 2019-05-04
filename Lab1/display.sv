module display (clk, z, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic [4:0] z;
	input logic clk;
	
	logic [6:0] E, M, P, t, y, F, U, L, one, two, three, four, five, six, seven, eight, nine, zero, n;
	
	assign E = 7'b0000110;
	assign M = 7'b0010101;
	assign P = 7'b0001100;
	assign t = 7'b0000111;
	assign y = 7'b0010001;
	assign F = 7'b0001110;
	assign U = 7'b1000001;
	assign L = 7'b1000111;
	assign one = ~7'b0000110;
	assign two = ~7'b1011011;
	assign three = ~7'b1001111;
	assign four = ~7'b1100110;
	assign five = ~7'b1101101;
	assign six  = ~7'b1111101;
	assign seven = ~7'b0000111;
	assign eight = ~7'b1111111;
	assign nine = ~7'b1101111;
	assign zero = ~7'b0111111;
	assign n = 7'b1111111;
		
	always_comb begin
		case (z)
			5'b00000: begin
				HEX5 = E; HEX4 = M; HEX3 = P; HEX2 = t; HEX1 = y; HEX0 = zero;
			end
			5'b00001: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = one;
			end
			5'b00010: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = two;
			end
			5'b00011: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = three;
			end
			5'b00100: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = four;
			end
			5'b00101: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = five;
			end
			5'b00110: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = six;
			end
			5'b00111: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = seven;
			end
			5'b01000: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = eight;
			end
			5'b01001: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = zero; HEX0 = nine;
			end
			5'b01010: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = zero;
			end
			5'b01011: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = one;
			end
			5'b01100: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = two;
			end
			5'b01101: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = three;
			end
			5'b01110: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = four;
			end
			5'b01111: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = five;
			end
			5'b10000: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = six;
			end
			5'b10001: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = seven;
			end
			5'b10010: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = eight;
			end
			5'b10011: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = one; HEX0 = nine;
			end
			5'b10100: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = two; HEX0 = zero;
			end
			5'b10101: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = two; HEX0 = one;
			end
			5'b10110: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = two; HEX0 = two;
			end
			5'b10111: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = two; HEX0 = three;
			end
			5'b11000: begin
				HEX5 = n; HEX4 = n; HEX3 = n; HEX2 = n; HEX1 = two; HEX0 = four;
			end
			5'b11001: begin
				HEX5 = F; HEX4 = U; HEX3 = L; HEX2 = L; HEX1 = two; HEX0 = five;
			end
			default: begin
				HEX5 = F; HEX4 = U; HEX3 = L; HEX2 = L; HEX1 = two; HEX0 = five;
			end
		endcase
	end	

endmodule

module display_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [4:0] z;
	logic clk;
	
	display dut (.clk, .z, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end
	
	initial begin
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
			z = 5'b00000;	@(posedge clk);
			@(posedge clk);
			z = 5'b00001;	@(posedge clk);
			@(posedge clk);
			z = 5'b00010;	@(posedge clk);
			@(posedge clk);
			z = 5'b00011;	@(posedge clk);
			@(posedge clk);
			z = 5'b00100;	@(posedge clk);
			z = 5'b00101;	@(posedge clk);
			z = 5'b00110;	@(posedge clk);
			z = 5'b00111;	@(posedge clk);
			z = 5'b01000;	@(posedge clk);
			z = 5'b01001;	@(posedge clk);
			z = 5'b01010;	@(posedge clk);
			z = 5'b01011;	@(posedge clk);
			z = 5'b01100;	@(posedge clk);
			z = 5'b01101;	@(posedge clk);
			z = 5'b01110;	@(posedge clk);
			z = 5'b01111;	@(posedge clk);
			z = 5'b10000;	@(posedge clk);
			z = 5'b10001;	@(posedge clk);
			z = 5'b10010;	@(posedge clk);
			z = 5'b10011;	@(posedge clk);
			z = 5'b10100;	@(posedge clk);
			z = 5'b10101;	@(posedge clk);
			z = 5'b10110;	@(posedge clk);
			z = 5'b10111;	@(posedge clk);
			z = 5'b11000;	@(posedge clk);
			z = 5'b11001;	@(posedge clk);
			z = 5'b11010;	@(posedge clk);
			z = 5'b11011;	@(posedge clk);
			z = 5'b11100;	@(posedge clk);
			z = 5'b11101;	@(posedge clk);
			z = 5'b11110;	@(posedge clk);
			z = 5'b11111;	@(posedge clk);
		$stop;
	end

endmodule
