module gamelogic (clk, start, reset, p1_up, p1_down, p2_up, p2_down, p1_y, p2_y, ball_on, ball_x, ball_y, p1_score, p2_score, winner, collision);

	input clk;
	input reset;
	input start;
	input p1_up, p1_down, p2_up, p2_down;
	output [10:0] p1_y, p2_y;
	output [10:0] ball_x, ball_y;
	output ball_on;
	output [3:0] p1_score, p2_score; // 0 - 10
	output [1:0] winner;	// 0 = none, 1 = P1, 2 = P2
	output collision; // for sound
	
	integer ballspeed =  3;
	integer batspeed  = 8;
	
	initial begin
		p1_score <= 4'b0;
		p2_score <= 4'b0;
		winner <= 0;
		ball_on <= 1;
	end
	
	logic dir_x;		// 0 = LEFT, 1 = RIGHT
	logic dir_y;		// 0 = UP, 1 = DOWN
	
	logic outofbounds;  // if the ball is out of the screen
	logic newround;		// new round after the miss
	
	logic [25:0] count_sec;
	logic [1:0] count_secs;
	always_ff @(posedge clk) begin
		if (outofbounds) begin
			ball_on = 0;
			// to add a delay before the next round starts.
			if (count_sec == 26'd26_999_999) begin
				count_sec = 26'd0;
				count_secs = count_secs + 1;
			end else begin
				count_sec = count_sec + 1;
			end
			// 1 secs after ball is out of bounds
			if (count_secs == 3) begin
				// Increment the score on the first clock cycle
				// We need to check for this so the score is only incremented ONCE
				if (count_sec == 26'd1) begin
					if (dir_x) begin
						p1_score = p1_score + 1; // Out of bounds on the right
					end else begin
						p2_score = p2_score + 1; // Out of bounds on the left
					end	
				end
				// Checking if someone has won
				if (p1_score == 4'd10) begin
					winner = 2'd1;
				end else if (p2_score == 4'd10) begin
					winner = 2'd2;
				end
				// stary a new round
				ball_on = 1;
				newround = 1;
			end
		end else begin // not out of bounds
			if (newround) begin
				newround = 0;
			end
			count_secs = 1'b0;
			count_sec = 26'd0;
			
			if (reset) begin
				p1_score = 0;
				p2_score = 0;
				winner = 0;
			end
		end
	end
	
	// Module for controlling player 1's bat
	batpos b1 (.clk(clk && start), .up(p1_up), .down(p1_down), .reset, .speed(batspeed), .value(p1_y));
		
	// Module for controlling player 2's bat
	batpos b2 (.clk(clk && start), .up(p2_up), .down(p2_down), .reset, .speed(batspeed), .value(p2_y));
		
	// Ball collision detection module
	ballcollisions bcs (.clk(clk && start && ball_on), .reset(reset || newround), 
									.p1_y, .p2_y, .ball_x, .ball_y, .dir_x, .dir_y, .outofbounds, .collision);
	
	// Module with counters that determining the ball position
	ballpos bp (.clk(clk && start && ball_on), .reset(reset || newround || (winner > 0)), 
						.speed(ballspeed), .dir_x, .dir_y, .value_x(ball_x),.value_y(ball_y));
		
endmodule

