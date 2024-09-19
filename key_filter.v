//the default system clock is 50Mhz (50 million cycles per second), each clock cycle lasts for (1/50 million seconds) or 20 ns.
//there are 1,000,000 20 ns(clock cycles) in 20 ms.
//since in degital design, counters start from 0, not 1. So to count 1,000,000 clock cycles will counter from 0 to 999_999
module key_filter_top #(parameter CNT_MAX = 20'd999_999)(
	input wire sys_clk,
	input wire sys_rst_n,
	input wire key_in,
	
	output reg key_flag
);

reg [19:0] cnt_20ms; //a 20 bits register, used as a counter to count how time the press lasts

always@(posedge sys_clk or negedge sys_rst_n)  
	if(sys_rst_n == 1'b0)
		cnt_20ms <= 20'b0; //if reset is active low, then reset the counter
	else if(key_in == 1'b1)
		cnt_20ms <= 20'b0; //if keyin = 1, which means that the button hasn't been preseed, reset the counter
	else if(cnt_20ms == CNT_MAX && key_in == 1'b0)
		cnt_20ms <= cnt_20ms; //if cnt_20ms reaches 20ms
	else 
		cnt_20ms <= cnt_20ms + 1'b1;

always @(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0) //if reset is active low, then clear the flag
		key_flag <= 1'b0;
	else if(cnt_20ms == CNT_MAX - 1'b1) //ensure that key_flag is set to 1 at exact one cycle before the counter reaches 999999;
		key_flag <= 1'b1;
	else 
		key_flag <= 1'b0;
		
endmodule
	