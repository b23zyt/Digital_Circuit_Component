`timescale 1ns/1ns

module tb_full_adder();

reg in1;
reg in2;
reg cin;

wire sum;
wire carry;

initial begin
	in1 <= 1'b0;
	in2 <= 1'b0;
	cin <= 1'b0;
end

always #10 in1 <= {$random} % 2;
always #10 in2 <= {$random} % 2;
always #10 cin <= {$random} % 2;

initial begin 
	$timeformat(-9,0,"ns",6);
	$monitor("@time %t:in1=%b in2=%b cin=%b sum=%b count=%b", $time, in1, in2, cin, sum, carry);
	
end

full_adder_top full_adder_inst(
	.in1(in1),
	.in2(in2),
	.carry(cin),
	.output_sum(sum),
	.output_carry(carry)
);

endmodule