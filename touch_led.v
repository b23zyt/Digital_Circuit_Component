module touch_led_top 
(
	input wire sys_clk,
	input wire sys_rst_n,
	input wire touch_key,
	output reg led
);

reg dly1;
reg dly2;

wire touch_en;

assign touch_en = dly2 & (~dly1);

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		begin 
			dly1 <= 1'b0;
			dly2 <= 1'b0;
		end
	else
		begin
			dly1 <= touch_key;
			dly2 <= dly1;
		end

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		led <= 1'b1;
	else if(touch_en == 1'b1)
		led <= ~led;
endmodule
	