int scaling = 1; //factor to scale down times for checking and debugging
int ledOn = 2000 / scaling; //time of led on in milli seconds
int index = 0;
long previousTime = 0;
int flashTime = 50/ scaling; //time of bright flash
int noPreCS = 5;
int noPreUS = 5;
int noTraining = 50;
int noTest = 10;
int noProbe = 5; //number of probe trials interspersed in the training trials
long isi = 120000 / scaling; //interval between training trials
long wait = 120000 / scaling; //wait period before test trials
float[] structure = new float[noPreCS + noPreUS + noTraining + noTest]; //stores timing information of the stimuli
int stimulusCount = 0; //counts the number of stimuli given
int initDelay = 120000 / scaling; //initial delay
int[] probe = new int[noProbe]; //positions of probe trials
int led = 0; //status of led
String[] trial = {}; // holds whether a particular trial is preCS or preUS or whatever
float USpos = 0.5; //position of the US relative to the CS
int US = 0; // has the US been delivered in a particular trial?
int triggered = 0; //has Bonsai been triggered yet?
int entered = 0; //
String[] probeStr = {};
