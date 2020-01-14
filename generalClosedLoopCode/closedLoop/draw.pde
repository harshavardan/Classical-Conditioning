void draw() 
{
  currentTime = millis();
  
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
  
  Data[0] = str(xPos); // position of shader
  Data[1] = str(currentTime);  // time at which that position was updated
  
  for (int i = 0; i < DataWriter.length; i++) 
  {
    DataWriter[i] = createWriter(filepath + Filenames[i] + ".txt");
  }
  
  for (int i = 0; i < DataWriter.length; i++) 
  {
    DataWriter[i] = createWriter(filepath + Filenames[i] + ".txt");
  }
}
