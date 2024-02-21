
class Multp2;
        rand bit [3:0] urand;
        constraint mult2const {urand inside {1,2,4,8,16};}
endclass

module tb;
	parameter sample = 10000;
	logic clock, nreset, type_wave;
	logic [3:0] inp_freq;
	Multp2 m2_rand = new ( );
	logic signed [15:0] wave_out;
	logic [$clog2(sample):0] count;

	waves_generator#(.N_SAMPLES(200), .WIDTH(16))gen_waves(
					.clock		(	clock		),
					.nreset		(	nreset		),
					.type_wave	(	type_wave	),
					.inp_freq	(	inp_freq	),
					.wave_out	(	wave_out	)
	);
	initial begin clock = 0;
		      inp_freq =1;
		      count = 0;
		      nreset = 0;
		      type_wave = 0;
		      #1
		      nreset = 1;
		      #500000
		      type_wave = 1;

		     
	end	
	always #1 clock = ~clock;
        always @(posedge clock)begin
                count <= count >= sample ? 0:count + 1;

                void'(m2_rand.randomize());
                inp_freq = count < sample  ? inp_freq : m2_rand.urand;

        end
	initial #1000000 $finish;
endmodule
