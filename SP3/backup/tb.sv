module tb;
	logic MCLK,nreset,SCLK,LRCLK,SD;

	I2Smodule #(.WIDTH(8), .RATIO(4)) U1(.*);

	initial begin
		MCLK = 0;
		nreset = 0;
		#1 nreset =1 ;
		#10000 $finish;
		

	end
	always #1 MCLK = ~MCLK;

endmodule
