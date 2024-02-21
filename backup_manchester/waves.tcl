base -open waves -into waves.shm -default
probe -create -shm SPDIF_U1.clock -waveform
probe -create -shm SPDIF_U1.SD_internal -waveform
probe -create -shm SPDIF_U1.SerialData -waveform
probe -create -shm SPDIF_U1.Tx -waveform
probe -create -shm SPDIF_U1.CounterWord -waveform
reset
run

