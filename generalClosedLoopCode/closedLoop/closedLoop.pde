/* Basic closed loop code, contains no experiment structure.  
The grating only responds to tail motion whenever it is detected.
It is meant to be forked and modified if closed loop is needed in 
the background of another experiment.

Bonsai is used to capture, process and save the video. Difference
between consecutive frames is averaged and sent to Processing via 
the OSC protocol. Processing uses this with gain and pixel size 
to update the shader.*/


// fish information

String genotype = "Indian Wild Type";
String dpf = "7";
String filePath = "../data";
String fish = "F1";

// parameters

int windowWidth = 1000; // width of the display window
int windowHeight = 500; // height of the display window
float pixelWidth = 0.032; //centimetres
float xPos = 0.0;   
float Width = 1.0; // period in cm
float period = Width / pixelWidth; //period in pixels
float offset = 0.0;
float th = (PI) + offset; //orientation in radians (0, 1.5708, 3.148)
float c = 0.5; //contrast
Boolean square = true; 
float framerate = 120.0; //Refresh rate in Hz
float frameinterval = 1000.0 / framerate;
float scal = 1 / (framerate * period);
boolean init = false; // have the files to be written been created?
