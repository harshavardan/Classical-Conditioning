void setup()
{  
  frameRate(120);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(cs_pin, Arduino.OUTPUT);
  arduino.pinMode(us_pin, Arduino.OUTPUT);
  arduino.pinMode(cs_trigger_pin, Arduino.OUTPUT);
  arduino.pinMode(us_trigger_pin, Arduino.OUTPUT);
  
  arduino.digitalWrite(cs_pin, Arduino.LOW); 
 arduino.digitalWrite(cs_trigger_pin, Arduino.LOW); 
 arduino.digitalWrite(us_pin, Arduino.LOW); 
 arduino.digitalWrite(us_trigger_pin, Arduino.LOW);

  if (random)
    generate_random_timing();
   else
     generate_timing();
  
  pick_probe();
  println(no_probe);
  generate_trials();    

  println();  
  println("Program started");
  println("Timing");
  println(timing);
  
  oscP5 = new OscP5(this, 12000);
  location = new NetAddress("127.0.0.1", 2323);
}

