import numpy as np
from matplotlib import pyplot as plt

def gerator_sawtooth_waveform(t,frequency,amplitude):
    accum = 0
    y =[]
    num_harm = 1000
    for i in range(len(t)):    
        accum = 0
        for k in range(1,num_harm):
            accum+=(pow(-1,k)*np.sin(2*np.pi*k*frequency*t[i]))/k
        y.append(accum*amplitude*2/np.pi)
    return y
def gerator_sine_tooth_waveform(t,frequency,amplitude):
    return amplitude*np.sin(2*np.pi*frequency*t)
def gerator_triangular_waveform(t,frequency,Amplitude):
    accum = 0
    y =[]
    num_harm = 1000
    for i in range(len(t)):
        accum = 0
        for k in range(1,num_harm):
            accum+=(-1)**(k+1)*np.sin(2*np.pi*k*t[i]*frequency)/k
        y.append(accum*amplitude*2/np.pi)

    return y
start = 0
frequency = 1000;
period = 1/frequency
Np = 1
stop = Np*period
amplitude = 128
t = np.linspace(start,stop,200)



plt.subplot(3,1,1)
y0 = gerator_sawtooth_waveform(t,frequency,amplitude)
plt.stem(t,y0)
plt.subplot(3,1,2)
y1 = gerator_sine_tooth_waveform(t,frequency,amplitude)
plt.stem(t,y1)

y0 = [int(y0[i]) for i in range(len(y0))]
y1 = [int(y1[i]) for i in range(len(y0))]



'''
plt.subplot(3,1,3)
y = gerator_triangular_waveform(t,frequency,amplitude)
plt.plot(t,y)'''

#plt.show()

tab_files0 = open("sin_wave.txt",'w')
tab_files1 = open("sawtooth_wave.txt",'w')

for j in range(len(y0)):

    len_str0 = len(bin(y0[j])[2:])
    len_str1 = len(bin(y1[j])[2:])
    if(y0[j] >= 0):
        strg0 = f'{"0"*(16-len_str0)}{ bin(y0[j])[2:]}'
    else:
        strg0 = f'1{"0"*(16-len_str0)}{ bin(y0[j])[3:]}'
        
        str_v = ''
        for i in range(len(strg0)):
            if(strg0[i] == '1'):
                str_v += '0'
            else:
                str_v+='1'
        
        strg0=bin(int(str_v,2)+1)[2:]
        strg0= '1'*(16-len(strg0))+strg0


    if(y1[j] >= 0):
        strg1 = f'{"0"*(16-len_str1)}{ bin(y1[j])[2:]}'
    else:
        strg1 = f'1{"0"*(16-len_str1)}{ bin(y1[j])[3:]}'
        print(strg1)
        str_v = ''
        for i in range(len(strg1)):
            if(strg1[i] == '1'):
                str_v += '0'
            else:
                str_v+='1'
        strg1=bin(int(str_v,2)+1)[2:]
        strg1= '1'*(16-len(strg1))+strg1


    tab_files0.write(f'{strg0}\n')
    tab_files1.write(f'{strg1}\n')
