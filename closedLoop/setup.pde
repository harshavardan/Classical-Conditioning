void setup() 
{
  frameRate(framerate);
  background(255, 255, 255);       
  noStroke();                
  fill(0, 0, 0);
  noCursor();
  
  myshader = loadShader("sine.frag");
  if (square==true){c=10;}  
  myshader.set("th", th);
  myshader.set("sper", per);
  myshader.set("contrast", c);

  delay(100);
  oscP5 = new OscP5(this,2323);
}
