base -open waves -into waves.shm -default
probe -create -shm SPDIF_U1.*


simvision -input simvision.svcf

reset
run

