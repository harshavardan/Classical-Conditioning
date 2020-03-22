void draw() 
{
  //print(blah, ", ");
  //blah++;
  myshader = loadShader("sine.frag");
  if (square==true){c=10;}  
  myshader.set("th", th);
  myshader.set("sper", period);
  myshader.set("contrast", c);
  
  ////////////////////Closed Loop Stuff//////////////////////////////
  int current_time = millis();
  
  // changing k without the need for any osc messages  
  k = 100;
  
  //surface.setTitle("fps: " + round(frame_rate));
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
      dataWriter[i] = createWriter(file_path + "/" + generate_date()
                                    + "/" + fish + "/" +  file_names[i]
                                    + ".txt");
    }
    init = true;
  }
  
  for (int i = 0; i < dataWriter.length; i++)
  {
    dataWriter[i].println(data[i]+',');
  }
  
  //////////////////////////////////////////////////////////////////////
  
  ///////////////////Classical Conditioning/////////////////////////////
  
 
  //response to CS pre training
  
  if(millis() >= init_delay)
  {
    
  if(trial[stimulus_count] == "preCS" && millis() >= structure[stimulus_count])
  {
    
    if(millis() - structure[stimulus_count] <= cs_duration)
    {      
      background(0, 0, 0);
    }
      
    else if(millis() - structure[stimulus_count] >= cs_duration)
    {
      arduino.digitalWrite(CS_pin, Arduino.LOW);
      println(stimulus_count + ". CS ended at " + millis() + " ms");
      led = 0; //led off
      stimulus_count++;
    }
  }
  
  //response to US pre training
  if(trial[stimulus_count] == "preUS" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= us_duration)
    {
      background(0, 255, 0);
    }
    
    else if(millis() - structure[stimulus_count] > us_duration)
    {
      arduino.digitalWrite(US_pin, Arduino.LOW);
      println(stimulus_count + ". US ended at " + millis() + " ms");
      stimulus_count++;
    }
  }
  
  //training
  if(trial[stimulus_count] == "training" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= cs_duration)
    {   
      background(0, 0, 0);
    }
    
    if (millis() - structure[stimulus_count] >= (cs_duration * US_pos) && millis() 
        - structure[stimulus_count] < (cs_duration * US_pos + us_duration) && US == 0) // Delivery of US 
    {
      background(0, 255, 0);
      US = 1; // Has the US been delivered?
    }
    
    if(millis() - structure[stimulus_count] >= (cs_duration * US_pos + us_duration) 
        && US == 1) // Turning off the US
    {
      arduino.digitalWrite(US_pin, Arduino.LOW);
      print(stimulus_count + ". US ended at " + millis() + " ms");
      US = 0;
    }
    
     if(millis() - structure[stimulus_count] >= cs_duration) // Turning off the CS
    {
      println(" and CS ended at " + millis() + " ms");
      arduino.digitalWrite(CS_pin, Arduino.LOW);
      stimulus_count++;
    }
  }
  
  //probe trials
  if(trial[stimulus_count] == "probe" && millis() >= structure[stimulus_count])
  {    
    if(millis() - structure[stimulus_count] <= cs_duration)
    {
      background(0, 0, 0);
    }
     
    if(millis() - structure[stimulus_count] >= cs_duration)
    {
      println(stimulus_count + ". Probe trial ended at " + millis() + " ms");
      arduino.digitalWrite(CS_pin, Arduino.LOW);
      stimulus_count++;
    }
  }
  
  //test trials
  if(trial[stimulus_count] == "test" && millis() >= structure[stimulus_count])
  {
    if(millis() - structure[stimulus_count] <= cs_duration)
    {
      background(0, 0, 0);
    }
    
    
    if(led == 1 && millis() - structure[stimulus_count] >= cs_duration)
    {
      arduino.digitalWrite(CS_pin, Arduino.LOW);
      println(stimulus_count + ". Test CS ended at " + millis() + " ms");
      stimulus_count++;
    }
  }
  }
  
  //end of program
  if(stimulus_count == structure.length)
  {
    println("Program ended!");
    noLoop();
  }
}
