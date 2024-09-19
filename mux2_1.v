module mux_top 
(
	input	wire	in1,
	input	wire	in2,
	input 	wire	sel,
	output	reg 	out
);

//method 1
// always@(*) //same as always@(in1, in2, sel)
	// if(sel == 1'b1)
		// out = in1;
	// else 
		// out = in2;

//method 2: out is wire since here is combinational logic
// assign out = (sel == 1'b1) ? in1 :in2;

//method 3:
always@(*)
	case(sel)
		1'b1	:	out = in1;
		1'b0	:	out = in2;
		default	:	out = in1;
	endcase

endmodule