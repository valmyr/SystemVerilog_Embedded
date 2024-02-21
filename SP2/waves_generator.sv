`include "../SP1/frequency_generator.sv"
module waves_generator#(parameter N_SAMPLES = 100, WIDTH = 16)(input logic clock, nreset, type_wave,input logic[3:0] inp_freq, output logic signed [WIDTH-1:0] wave_out);
	
	logic[$clog2(N_SAMPLES)-1:0] counter;
	logic signed [WIDTH-1:0] sin_mem [N_SAMPLES-1:0];
	logic signed [WIDTH-1:0] sawtooth_mem  [N_SAMPLES-1:0];

	
	frequency_generator freq_gen0(
					.nreset		(	nreset		),
					.clock		(	clock		),
					.inp_freq	(	inp_freq	),
					.freq_out	(	clock_fgen	)
	);

	initial begin 
		      $readmemb("sin_wave.txt",sin_mem);
		      $readmemb("sawtooth_wave.txt",sawtooth_mem);	
	end

	always_ff@(posedge clock_fgen, negedge nreset) counter <= (N_SAMPLES-1 == counter) || !nreset ? 0 : counter + 1;
	assign wave_out = type_wave ?  sin_mem[counter] : sawtooth_mem[counter];
endmodule
