# %%
import pyfirmata
import time
import random
board = pyfirmata.Arduino('COM7')

# %%
#function to deliver a training trial

def train(cs_dur = 2, us_dur = 0.01, isi = 0.5, cs_pin = 10, us_pin = 13):
    
    board.digital[cs_pin].write(1)
    time.sleep(cs_dur * isi)
    board.digital[us_pin].write(1)
    time.sleep(us_dur)
    board.digital[us_pin].write(0)
    time.sleep(cs_dur * isi - us_dur)
    board.digital[cs_pin].write(0)

# %%
#function to deliver cs

def cs(cs_dur = 2, cs_pin = 10):
    
    board.digital[cs_pin].write(1)
    time.sleep(cs_dur)
    board.digital[cs_pin].write(0)

# %%
#function to deliver us

def us(us_dur = 0.01, us_pin = 10):
    
    board.digital[us_pin].write(1)
    time.sleep(us_dur)
    board.digital[us_pin].write(0)

# %%
#function to generate timing

def generate_timing(pre_cs = 10, pre_us = 10, training = 100, 
                    min_iti = 45, max_iti = 75, control = False):

    timing=[]
    
    for i in range(0, pre_cs + pre_us):
        timing.append(random.random() * (max_iti - min_iti) + min_iti)
        
    if control:
        for i in range(0, training * 2):
            timing.append(timing[len(timing) - 1] + random.random() * (min_iti + max_iti) / 2)
    else:
        for i in range(0, training):
            timing.append(random.random() * (max_iti - min_iti) + min_iti)
        
    return(timing)

# %%
def generate_probe(probe, training, pre_cs, pre_us):
    
    probe_trials = random.sample(range(pre_cs + pre_us, pre_cs + pre_us + training - 1), probe)
    return(probe_trials)
    