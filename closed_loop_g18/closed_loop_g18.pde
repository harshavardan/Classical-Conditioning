/* Basic closed loop code, contains no experiment structure.  
The grating only responds to tail motion whenever it is detected.
It is meant to be forked and modified if closed loop is needed in 
the background of another experiment.

Bonsai is used to capture, process and save the video. Difference
between consecutive frames is averaged and sent to Processing via 
the OSC protocol. Processing uses this with gain and pixel size 
to update the shader.*/

////////////////////Closed Loop Stuff//////////////////////////////

// fish information

String genotype = "Indian Wild Type";
String dpf = "7";
String file_path = "../data";
String fish = "F1";

// parameters

int window_width = 1000; // width of the display window
int window_height = 500; // height of the display window
float pixel_width = 0.032; //centimetres
float x_pos = 0.0;   
float Width = 1.0; // period in cm
float period = Width / pixel_width; //period in pixels
float offset = 0.0;
float th = (PI) + offset; //orientation in radians (0, 1.5708, 3.148)
float c = 10; //contrast
Boolean square = true; 
float frame_rate = 120.0; //Refresh rate in Hz
float frame_interval = 1000.0 / frame_rate;
float scal = 1 / (frame_rate * period);
boolean init = false; // have the files to be written been created?

//////////////////////////////////////////////////////////////////////
