module tb;
	parameter WIDTH = 10;
	logic clock;
	logic nreset;
	logic [WIDTH-1:0]Tx;
	logic [1:0]SerialData;
	SPDIF_Transmitter #(.WIDTH(WIDTH))SPDIF_U1(.*);
	
	always #1 clock = ~clock;

	initial begin
		nreset = 0; 
		clock  = 0;
		#1
		nreset = 1;
	//	Tx = 11'b01001100011;
		Tx = 9'b111010001;
		# 30 $finish;
	end
endmodule
