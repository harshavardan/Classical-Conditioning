//others

float[] timing = new float[no_pre_cs + no_pre_us + no_training + no_test]; //stores timing information of the stimuli
int stimulus_count = 0; //counts the number of stimuli given
int[] probe = new int[no_probe]; //positions of probe trials
int cs = 0; //status of cs
String[] trial = {}; // holds whether a particular trial is precs or preus or whatever
int us = 0; // has the us been delivered in a particular trial?
int triggered = 0; //has Bonsai been triggered yet?
int entered = 0; //
String[] probe_str = {};
int index = 0;
long previous_time = 0;
boolean init = false; // have the files to be written initialised?
