module counter_zeros(
	input logic ena,
	input logic [23:0] in,
	output logic [5:0] zeros
);
	always_comb
	if(ena)
		  
	 casex(in)
		24'b000000000000000000000000: zeros = 24;
		24'b00000000000000000000000x: zeros = 23;
		24'b0000000000000000000000xx: zeros = 22;
		24'b000000000000000000000xxx: zeros = 21;
		24'b00000000000000000000xxxx: zeros = 20;
		24'b0000000000000000000xxxxx: zeros = 19;
		24'b000000000000000000xxxxxx: zeros = 18;
		24'b00000000000000000xxxxxxx: zeros = 17;
		24'b0000000000000000xxxxxxxx: zeros = 16;
		24'b000000000000000xxxxxxxxx: zeros = 15;
		24'b00000000000000xxxxxxxxxx: zeros = 14;
		24'b0000000000000xxxxxxxxxxx: zeros = 13;
		24'b000000000000xxxxxxxxxxxx: zeros = 12;
		24'b00000000000xxxxxxxxxxxxx: zeros = 11;
		24'b0000000000xxxxxxxxxxxxxx: zeros = 10;
		24'b000000000xxxxxxxxxxxxxxx: zeros = 9;
		24'b00000000xxxxxxxxxxxxxxxx: zeros = 8;
		24'b0000000xxxxxxxxxxxxxxxxx: zeros = 7;
		24'b000000xxxxxxxxxxxxxxxxxx: zeros = 6;
		24'b00000xxxxxxxxxxxxxxxxxxx: zeros = 5;
		24'b0000xxxxxxxxxxxxxxxxxxxx: zeros = 4;
		24'b000xxxxxxxxxxxxxxxxxxxxx: zeros = 3;
		24'b00xxxxxxxxxxxxxxxxxxxxxx: zeros = 2;
		24'b0xxxxxxxxxxxxxxxxxxxxxxx: zeros = 1;
		default: zeros = 0;
		
 	 endcase 
	else zeros = 0;
endmodule
