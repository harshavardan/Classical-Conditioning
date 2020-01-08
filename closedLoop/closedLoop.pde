/* Basic closed loop code, contains no experiment structure.  
The grating only responds to tail motion whenever it is detected.
It is meant to be forked and modified if closed loop is needed in 
the background of another experiment.*/


boolean openLoop = true;
boolean Repeat = false;    //Allow multiple repeats or not
float movement_scaling = 1.0 ; //scaling factor for calibrating gain HOW IS THIS DIFFERENT FROM GAIN?

//fish information

String genotype = "Indian Wild Type";
String dpf = "7";
