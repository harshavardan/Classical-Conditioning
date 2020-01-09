void draw() 
{
  
  // Trying to change k without the need for any osc messages
  k = 500;
  
  surface.setTitle("fps: " + round(frameRate));
  scal = 1 / (frameRate * period);
  
  // Updating the shader
  
  xPos = xPos + (k * scal);
  myshader.set("time", xPos);
  shader(myshader);
  rect(0, 0, windowWidth, windowHeight);
}
