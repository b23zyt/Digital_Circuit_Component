module water_led0_top
#(
	parameter CNT_MAX = 25'd24_999_999
)
(
	input wire sys_clk,
	input wire sys_rst_n,
	output wire [3:0] led_out
);

reg [24:0] cnt;
reg	cnt_flag; // a signal that indicate cnt reaches max, active high at exactly 1 clk cycle in advance
reg [3:0] led_out_reg; //a 4-bit register, control the 4 leds, only one led is working at every time

//signal for counting 0.5s
always@(posedge sys_clk or negedge sys_rst_n)
	begin
		if(sys_rst_n == 1'b0)
			cnt <= 25'd0;
		else if(cnt == CNT_MAX)
			cnt <= 25'd0; //clear the counter if it reaches 0.5s
		else 
			cnt <= cnt + 1'b1;
	end


always@(posedge sys_clk or negedge sys_rst_n)
	begin
		if(sys_rst_n == 1'b0)
			cnt_flag <= 1'b0;
		else if(cnt == CNT_MAX - 1'b1)
			cnt_flag <= 1'b1;
		else	
			cnt_flag <= 1'b0;
	end

//water led
always@(posedge sys_clk or negedge sys_rst_n)
	begin
		if(sys_rst_n == 1'b0)
			led_out_reg <= 4'b0001; //active the first led when reseting
		else if (led_out_reg == 4'b1000 && cnt_flag == 1'b1)
			led_out_reg <= 4'b0001; //when the fourth led is active, return back to the first
		else if (cnt_flag == 1'b1)
			led_out_reg <= led_out_reg << 1'b1; //left shift
	end

assign led_out = ~led_out_reg; //led is active low
endmodule