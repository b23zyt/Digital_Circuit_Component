module full_adder_top(
	input wire in1,
	input wire in2,
	input wire carry,
	output wire output_sum,
	output wire output_carry
);

wire sum_1;
wire carry_1;
wire carry_2;

half_adder half_adder_inst0
(
	.in1(in1),
	.in2(in2),
	.sum(sum_1),
	.carry(carry_1)
);

half_adder half_adder_inst1
(
	.in1(sum_1),
	.in2(carry),
	.sum(output_sum),
	.carry(carry_2)
);

assign output_carry = carry_1 | carry_2;

endmodule
	
