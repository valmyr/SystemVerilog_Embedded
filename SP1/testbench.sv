`include "./frequency_generator.sv"

class Multp2;
	rand bit [3:0] urand;
	constraint mult2const {urand inside {1,2,4,8,16};}
endclass
module tb;
	logic clock, nreset, freq_out;
	logic [3:0] inp_freq;
	frequency_generator freq_gen(	.clock		(	clock		),	
					.nreset		(	nreset		),
					.inp_freq	(	inp_freq	),
					.freq_out	(	freq_out	)	
				);
	logic [5:0] count;
	always #1 clock = ~clock;
	
	initial begin 
	   count = 0;
		   inp_freq =1;
	       	   nreset = 0;
                #1 nreset = 1;
		clock = 0;
		#10000 $finish;
	end

	Multp2 m2_rand = new ( );

	always @(posedge clock)begin 	
		count <= count + 1;	
		m2_rand.randomize();
		inp_freq = count ? inp_freq : m2_rand.urand;
	end

endmodule
