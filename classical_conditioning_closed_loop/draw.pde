void draw() 
{
  
  ////////////////////Closed Loop Stuff//////////////////////////////
  int current_time = millis();
  
  // changing k without the need for any osc messages  
  k = 100;
  
  surface.setTitle("fps: " + round(frame_rate));
  scal = 1 / (frame_rate * period);
  
  // updating the shader
  x_pos = x_pos + (k * scal);
  myshader.set("time", x_pos);
  shader(myshader);
  rect(0, 0, window_width, window_height);
  
  // writing data
  data[0] = str(x_pos); // position of shader
  data[1] = str(current_time);  // time at which that position was updated
  
  if(!init)
  {
    for (int i = 0; i < dataWriter.length; i++)
    {
      dataWriter[i] = createWriter(file_path + "/" + generate_date() + "/" + fish + "/" +  file_names[i] + ".txt");
    }
    init = true;
  }
  
  for (int i = 0; i < dataWriter.length; i++)
  {
    dataWriter[i].println(data[i]+','); //The comma separation is for legacy reasons
  }
  
  //////////////////////////////////////////////////////////////////////
  
  ///////////////////Classical Conditioning/////////////////////////////
  
  //response to CS pre training
  if(trial[stimulus_count] == "preCS" && millis() >= init_delay && millis() >= structure[stimulus_count])
  {
    
    if(millis() - structure[stimulus_count] <= led_on)
    {      
      arduino.digitalWrite(CS_pin, Arduino.HIGH);
      led = 1; //led on
    }
      
    if(led == 1 && millis() - structure[stimulus_count] >= led_on)
    {
      println(stimulus_count + ". CS delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(CS_pin, Arduino.LOW);
      led = 0; //led off
      stimulus_count++;
    }
  }
  
  //response to US pre training
  if(trial[stimulus_count] == "preUS" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= flash_time)
    {
      arduino.digitalWrite(US_pin, Arduino.HIGH);
    }
    
    else if(millis() > (structure[stimulus_count] + flash_time))
    {
      println(stimulus_count + ". US delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(US_pin, Arduino.LOW);
      stimulus_count++;
    }
  }
  
  //training
  if(trial[stimulus_count] == "training" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= led_on)
    {   
      arduino.digitalWrite(CS_pin, Arduino.HIGH);
      led = 1; //led on
    }
    
    if (millis() - structure[stimulus_count] >= (led_on * US_pos) && millis() - structure[stimulus_count] < (led_on * US_pos + flash_time) && US == 0) // Delivery of US 
    {
      arduino.digitalWrite(US_pin, Arduino.HIGH);
      US = 1; // is the US being delivered now?
    }
    
    if(millis() - structure[stimulus_count] >= (led_on * US_pos + flash_time) && US == 1) // Turning off the US
    {
      US = 0;
      arduino.digitalWrite(US_pin, Arduino.LOW);
      print(stimulus_count + ". US delivered. Ended at " + millis() + " ms");
    }
    
     if(led == 1 && millis() - structure[stimulus_count] >= led_on) // Turning off the CS
    {
      println(" and CS delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(CS_pin, Arduino.LOW);
      led = 0; //led off
      stimulus_count++;
    }
  }
  
  //probe trials
  if(trial[stimulus_count] == "probe" && millis() >= structure[stimulus_count])
  {    
    if(millis() - structure[stimulus_count] <= led_on)
    {
      arduino.digitalWrite(CS_pin, Arduino.HIGH);
      led = 1; //led on
    }
     
    if(led == 1 && millis() - structure[stimulus_count] >= led_on)
    {
      println(stimulus_count + ". Probe trial delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(CS_pin, Arduino.LOW);
      led = 0; //led off
      stimulus_count++;
    }
  }
  
  //test trials
  if(trial[stimulus_count] == "test" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= led_on)
    {
      arduino.digitalWrite(CS_pin, Arduino.HIGH);
      led = 1; //led on
    }
    
    
    if(led == 1 && millis() - structure[stimulus_count] >= led_on)
    {
      println(stimulus_count + ". CS delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(CS_pin, Arduino.LOW);
      led = 0; //led off
      stimulus_count++;
    }
  }
  
  //end of program
  if(stimulus_count == structure.length)
  {
    println("Program ended!");
    noLoop();
  }
}
