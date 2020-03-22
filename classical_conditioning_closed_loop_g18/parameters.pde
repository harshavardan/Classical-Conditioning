///////////////////Classical Conditioning/////////////////////////////

//debugging

int scaling = 1; //factor to scale down times during debugging

//randomization of ITIs
boolean random = false; //are ITIs randomised?
float max = 1.25; //max ITI allowed
float min = 0.75; //min ITI allowed

//structure of the experiment

int init_delay = 30000 / scaling; //initial delay
int no_pre_CS = 10;
int no_pre_US = 10;
int no_training = 20;
int no_test = 10;
int no_probe = 5; //number of probe trials interspersed in the training trials
long wait = 30000 / scaling; //wait period before test trials

//CS and US parameters

int CS_dur = 2000 / scaling; //time of led on in milli seconds
int US_dur = 50/ scaling; //time of bright flash
long iti = 30000 / scaling; //interval between training trials
float US_pos = 0.5; //position of the US relative to the CS

//others

float[] structure = new float[no_pre_CS + no_pre_US + no_training + no_test]; //stores timing information of the stimuli
int stimulus_count = 0; //counts the number of stimuli given
int[] probe = new int[no_probe]; //positions of probe trials
int led = 0; //status of led
String[] trial = {}; // holds whether a particular trial is preCS or preUS or whatever
int US = 0; // has the US been delivered in a particular trial?
int triggered = 0; //has Bonsai been triggered yet?
int entered = 0; //
String[] probe_str = {};
int index = 0;
long previous_time = 0;

//////////////////////////////////////////////////////////////////////
