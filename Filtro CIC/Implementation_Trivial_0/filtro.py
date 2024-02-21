from math import pi
import numpy as np
import matplotlib.pyplot as plt
import os 
sample_rate =120 #1khz
start_time = 0 #0s
end_time = 2 #10s

time = np.arange(start_time,end_time,1/sample_rate)

theta = 0


frequency = [3,5,2,1,10]
amplitude = [10, -2,7,3,.6]
#amplitude = [10,0,0,0,0]
sinwave = 0

consvec = np.ones(len(time))*20
for i in range(len(amplitude)):
    sinwave +=5+ ( amplitude[i]*(np.sin(2*np.pi*frequency[i]*time+theta)))
#sinwave = amplitude[0]*np.sin(2*np.pi*frequency[0]*time+theta) + consvec
#plt.subplot(5,1,1)
#plt.plot(time,sinwave)
#plt.subplot(2,1,1)
#plt.stem(time,sinwave)
#SINWAVE = np.fft.fft(sinwave)
#plt.subplot(5,1,3)
#freq = np.fft.fftfreq(sample_rate)
#plt.stem(freq, abs(SINWAVE))
sinwave_int = []
with open("input2_t.txt",'w') as txt:
    for i in sinwave:
       # print((int((i))))
        txt.write(hex(int(np.ceil(i)))[2:]+'\n')
       # txt.write(f'{str(bin(int(i)))[2:]}\n')
        
        sinwave_int.append(int(np.ceil(i)))
#plt.subplot(2,1,1)
#plt.stem(time,sinwave_int)
#plt.show()
'''
sinwave_filter = []
outf = open("output.txt")
for i in outf:
    print(int(i,16))
    if(int(i) == 0):
        sinwave_filter.append(0)
    else:
        sinwave_filter.append(int(i)-5)
plt.subplot(2,1,2)
plt.stem(time[0:99],sinwave_filter)
plt.show()'''
