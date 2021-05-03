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
    if(cs == 0 && millis() - structure[stimulus_count] <= cs_dur)
    {      
      arduino.digitalWrite(cs_pin, Arduino.HIGH);
      cc_datawriter[0].println(str(millis()) + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
      cs = 1; //cs on
      print(stimulus_count + ". CS on: " + millis() + " ms");

    }
      
    if(cs == 1 && millis() - structure[stimulus_count] >= cs_dur)
    {
      arduino.digitalWrite(cs_pin, Arduino.LOW);
      cc_datawriter[0].println(str(millis()) + ",");
      cs = 0; //cs off
      stimulus_count++;
      println(", CS off: " + millis() + " ms");

    }
  }
  
  //response to us pre training
  if(trial[stimulus_count] == "preus" && millis() >= structure[stimulus_count])
  {
    if(us == 0 && millis() - structure[stimulus_count] <= us_dur)
    {
      arduino.digitalWrite(us_pin, Arduino.HIGH);
      cc_datawriter[0].println(str(millis()) + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
      us = 1;
      print(stimulus_count + ". US on: " + millis() + " ms");

    }
    
    else if(us == 1 && millis() > (structure[stimulus_count] + us_dur))
    {
      arduino.digitalWrite(us_pin, Arduino.LOW);
      us = 0;
      cc_datawriter[0].println(str(millis()) + ",");
      stimulus_count++;
      println(", US off: " + millis() + " ms");

    }
  }
  
  //training
  if(trial[stimulus_count] == "training" && millis() >= structure[stimulus_count])
  {
    if(cs == 0 && millis() - structure[stimulus_count] <= cs_dur)
    {   
      arduino.digitalWrite(cs_pin, Arduino.HIGH);
      cc_datawriter[0].println(str(millis()) + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
      cs = 1; //cs on
      print(stimulus_count + ". CS on: " + millis() + " ms");

    }
    
    if (us == 0 && millis() - structure[stimulus_count] >= (cs_dur * us_pos) && millis() - structure[stimulus_count] < (cs_dur * us_pos + us_dur) && us == 0) // Delivery of us 
    {
      arduino.digitalWrite(us_pin, Arduino.HIGH);
      us = 1; // is the us being delivered now?
      cc_datawriter[0].println(str(millis()) + ",");
      print(", US on: " + millis() + " ms");

    }
    
    if(us == 1 && millis() - structure[stimulus_count] >= (cs_dur * us_pos + us_dur) && us == 1) // Turning off the us
    {
      arduino.digitalWrite(us_pin, Arduino.LOW);
      us = 0;
      cc_datawriter[0].println(str(millis()) + ",");
      print(", US off: " + millis() + " ms");
    }
    
     if(cs == 1 && millis() - structure[stimulus_count] >= cs_dur) // Turning off the cs
    {
      arduino.digitalWrite(cs_pin, Arduino.LOW);
      cs = 0; //cs off
      cc_datawriter[0].println(str(millis()) + ",");
      stimulus_count++;
      println(", CS off: " + millis() + " ms");

    }
  }
  
  //probe trials
  if(trial[stimulus_count] == "probe" && millis() >= structure[stimulus_count])
  {    
    if(cs == 0 && millis() - structure[stimulus_count] <= cs_dur)
    {
      arduino.digitalWrite(cs_pin, Arduino.HIGH);
      cs = 1; //cs on
      cc_datawriter[0].println(str(millis()) + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
      print(stimulus_count + ". probe on: " + millis() + " ms");      
    }
     
    if(cs == 1 && millis() - structure[stimulus_count] >= cs_dur)
    {
      arduino.digitalWrite(cs_pin, Arduino.LOW);
      cs = 0; //cs off
      cc_datawriter[0].println(str(millis()) + ",");
      stimulus_count++;
      println(", probe off: " + millis() + " ms");

    }
  }
  
  //test trials
  if(trial[stimulus_count] == "test" && millis() >= structure[stimulus_count])
  {
    if(cs == 0 && millis() - structure[stimulus_count] <= cs_dur)
    {
      arduino.digitalWrite(cs_pin, Arduino.HIGH);
      cs = 1; //cs on
      cc_datawriter[0].println(str(millis()) + ",");
      cc_datawriter[1].println(trial[stimulus_count] + ",");
      print(stimulus_count + ". test on: " + millis() + " ms");      

    }
    
    
    if(cs == 1 && millis() - structure[stimulus_count] >= cs_dur)
    {
      arduino.digitalWrite(cs_pin, Arduino.LOW);
      cs = 0; //cs off
      cc_datawriter[0].println(str(millis()) + ",");
      stimulus_count++;
      println(", test off: " + millis() + " ms");

    }
  }
  
  //end of program
  if(stimulus_count == structure.length)
  {
    println("Program ended!");
    noLoop();
  }
}

