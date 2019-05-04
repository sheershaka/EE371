module colors (clk, canDraw, x, y, p1_y, p2_y, ball_on, ball_x, ball_y, red, green, blue, vga_blank);

	// Ball and bat size & speed parameters
	integer ballsize  = 16;
	integer batwidth  = 10;
	integer batheight = 64;
	integer hc = 1280;

	input logic clk;
	input logic canDraw;
	input logic ball_on;
	input logic [10:0] x, y, p1_y, p2_y, ball_x, ball_y;
	output logic [7:0] red, green, blue;
	output logic vga_blank;
	
	logic n_vga_blank;
	assign vga_blank = !n_vga_blank;
	
	always_ff @(posedge clk) begin
		if (canDraw) begin
			n_vga_blank <= 1'b0;
			// draw P1 (left) bat
			if (x < batwidth && y > p1_y && y < p1_y + batheight) begin
					// white bat
					red <= 8'b11111111;
					green <= 8'b11111111;
					blue <= 8'b11111111;
			end
			// draw P2 (right) bat
			else if (x > hc - batwidth && y > p2_y && y < p2_y + batheight) begin
					// white bat
					red <= 8'b11111111;
					green <= 8'b11111111;
					blue <= 8'b11111111;
			end
			// draw ball
			else if (ball_on && x > ball_x && x < ball_x + ballsize && y > ball_y && y < ball_y + ballsize) begin
					// white ball
					red <= 8'b11111111;
					green <= 8'b11111111;
					blue <= 8'b11111111;
			end
			// black background
			else begin
					red <= 8'b0000000000;
					green <= 8'b00000000;
					blue <= 8'b00000000;
			end
		end else begin
			// if we are not in the visible area, we must set the screen blank
			n_vga_blank <= 1'b1;
		end
	end
endmodule 