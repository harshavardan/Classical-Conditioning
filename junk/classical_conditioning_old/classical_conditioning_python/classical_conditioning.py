import pyfirmata
import time
import serial
import import_ipynb
import functions
import random
import argparse
import matplotlib.pyplot as plt
from pythonosc import udp_client
import csv


#board = pyfirmata.Arduino('COM7')
init_time = time.time()

#fish info

genotype = "ind_wt"
age = 7
fish_id = "F1"
control = False #is it a randomized control experiment?

#parameters

scaling = 1 #used for troubleshooting

cs_dur = 4 / scaling #seconds
us_dur = 0.01 #seconds
isi = 0.5 #position of us within cs
min_iti = 10 / scaling #seconds
max_iti = 15 / scaling #seconds
init_delay = 5 / scaling #seconds
pre_cs = 10
pre_us = 0
training = 0
probe = 0
no_trials = pre_cs + pre_us + training
cs_pin = 13
us_pin = 10

# %%
#saving stuff

data = [["pre_cs_times", "pre_us_times", "training_times"],[],[],[]]

# %%
time.sleep(init_delay)
print(time.time() - init_time)

timing = functions.generate_timing(pre_cs, pre_us, training, min_iti, max_iti, control)

#pre training responses to CS

for i in range(0, pre_cs):
    time.sleep(timing[i])
    data[1].append(float(time.time() - init_time))
    functions.cs(cs_dur, cs_pin)
    data[1].append(float(time.time() - init_time))
    print(time.time() - init_time)
    
#pre training responses to US

for i in range(pre_cs, pre_cs + pre_us):
    time.sleep(timing[i])
    data[2].append(float(time.time() - init_time))
    functions.us(us_dur, us_pin)
    data[2].append(float(time.time() - init_time))
    print(time.time() - init_time)
    
#training or control protocol

probe_trials = functions.generate_probe(probe, training, pre_cs, pre_us)

for i in range(pre_cs + pre_us, no_trials):
    if control:
        if random.random(0, 1) == 0:
            time.sleep(timing[i])
            data[3].append(float(time.time() - init_time))
            functions.cs(cs_dur, cs_pin)
            data[3].append(float(time.time() - init_time))
            print(time.time() - init_time)
        else:
            time.sleep(timing[i])
            data[3].append(float(time.time() - init_time))
            functions.us(us_dur, us_pin)
            data[3].append(float(time.time() - init_time))
            print(time.time() - init_time)
    else:
        if i in probe_trials:
            time.sleep(timing[i])
            data[3].append(float(time.time() - init_time))
            functions.cs(cs_dur, cs_pin)
            data[3].append(float(time.time() - init_time))
            print(time.time() - init_time)
            continue
        else:
            time.sleep(timing[i])
            data[3].append(float(time.time() - init_time))
            functions.train(cs_dur, us_dur, isi, cs_pin, us_pin)
            data[3].append(float(time.time() - init_time))
            print(time.time() - init_time)

# %%
#writing stuff

for i in range(0, len(data[0])):
    with open(data[0][i] + ".csv", 'w') as myfile:
        write = csv.writer(myfile, quoting=csv.QUOTE_ALL)
        write.writerow(data[i + 1])

# %%
(data[1][5] - data[1][4]) * 1000

# %%
