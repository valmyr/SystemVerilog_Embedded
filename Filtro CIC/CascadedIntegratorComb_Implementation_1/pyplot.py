from math import pi
import numpy as np
import matplotlib.pyplot as plt
import os
sample_rate =120 #1khz
start_time =0 #0s
end_time = 2 #10s

time = np.arange(start_time,end_time,1/sample_rate)

theta = 0

x_in = []
y_out =[]
with open("./input2_t.txt") as inp:
    for i in inp:
        x_in.append(int(i,16))
x_in = x_in[0:len(time)-1]
print((x_in))

with open("./output.txt") as outp:
    try:
        for i in outp:
            if(int(i,16) == 0):
                y_out.append("Nan")
            else:
                y_out.append((int(i,16)))
    except ValueError:
        print("tratamento de exc")
y_out = y_out[0:len(time)-1]
print((y_out))
plt.subplot(3,1,1)
plt.title("Input")
plt.xlabel("n")
plt.ylabel("x(n)")
plt.stem(time[0:len(time)-1],x_in, markerfmt = '^')
plt.subplot(3,1,2)
plt.title("Output")
plt.xlabel("n")
plt.ylabel("y(n)")
plt.stem(time[0:len(time)-1],y_out,'r', markerfmt = 'r^')
plt.subplot(3,1,3)
plt.stem(time[0:len(time)-1],x_in,markerfmt = '^')
plt.stem(time[0:len(time)-1],y_out,'r', markerfmt = 'r^')
plt.legend(["x(n)","y(n)"])
plt.xlabel("n")
plt.ylabel("x(n) e y(n)")
plt.show()

