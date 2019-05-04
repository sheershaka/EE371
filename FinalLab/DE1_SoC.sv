module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, CLOCK_27, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, GPIO_0, PS2_CLK, PS2_DAT,
	CLOCK2_50, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	// CLOCK_50 for VGA and CLOCK_27 for game logic 
	input CLOCK_50, CLOCK2_50 , CLOCK_27;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS;
	inout logic [35:0] GPIO_0;
	
	// Audio
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	
	// Local wires.
	logic read_ready, write_ready, read, write;
	logic [23:0] readdata_left, readdata_right;
	logic [23:0] writedata_left, writedata_right;

	assign read = read_ready && write_ready;
	assign write = write_ready && read_ready;

	//GPIO for winner
	assign GPIO_0[33:0] = 34'd0;
	assign GPIO_0[35] = (winner == 2'd1);
	assign GPIO_0[34] = (winner == 2'd2);
	
	// for keyboard
	inout PS2_CLK;
	inout PS2_DAT;
	
	// Location of pixel to draw
	logic [10:0] x;
	logic [10:0] y;
	// Bats locations
	logic [10:0] p1_y;
	logic [10:0] p2_y;
	// Ball location
	logic [10:0] ball_x;
	logic [10:0] ball_y;
	// Scores and winner
	logic [3:0] p1_score;
	logic [3:0] p2_score;
	logic collision;
	logic [1:0] winner;				// 0 = none, 1 = P1, 2 = P2
	
	logic canDraw, ball_on, start;
	assign VGA_CLK = CLOCK_50;
	assign VGA_SYNC_N = 0;
	
	keyboard_press_driver keytest(
		.CLOCK_50(CLOCK_50), 
		.valid(valid), 
		.makeBreak(makeBreak),
		.outCode(outCode),
		.PS2_DAT(PS2_DAT), 
		.PS2_CLK(PS2_CLK), 
		.reset(SW[9]));
		
	logic [7:0] outCode;
	logic makeBreak, valid;
	
	logic [7:0] out_history [1:2];
	always_ff @(posedge makeBreak)
	begin	
		out_history[2] <= out_history[1];
		out_history[1] <= outCode;
	end
	
	vga draw (.clk(CLOCK_50), .vsync(VGA_VS), .hsync(VGA_HS), .x, .y, .canDraw, .start_of_frame(start)); 
	
	colors g(.clk(CLOCK_50), .canDraw, .x, .y, .p1_y, .p2_y, .ball_on,
		.ball_x, .ball_y, .red(VGA_R), .green(VGA_G), .blue(VGA_B), .vga_blank(VGA_BLANK_N));
				
	gamelogic gl(.clk(CLOCK_27), .start, .reset(SW[9]),
		.p1_up(~KEY[3]),//((out_history[1] == 'h1d) && (out_history[2][7:4] != 'hF)),		// later change it to 'W' from keyboard
		.p1_down(~KEY[2]),//((out_history[1] == 'h1b) && (out_history[2][7:4] != 'hF)),	// later change it to 'S' from keyboard
		.p2_up(~KEY[1]), .p2_down(~KEY[0]),
		.p1_y, .p2_y, .ball_on, .ball_x, .ball_y, .p1_score, .p2_score, .winner, .collision);
		
	soundstore playsound (.clk(CLOCK_50), .enable(write_ready && read_ready), .start_read(collision), .start_write(SW[8]),
								  .input_left(readdata_left), .input_right(readdata_right), 
								  .output_left(writedata_left), .output_right(writedata_right));
			
	// score and winner display
	seg7 p1 (.z(p1_score), .d(HEX0));
	assign HEX1 = 7'b1111111;
	seg7 p2 (.z(p2_score), .d(HEX2));
	assign HEX3 = 7'b1111111;
	score win (.p1_score, .p2_score, .winner, .HEX4, .HEX5);
	
	/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);
	
endmodule


