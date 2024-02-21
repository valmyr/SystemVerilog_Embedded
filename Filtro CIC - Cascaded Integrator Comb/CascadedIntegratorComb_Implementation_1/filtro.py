from math import pi
import numpy as np
import matplotlib.pyplot as plt
import os 
sample_rate =120 #1khz
start_time = 0 #0s
end_time = 2 #10s

time = np.arange(start_time,end_time,1/sample_rate)

theta = 0


def main():
    print("[1] - Senoidal")
    print("[2] - impulso")
    print("[3] - Arbitrária")

    op = int(input(">>"))

    if(op == 1):
        wave = senoidal(time)
    elif(op == 2):
        wave = impulso(time)
    elif(op == 3):
        wave = arbitraria(time)
    else: 
        print("Entrada indefinida")
        main()
    sinwave_int = []
    with open("input2_t.txt",'w') as txt:
        for i in wave:
            txt.write(hex(int(np.ceil(i)))[2:]+'\n')
            #print(i)
           #print((int((i))))
           # txt.write(str(i))
           #txt.write(f'{str(bin(int(i)))[2:]}\n')
            #sinwave_int.append(int(np.ceil(i)))

def senoidal(time):
    amplitude = 10
    offset = 10
    frequency = 3
    offsetvec = np.ones(len(time))*20
    sinwave = amplitude*np.cos(2*np.pi*frequency*time)+offsetvec
    return sinwave
def arbitraria(time):
    frequency = [3,5,2,1,10]
    amplitude = [10, -2,7,3,.6]
    offset = sum(amplitude)
    sinwave = np.zeros(len(time))
    for i in range(len(amplitude)):
        sinwave +=5 + amplitude[i]*(np.sin(2*np.pi*frequency[i]*time+theta))
    return sinwave
def impulso(time):
    impulso_out = np.zeros(len(time))
    impulso_out[0] = 100
    return impulso_out;
                
def dec2hex(y):
    y_hex = []
    for i in range(len(y)):
        y_hex.append(hex(int(np.ceil(y[i])[2:])))
    return y_hex;
main()
#plt.subplot(5,1,1)
#plt.plot(time,sinwave)
#plt.subplot(2,1,1)
#plt.stem(time,sinwave)
#SINWAVE = np.fft.fft(sinwave)
#plt.subplot(5,1,3)
#freq = np.fft.fftfreq(sample_rate)
#plt.stem(freq, abs(SINWAVE))
#sinwave_int = []
#with open("input2_t.txt",'w') as txt:
#    for i in wave:
       # print((int((i))))
#        txt.write(hex(int(np.ceil(i)))[2:]+'\n')
       # txt.write(f'{str(bin(int(i)))[2:]}\n')
        
#        sinwave_int.append(int(np.ceil(i)))
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
