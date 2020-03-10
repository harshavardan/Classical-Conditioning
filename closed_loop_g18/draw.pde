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
}

