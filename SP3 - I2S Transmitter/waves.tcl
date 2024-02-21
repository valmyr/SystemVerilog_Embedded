base -open waves -into waves.shm -default
probe -create -shm U1.transmitterU1.SCLK -waveform
probe -create -shm U1.transmitterU1.nreset -waveform
probe -create -shm U1.transmitterU1.next_state -waveform
probe -create -shm U1.transmitterU1.current_state -waveform
probe -create -shm U1.transmitterU1.bit_counter -waveform

probe -create -shm U1.transmitterU1.ready -waveform
probe -create -shm U1.transmitterU1.LRCLK -waveform
probe -create -shm U1.transmitterU1.Tx_int -waveform 
probe -create -shm U1.transmitterU1.SD_int -waveform
reset
run

