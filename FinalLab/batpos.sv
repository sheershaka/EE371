module batpos (clk, up, down, reset, speed, value);

	integer batheight = 64;
	integer vc = 480;
	integer va = 2;

	input clk, reset;
	input up, down;				// signal for counting up/down
	input [4:0] speed;			// number of pixels to increment the bats by
	output [10:0] value;
	
	initial begin
		value <= vc / 2;  // in the middle of the screen
	end
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			value <= vc / 2; // in the middle of the screen
		end else begin
			if (up) begin
				// to check the bat if it is going above the top of the screen
				if ((value - speed) > va) begin
					value <= value - speed; // move the bat up
				end
			end else if (down) begin
				// to check the bat if it is going below the bottom of the screen
				if ((value + speed) < (vc - batheight)) begin
					value <= value + speed; // move the bat down
				end
			end
		end
	end

endmodule
