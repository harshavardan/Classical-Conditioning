void draw() 
{
  
  ////////////////////Closed Loop Stuff//////////////////////////////
  
  int current_time = millis();
  myshader.set("th", th);
  myshader.set("sper", period);
  myshader.set("contrast", c);
  
  // changing k without the need for any osc messages
  
  k = 100;
  
  //surface.setTitle("fps: " + round(frame_rate));
  scal = 1 / (frame_rate * period);
  
  // updating the shader
  
  x_pos = x_pos + (k * scal);
  myshader.set("time", x_pos);
  shader(myshader);
  rect(0, 0, window_width, window_height);  
  
  shader(myshader);
  rect(0, 0, window_width, window_height);
  
  // writing data
  
  cl_data[0] = str(x_pos); // position of shader
  cl_data[1] = str(current_time);  // time at which that position was updated
  
  if(!init)
  {
    for (int i = 0; i < cl_datawriter.length; i++)
    {
      cl_datawriter[i] = createWriter(file_path + "/" + generate_date() + "/" + fish + "/" +  cl_file_names[i] + ".txt");
    }
    
    for (int i = 0; i < cc_datawriter.length; i++)
    {
      cc_datawriter[i] = createWriter(file_path + "/" + generate_date() + "/" + fish + "/" + cc_file_names[i] + ".txt");
    }
      init = true;
  }
  
  for (int i = 0; i < cl_datawriter.length; i++)
  {
    cl_datawriter[i].println(cl_data[i] + ','); //The comma separation is for legacy reasons
  }
  
  //////////////////////////////////////////////////////////////////////
  
  ///////////////////Classical Conditioning/////////////////////////////
  
  //response to cs pre training
  if(trial[stimulus_count] == "precs" && millis() >= init_delay && millis() >= structure[stimulus_count])
  {
    
    if(millis() - structure[stimulus_count] <= cs_dur)
    {      
      arduino.digitalWrite(cs_pin, Arduino.HIGH);
      led = 1; //led on
      cc_datawriter[0].println(millis() + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
    }
      
    if(led == 1 && millis() - structure[stimulus_count] >= cs_dur)
    {
      //println(stimulus_count + ". cs delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(cs_pin, Arduino.LOW);
      led = 0; //led off
      cc_datawriter[0].println(millis() + ",");
      stimulus_count++;
    }
  }
  
  //response to us pre training
  if(trial[stimulus_count] == "preus" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= us_dur)
    {
      arduino.digitalWrite(us_pin, Arduino.HIGH);
      cc_datawriter[0].println(millis() + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
    }
    
    else if(millis() > (structure[stimulus_count] + us_dur))
    {
      //println(stimulus_count + ". us delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(us_pin, Arduino.LOW);
      cc_datawriter[0].println(millis() + ",");
      stimulus_count++;
    }
  }
  
  //training
  if(trial[stimulus_count] == "training" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= cs_dur)
    {   
      arduino.digitalWrite(cs_pin, Arduino.HIGH);
      led = 1; //led on
      cc_datawriter[0].println(millis() + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
    }
    
    if (millis() - structure[stimulus_count] >= (cs_dur * us_pos) && millis() - structure[stimulus_count] < (cs_dur * us_pos + us_dur) && us == 0) // Delivery of us 
    {
      arduino.digitalWrite(us_pin, Arduino.HIGH);
      us = 1; // is the us being delivered now?
      cc_datawriter[0].println(millis() + ",");
    }
    
    if(millis() - structure[stimulus_count] >= (cs_dur * us_pos + us_dur) && us == 1) // Turning off the us
    {
      arduino.digitalWrite(us_pin, Arduino.LOW);
      us = 0;
      cc_datawriter[0].println(millis() + ",");
      //print(stimulus_count + ". us delivered. Ended at " + millis() + " ms");
    }
    
     if(led == 1 && millis() - structure[stimulus_count] >= cs_dur) // Turning off the cs
    {
      //println(" and cs delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(cs_pin, Arduino.LOW);
      led = 0; //led off
      cc_datawriter[0].println(millis() + ",");
      stimulus_count++;
    }
  }
  
  //probe trials
  if(trial[stimulus_count] == "probe" && millis() >= structure[stimulus_count])
  {    
    if(millis() - structure[stimulus_count] <= cs_dur)
    {
      arduino.digitalWrite(cs_pin, Arduino.HIGH);
      led = 1; //led on
      cc_datawriter[0].println(millis() + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
    }
     
    if(led == 1 && millis() - structure[stimulus_count] >= cs_dur)
    {
      //println(stimulus_count + ". Probe trial delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(cs_pin, Arduino.LOW);
      led = 0; //led off
      cc_datawriter[0].println(millis() + ",");
      stimulus_count++;
    }
  }
  
  //test trials
  if(trial[stimulus_count] == "test" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= cs_dur)
    {
      arduino.digitalWrite(cs_pin, Arduino.HIGH);
      led = 1; //led on
      cc_datawriter[0].println(millis() + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
    }
    
    
    if(led == 1 && millis() - structure[stimulus_count] >= cs_dur)
    {
      //println(stimulus_count + ". cs delivered. Ended at " + millis() + " ms");
      arduino.digitalWrite(cs_pin, Arduino.LOW);
      led = 0; //led off
      cc_datawriter[0].println(millis() + ",");
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

