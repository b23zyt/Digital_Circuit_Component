`timescale 1ns/1ns 
module tb_key_filter();

parameter	CNT_1MS = 20'd19,
			CNT_11MS = 20'd69,
			CNT_41MS = 20'd149,
			CNT_51MS = 20'd199,
			CNT_60MS = 20'd249;
			
wire key_flag;

reg sys_clk;
reg sys_rst_n;
reg key_in;
reg [21:0] tb_cnt;

initial begin 
	sys_clk = 1'b1;
	sys_rst_n <= 1'b0;
	key_in <= 1'b0;
	#20
	sys_rst_n <= 1'b1;
end

always #10 sys_clk = ~sys_clk;

always@(posedge sys_clk or negedge sys_rst_n) 
	if(sys_rst_n == 1'b0)
		tb_cnt <= 22'b0;
	else if(tb_cnt == CNT_60MS)
		tb_cnt <= 20'b0;
	else 
		tb_cnt <= tb_cnt + 1'b1;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		key_in <= 1'b1;
	else if ((tb_cnt >= CNT_1MS && tb_cnt <= CNT_11MS) || (tb_cnt >= CNT_41MS && tb_cnt <= CNT_60MS))
		key_in <= {$random} % 2; //in this interval, generate a random number between 0 to mock the unstable shakings of the button
	else if (tb_cnt >= CNT_11MS && tb_cnt <= CNT_41MS)
		key_in <= 1'b0;
	else 
		key_in <= 1'b1;
		
key_filter_top #(.CNT_MAX(20'd24)) key_filter_inst (
	.sys_clk(sys_clk),
	.sys_rst_n(sys_rst_n),
	.key_in(key_in),
	.key_flag(key_flag)
);

endmodule

