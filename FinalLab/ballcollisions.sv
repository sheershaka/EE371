module ballcollisions (clk, reset, p1_y, p2_y, ball_x, ball_y, dir_x, dir_y, outofbounds, collision);

	integer hc = 1280;		// horizontal screen size (px)
	integer va = 2;		//VGA_HSYNC
	integer vc = 480;		// vertical screen size (px)
	integer ballsize = 16;
	integer batwidth  = 10;
	integer batheight = 64;
	
	input logic clk, reset;
	input logic [10:0] p1_y, p2_y, ball_x, ball_y;
	output logic dir_x, dir_y;
	output logic outofbounds; //out of bounds
	output logic collision;

	initial begin
		dir_x <= 0;
		dir_y <= 1;
		outofbounds <= 0;
		collision <= 0;
	end
		
	always_ff @(posedge clk) begin
		if (reset) begin
			dir_x <= ~dir_x;	// alternate starting direction every round
			dir_y <= 1;
			outofbounds <= 0;
			collision <= 0;
		end
		else begin
			// out of bounds (i.e. one of the players missed the ball)
			if (ball_x <= 0 || ball_x >= hc) begin
				outofbounds <= 1;
				collision <= 0;
			end else begin
				outofbounds <= 0;
				collision <= 0;
			end
			
			// collision with top & bottom walls
			if (ball_y <= va + 5) begin
				dir_y <= 1;
				collision <= 1;
			end
			if (ball_y >= vc - ballsize) begin
				dir_y <= 0;
				collision <= 1;
			end
			
			// collision with P1 bat
			if (ball_x <= batwidth && ball_y + ballsize >= p1_y && ball_y <= p1_y + batheight) begin
				collision <= 1;
				dir_x <= 1;	// reverse the direction
				if (ball_y + ballsize <= p1_y + (batheight / 2)) begin
					// collision with top half of p1 bat, go up
					dir_y <= 0;
				end else begin
					// collision with bottom half of p1 bat, go down
					dir_y <= 1;
				end
			end
			// collision with P2 bat
			else if (ball_x >= hc - batwidth - ballsize && ball_y + ballsize <= p2_y + batheight && ball_y >= p2_y) begin
				collision <= 1;
				dir_x <= 0;	// reverse direction
				if (ball_y + ballsize <= p2_y + (batheight / 2)) begin
					// collision with top half of p1 bat, go up
					dir_y <= 0;
				end else begin
					// collision with bottom half of p1 bat, go down
					dir_y <= 1;
				end
			end
		end
	end
	
endmodule
