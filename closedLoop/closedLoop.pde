/* Basic closed loop code, contains no experiment structure.  
The grating only responds to tail motion whenever it is detected.
It is meant to be forked and modified if closed loop is needed in 
the background of another experiment.*/


// Fish information

String genotype = "Indian Wild Type";
String dpf = "7";

// parameters

int windowWidth = 1000;
int windowHeight = 500;
float pixelwidth=.032; //centimetres
float xPos = 0.0;   
float Width = 1.0; // period in cm
float per = Width/pixelwidth; //period in pixels
float offset = 0.0;
float th = (PI)+offset; //orientation in radians (0,1.5708,3.148)
float c = 0.5; //contrast
Boolean square = true; 
float framerate = 120.0; //Refresh rate in Hz
float frameinterval = 1000.0/framerate;
float scal = 1/(framerate*per);
