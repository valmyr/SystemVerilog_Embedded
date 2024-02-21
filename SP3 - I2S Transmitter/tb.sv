`include"./I2S_Transmitter.sv"
module tb;
	parameter WIDTH = 8;
	logic SerialData;
	logic [2*WIDTH-1:0] LoadData;
	logic SCK;
	logic nreset;
	logic WS;
	logic Ready;
	I2S_Transmitter #(.WIDTH(WIDTH))transmitter1(
		.*
	);

	initial SCK = 0;
	always #1 SCK = ~SCK;
	initial begin
		nreset = 0;
	      #1nreset = 1;
	       LoadData = 'h8988; 
	       #100$finish;
	end
	always  @(negedge SCK)begin 
		if(transmitter1.WordCounter < 2*WIDTH) $display(SerialData,"	",transmitter1.WordCounter);
		else begin	LoadData = 'hFFFF;
		end
	end
endmodule
