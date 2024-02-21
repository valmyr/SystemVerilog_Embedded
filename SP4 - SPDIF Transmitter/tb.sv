//`timescale 1ns/1ps

module tb;
	parameter WIDTH =11;

	logic clock;
	logic nreset;
	logic [WIDTH-1:0]Tx;
	logic [1:0]SerialData;
	SPDIF_Transmitter #(.WIDTH(WIDTH))SPDIF_U1(.*);
	
	always #2 clock = ~clock;

	initial begin
		nreset = 0;
	       	clock = 1;
		#0.1	
		nreset = 1;
		Tx = 11'b11110100001;
		# 500 $finish;

	end

	always@(posedge clock)begin

		if(SPDIF_U1.CounterBit == WIDTH-1) Tx = $random%11;
	end

endmodule
