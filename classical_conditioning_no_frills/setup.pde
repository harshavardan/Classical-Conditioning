void setup()
{  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(cs_pin, Arduino.OUTPUT);
  arduino.pinMode(us_pin, Arduino.OUTPUT);

  if (random)
    generate_random_timing();

  else
    generate_timing();

  print("Probe trials: ");

  pick_probe();



  println();  


  println("Program started");

  oscP5 = new OscP5(this, 12000);
  location = new NetAddress("127.0.0.1", 2323);
}

