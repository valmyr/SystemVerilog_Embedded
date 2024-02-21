import numpy as np
from matplotlib import pyplot as plt

start = 0;
sample = 100;

frequency = 1
stop = 1/frequency
x = np.linspace(start,stop,sample)
y = np.sin(2*np.pi*frequency*x)*128
y = [int(y[i]) for i in range(len(y))]
plt.stem(x,y)

tab_files = open('waves.txt','w')

for j in y:
    i = -1*j
    len_str = len(bin(i)[2:])
    if(i > 0):
        strg = f'{"0"*(8-len_str)}{ bin(i)[2:]}'
    else:
        strg = f'1{"0"*(8-len_str)}{ bin(i)[3:]}'
    print(strg)
    tab_files.write(f'{strg[1:]}\n')
