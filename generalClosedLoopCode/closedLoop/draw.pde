void draw() 
{
  int currentTime = millis();
  
  // changing k without the need for any osc messages
  
  k = 100;
  
  surface.setTitle("fps: " + round(frameRate));
  scal = 1 / (frameRate * period);
  
  // updating the shader
  
  xPos = xPos + (k * scal);
  myshader.set("time", xPos);
  shader(myshader);
  rect(0, 0, windowWidth, windowHeight);
  
  // writing data
  
  data[0] = str(xPos); // position of shader
  data[1] = str(currentTime);  // time at which that position was updated
  
  if(!init)
  {
    for (int i = 0; i < dataWriter.length; i++)
    {
      dataWriter[i] = createWriter(filePath + "/" + generateDate() + "/" + fish + "/" +  Filenames[i] + ".txt");
    }
    init = true;
  }
  
  for (int i = 0; i < dataWriter.length; i++)
  {
    dataWriter[i].println(data[i]+','); //The comma separation is for legacy reasons
  }
}
