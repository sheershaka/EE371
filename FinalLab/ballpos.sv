module ballpos (clk, reset, speed, dir_x, dir_y, value_x,	value_y);

	integer ballsize = 16;
	integer hc = 1280;	// horizontal screen size (px)
	integer vc = 480;

	input logic clk;
	input logic [4:0] speed;			// number of pixels to increment ball by
	input logic reset;
	input logic dir_x; // 0 = LEFT, 1 = RIGHT
	input logic dir_y; // 0 = UP, 1 = DOWN
	output logic [10:0] value_x, value_y;
	
	
	// the initial position of the ball is the middle of the screen
	initial begin
		value_x <= hc / 2 - (ballsize / 2);
		value_y <= vc / 2;
	end
	
	always_ff @ (posedge clk or posedge reset) begin
		if (reset) begin
			value_x <= hc / 2 - (ballsize / 2); //send to initial position
			value_y <= vc / 2;
		end else begin
			// increment x
			if (dir_x) begin 
				value_x <= value_x + speed; // to right
			end else begin
				value_x <= value_x - speed; // to left
			end
			// increment y
			if (dir_y) begin
				value_y <= value_y + speed; // go down
			end else begin
				value_y <= value_y - speed; // go up
			end
		end
	end

endmodule
