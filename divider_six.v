module divider_six_top(
	input wire sys_clk,
	input wire sys_rst_n,
	output reg clk_flag
);

reg [2:0] cnt; //used to count toward 5 (0,1,2,3,4,5)
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt <= 3'b0;
	else if(cnt == 3'b101)
		cnt <= 3'b0;
	else 
		cnt <= cnt + 1'b1;

always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		clk_flag <= 1'b0;
	else if (cnt == 3'b101)
		clk_flag <= 1'b1;
	else 
		clk_flag <= 1'b0;

endmodule
		



//use the above code as a component to achieve a six divider:
//Here's an example: clk_flag is used as a trigger indicator, it trigger A to change at every 6 cycles.
// always@(posedge sys_clk or negedge sys_rst_n)
	// if(sys_rst_n == 1'b0)
		// A <= 4'b0;
	// else if(clk_flag == 1'b1) 
		// A <= A + 1'b1;