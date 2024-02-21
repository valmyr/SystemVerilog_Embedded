base -open waves -into waves.shm -default
probe -create -shm cic1.* -waveform
probe -create -shm cic1.comb0.* -waveform
reset
run

