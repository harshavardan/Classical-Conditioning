void draw()
{
  
  //saving probe trials
  saveStrings("E:/Harshavardan/classicalConditioningCode/data/probetrials.txt", probeStr);
  
  //triggering Bonsai
  if(triggered == 0)
  {
    myMessage.add(1);
    oscP5.send(myMessage, location); 
    triggered++;
  }
  
  //response to CS pre training
  if(trial[stimulusCount] == "preCS" && millis() >= initDelay && millis() >= structure[stimulusCount])
  {
    if(entered == 0)
    {
      oscP5.send(myMessage, location); 
      entered++;
    }
    
    if(millis() - structure[stimulusCount] <= ledOn)
    {      
      arduino.digitalWrite(ledPin, Arduino.HIGH);
      led = 1; //led on
    }
    
    
    if(led == 1 && millis() - structure[stimulusCount] >= ledOn)
    {
      println(stimulusCount + ". CS delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(ledPin, Arduino.LOW);
      led = 0; //led off
      stimulusCount++;
      entered=0;
    }
  }
  
  
  //response to US pre training
  if(trial[stimulusCount] == "preUS" && millis() >= structure[stimulusCount])
  {
    if(entered == 0)
    {
      oscP5.send(myMessage, location); 
      entered++;
    }
    
    if(millis() - structure[stimulusCount] <= flashTime)
    {
      arduino.digitalWrite(USLedPin, Arduino.HIGH);
    }
    
    else if(millis() > (structure[stimulusCount] + flashTime))
    {
      println(stimulusCount + ". US delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(USLedPin, Arduino.LOW);
      stimulusCount++;
      entered = 0;
    }
  }
  
  
  //training
  if(trial[stimulusCount] == "training" && millis() >= structure[stimulusCount])
  {
    
    if(entered == 0)
    {
      oscP5.send(myMessage, location); 
      entered++;
    }
    
    if(millis() - structure[stimulusCount] <= ledOn)
    {   
      arduino.digitalWrite(ledPin, Arduino.HIGH);
      led = 1; //led on
    }
    
    if (millis() - structure[stimulusCount] >= (ledOn * USpos) && millis() - structure[stimulusCount] < (ledOn * USpos + flashTime) && US == 0) // Delivery of US 
    {
      arduino.digitalWrite(USLedPin, Arduino.HIGH);
      US = 1; // is the US being delivered now?
    }
    
    if(millis() - structure[stimulusCount] >= (ledOn * USpos + flashTime) && US == 1) // Turning off the US
    {
      US = 0;
      arduino.digitalWrite(USLedPin, Arduino.LOW);
      print(stimulusCount + ". US delivered. Ended at " + millis() + " ms");
    }
    
     if(led == 1 && millis() - structure[stimulusCount] >= ledOn) // Turning off the CS
    {
      println(" and CS delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(ledPin, Arduino.LOW);
      led = 0; //led off
      stimulusCount++;
      entered = 0;
    }
  }
  
  //probe trials
  if(trial[stimulusCount] == "probe" && millis() >= structure[stimulusCount])
  {
    if(entered == 0)
    {
      oscP5.send(myMessage, location); 
      entered++;
    }
    
    if(millis() - structure[stimulusCount] <= ledOn)
    {
      arduino.digitalWrite(ledPin, Arduino.HIGH);
      led = 1; //led on
    }
    
    
    if(led == 1 && millis() - structure[stimulusCount] >= ledOn)
    {
      println(stimulusCount + ". Probe trial delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(ledPin, Arduino.LOW);
      led = 0; //led off
      stimulusCount++;
      entered = 0;
    }
  }
  
  
  
  //test trials
  if(trial[stimulusCount] == "test" && millis() >= structure[stimulusCount])
  {
    if(entered == 0)
    {
      oscP5.send(myMessage, location); 
      entered++;
    }
    
    if(millis() - structure[stimulusCount] <= ledOn)
    {
      arduino.digitalWrite(ledPin, Arduino.HIGH);
      led = 1; //led on
    }
    
    
    if(led == 1 && millis() - structure[stimulusCount] >= ledOn)
    {
      println(stimulusCount + ". CS delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(ledPin, Arduino.LOW);
      led = 0; //led off
      stimulusCount++;
      entered = 0;
    }
  }
  
  //end of program
  if(stimulusCount == structure.length)
  {
    println("Program ended!");
    oscP5.send(myMessage, location); 
    noLoop();
  } 


}
