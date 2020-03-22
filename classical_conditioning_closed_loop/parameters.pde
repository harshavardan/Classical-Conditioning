///////////////////Classical Conditioning/////////////////////////////
  
int scaling = 1; //factor to scale down times for checking and debugging
int cs_duration = 2000 / scaling; //time of led on in milli seconds
int index = 0;
long previous_time = 0;
int us_duration = 500/ scaling; //time of bright flash
int no_pre_CS = 2;
int no_pre_US = 2;
int no_training = 10;
int no_test = 2;
int no_probe = 2; //number of probe trials interspersed in the training trials
long isi = 10000 / scaling; //interval between training trials
long wait = 10000 / scaling; //wait period before test trials
float[] structure = new float[no_pre_CS + no_pre_US + no_training + no_test]; //stores timing information of the stimuli
int stimulus_count = 0; //counts the number of stimuli given
int init_delay = 10000 / scaling; //initial delay
int[] probe = new int[no_probe]; //positions of probe trials
int led = 0; //status of led
String[] trial = {}; // holds whether a particular trial is preCS or preUS or whatever
float US_pos = 0.5; //position of the US relative to the CS
int US = 0; // has the US been delivered in a particular trial?
int triggered = 0; //has Bonsai been triggered yet?
int entered = 0; //
String[] probe_str = {};
int blah = 0; //trying to see how fast draw loops over

//////////////////////////////////////////////////////////////////////
