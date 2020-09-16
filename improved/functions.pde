void cs()
{
  t = millis();
  arduino.digitalWrite(cs_pin, Arduino.HIGH);
  oscP5.send(myMessage, location); 
  cc_datawriter[0].println(str(millis()) + ",");
  cc_datawriter[1].println(trial[stimulus_count] + ",");
  print(stimulus_count + ". CS on: " + millis() + " ms");
  
  while(millis - t <= cs_dur)
  {
  }
  
  arduino.digitalWrite(cs_pin, Arduino.LOW);
  cc_datawriter[0].println(str(millis()) + ",");
  stimulus_count++;
  println(", CS off: " + millis() + " ms");
}

void us()
{
  t = millis();
  arduino.digitalWrite(us_pin, Arduino.HIGH);
  oscP5.send(myMessage, location); 
  cc_datawriter[0].println(str(millis()) + ",");
  cc_datawriter[1].println(trial[stimulus_count] + ",");
  print(stimulus_count + ". US on: " + millis() + " ms");
  
  while(millis - t <= us_dur)
  {
  }
  
  arduino.digitalWrite(us_pin, Arduino.LOW);
  cc_datawriter[0].println(str(millis()) + ",");
  stimulus_count++;
  println(", US off: " + millis() + " ms");
}

void train(position = us_pos)
{
  
