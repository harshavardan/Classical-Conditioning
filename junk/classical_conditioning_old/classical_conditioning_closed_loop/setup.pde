void setup() 
{
  ////////////////////Closed Loop Stuff//////////////////////////////
  
  size(window_width, window_height, P2D);
  myshader = loadShader("sine.frag");
  myshader.set("resolution", float(window_width), float(window_height));
  noCursor();
  
  //////////////////////////////////////////////////////////////////////
  
  ///////////////////Classical Conditioning/////////////////////////////
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(cs_pin, Arduino.OUTPUT);
  arduino.pinMode(us_pin, Arduino.OUTPUT);
  
  if(random)
  generate_random_timing();
  
  else
  generate_timing();
  
  print("Probe trials: ");
  
  pick_probe();
  

    
    println();  
    
  
  println("Program started");
  
  ////////////////////////////////////////////////////////////////////
}
