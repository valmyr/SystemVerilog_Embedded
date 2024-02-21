database -open waves -into waves.shm -default
probe -create -shm addr1.clk addr1.a addr1.b addr1.s2 -waveform
reset
run
