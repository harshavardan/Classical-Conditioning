//////////////////////////////////////////////////////////////////////

/* Classical conditioning with light as cs and shock as us. 
 A number of cs and us can be given to establish baseline 
 responses before training begins. During training, the cs 
 goes on and the us can be delivered anywhere within the cs.
 Probe trials can be randomly delivered during training. 
 Finally, cs-only test trials are given to extinguish learning.*/

//////////////////////////////////////////////////////////////////////

import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

//fish information

String genotype = "Indian Wild Type";
String dpf = "6";
String fish = "F1_2";
String batch_id = "2";
String file_path = "../../data/" + generate_date() + "/" + fish + "/";

//debugging

int scaling = 1; //factor to scale down times during debugging

//randomization of ITIs

boolean random = true; //are ITIs randomized?
float min = 20000 / scaling; //max ITI allowed
float max = 30000 / scaling; //min ITI allowed
long iti = 10000 / scaling; //ITI if not randomized

//timing of the experiment

int baseline = 5000 / scaling; //how long to wait after sending OSC message to Bonsai to deliver the stimulus?
int init_delay = 30000 / scaling; //initial delay
int no_pre_cs = 50;
int no_pre_us = 100;
int no_training = 100;
int no_test = 5;
int no_probe = 0; //number of probe trials interspersed in the training trials
long wait = 60000 / scaling; //wait period before test trials

//cs and us parameters

int cs_dur = 2000 / scaling; //time of cs on in milli seconds
int us_dur = 25/ scaling; //time of bright flash
float us_pos = (cs_dur - us_dur)  * 1.0/ cs_dur; //position of the us within the cs
int cs_pin = 8;
int cs_trigger_pin = 3;
int us_pin = 12;
int us_trigger_pin = 2;
String light_intensity = "not measured"; //mW/cm2
String current = "max"; //mA
