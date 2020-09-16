void cs()
{
  oscP5.send(myMessage, location); 
  arduino.digitalWrite(cs_pin, Arduino.HIGH);
  wait(cs_dur);
  arduino.digitalWrite(cs_pin, Arduino.LOW);
  stimulus_count++;
}

void us()
{
  oscP5.send(myMessage, location); 
  arduino.digitalWrite(us_pin, Arduino.HIGH);
  wait(us_dur);
  arduino.digitalWrite(us_pin, Arduino.LOW);
  stimulus_count++;
}

void train()
{
  oscP5.send(myMessage, location);
  arduino.digitalWrite(cs_pin, Arduino.HIGH);
  wait(us_pos * cs_dur);
  arduino.digitalWrite(us_pin, Arduino.HIGH);
  wait(us_dur);
  arduino.digitalWrite(us_pin, Arduino.LOW);
  wait((1 - us_pos) * cs_dur - us_dur);
  arduino.digitalWrite(cs_pin, Arduino.LOW);
}

void wait(d)
{
  t = millis();
  while((millis() - t) <= d){}
}
  
  
