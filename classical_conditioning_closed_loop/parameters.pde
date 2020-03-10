///////////////////Classical Conditioning/////////////////////////////
  
int scaling = 10000; //factor to scale down times for checking and debugging
int led_on = 2000 / scaling; //time of led on in milli seconds
int index = 0;
long previous_time = 0;
int flash_time = 50/ scaling; //time of bright flash
int no_pre_CS = 5;
int no_pre_US = 5;
int no_training = 50;
int no_test = 10;
int no_probe = 5; //number of probe trials interspersed in the training trials
long isi = 120000 / scaling; //interval between training trials
long wait = 120000 / scaling; //wait period before test trials
float[] structure = new float[no_pre_CS + no_pre_US + no_training + no_test]; //stores timing information of the stimuli
int stimulus_count = 0; //counts the number of stimuli given
int init_delay = 100000 / scaling; //initial delay
int[] probe = new int[no_probe]; //positions of probe trials
int led = 0; //status of led
String[] trial = {}; // holds whether a particular trial is preCS or preUS or whatever
float US_pos = 0.5; //position of the US relative to the CS
int US = 0; // has the US been delivered in a particular trial?
int triggered = 0; //has Bonsai been triggered yet?
int entered = 0; //
String[] probe_str = {};

//////////////////////////////////////////////////////////////////////
