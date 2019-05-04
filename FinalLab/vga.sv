module vga (clk, vsync, hsync, x, y, canDraw, start_of_frame); 
	
	integer ha = 192;	// duration of pulse to VGA_HSYNC signifying end of row of data
	integer hb = 96;		// back porch
	integer hc = 1280;		// horizontal screen size (px)
	integer hd = 32;	// front porch

	integer va = 2;		// duration of pulse to VGA_HSYNC signifying end of row of data
	integer vb = 33;	// back porch
	integer vc = 480;		// vertical screen size (px)
	integer vd = 10;		// front porch
	
	input clk;
	output vsync, hsync;
	output [10:0] x, y;
	output canDraw;
	output start_of_frame;

	assign x = h - ha - hb;
	assign y = v - va - vb;
	assign canDraw = (h >= (ha + hb)) && (h < (ha + hb + hc))
				   && (v >= (va + vb)) && (v < (va + vb + vc));
	assign vsync = vga_vsync;
	assign hsync = vga_hsync;
	assign start_of_frame = startframe;

	// horizontal and vertical counts
	logic [10:0] h;
	logic [10:0] v;
	logic vga_vsync;
	logic vga_hsync;
	logic startframe;
	
	always_ff @(posedge clk) begin
	    // if we are not at the end of a row, increment h
		if (h < (ha + hb + hc + hd)) begin
			h <= h + 11'd1;
		// otherwise set h = 0 and increment v (unless we are at the bottom of the screen)
		end else begin
			h <= 11'd0;
			v <= (v < (va + vb + vc + vd)) ? v + 11'd1 : 11'd0;
		end
		vga_hsync <= h > ha;
		vga_vsync <= v > va;
		
		startframe <= (h == 11'd0) && (v == 11'd0);
	end
endmodule