base -open waves -into waves.shm -default
probe -create -shm U1.transmitterU1.* -waveform
probe -create -shm U1.* -waveform
reset
run

