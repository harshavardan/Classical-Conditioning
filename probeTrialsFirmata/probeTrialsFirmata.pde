/* Classical conditioning with light as CS and shock as US. 
A number of CS and US can be given to establish baseline 
responses before training begins. During training, the CS 
goes on and the US can be delivered anywhere within the CS.
Probe trials can be randomly delivered during training. 
Finally, CS-only test trials are given to extinguish learning.*/ 

import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
int ledPin = 2;
int USLedPin = 12;

void setup()
{
//println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[0], 57600);
arduino.pinMode(ledPin, Arduino.OUTPUT);
  
  index = 0;
  
  for(int i = 0; i < structure.length; i++)
  {
    if (i < (structure.length - noTest))
    {
      structure[i] = i * isi + initDelay;
    }
    else if(i == (structure.length - noTest))
    {
      structure[i] = structure[i - 1] + wait;
    }
    else
    {
      structure[i] = structure[i - 1] + isi;
    }
  }
  
 
   print("Probe trials: ");
  
  int i = 0;
  while(i < probe.length)
  {
    int rnd =  int(random(0, (noTraining - 1)));
    int present = 0; //checks if rnd is present in the probe array
  
    for(int j = 0; j < probe.length; j++)
      if(probe[j] == rnd || probe[j] == (rnd - 1) || probe[j] == (rnd + 1))
        present = 1;
    
      if(present == 0)
      {
        probe[i] = rnd;
        probeStr = append(probeStr, str(rnd));
        print(probe[i] + ", ");
        i++;
      }
    }
    
    probe = sort(probe); 
    
    for(i = 0; i < probe.length; i++)
    {
      probe[i] += (noPreCS + noPreUS);
    }
    
    int index = 0;
    
    for(i = 0; i< structure.length; i++)
    {
      if(index < noProbe && i == probe[index])
      {
        trial = append(trial, "probe");
        index++;
      }
      else if(i < noPreCS)
      {
        trial = append(trial, "preCS");
      }
      else if(i < (noPreCS + noPreUS))
      {
        trial = append(trial, "preUS");
      }
      else if(i < (noPreCS + noPreUS + noTraining))
      {
        trial = append(trial, "training");
      }
      else if(i < structure.length)
      {
        trial = append(trial, "test");
      }
    }
    
    println();  
    
  
  println("Program started");
  
  oscP5 = new OscP5(this,12000);
  location = new NetAddress("127.0.0.1",2323);
  

}





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
