//debugging

int scaling = 1; //factor to scale down times during debugging

//randomization of ITIs
boolean random = true; //are ITIs randomised?
float max = 5000; //max ITI allowed
float min = 10000; //min ITI allowed
long iti = 30000 / scaling; //interval between training trials

//structure of the experiment

int init_delay = 10000 / scaling; //initial delay
int no_pre_cs = 0;
int no_pre_us = 10;
int no_training = 0;
int no_test = 0;
int no_probe = 0; //number of probe trials interspersed in the training trials
long wait = 10000 / scaling; //wait period before test trials

//cs and us parameters

int cs_dur = 2000 / scaling; //time of cs on in milli seconds
int us_dur = 5000/ scaling; //time of bright flash
float us_pos = 0.5; //position of the us relative to the cs
int cs_pin = 2;
int us_pin = 13;
String current = "3mA";


//others

float[] structure = new float[no_pre_cs + no_pre_us + no_training + no_test]; //stores timing information of the stimuli
int stimulus_count = 0; //counts the number of stimuli given
int[] probe = new int[no_probe]; //positions of probe trials
int cs = 0; //status of cs
String[] trial = {
}; // holds whether a particular trial is precs or preus or whatever
int us = 0; // has the us been delivered in a particular trial?
int triggered = 0; //has Bonsai been triggered yet?
int entered = 0; //
String[] probe_str = {
};
int index = 0;
long previous_time = 0;
boolean init = false; // have the files to be written initialised?
