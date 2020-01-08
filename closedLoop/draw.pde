void draw() 
{
  
  // Trying to change k without the need for any osc messages
  k++;
  
  surface.setTitle("fps: " + round(frameRate));     
  //frame.setLocation(1750, 0); 
  scal = 1 / (frameRate * per);

  arrayCopy(updateFifoBuffer(fifoBuffer, k), fifoBuffer);
  
  // Updating the shader
  
  xPos = xPos + (k * scal);
  myshader.set("time", xPos);
  shader(myshader);
  rect(0, 0, windowWidth, windowHeight);
}
