void setup() 
{
  frameRate(framerate);
  background(255, 255, 255);       
  noStroke();                
  fill(0, 0, 0);
  noCursor();
  
   notes = createWriter(filePath + "/" + generateDate() + "/" + fish + "/" + "parameters.txt");
   notes.println("Date\t\t\t:\t" + generateDate());
   notes.println("Time\t\t\t:\t" + time);
   notes.println("Genotype\t\t:\t" + genotype);
   notes.println("Days Post Fertilization\t:\t" + dpf);
     
  // loading shader and setting parameters
  
  myshader = loadShader("sine.frag");
  if (square==true){c=10;}  
  myshader.set("th", th);
  myshader.set("sper", period);
  myshader.set("contrast", c);

  delay(100);
  oscP5 = new OscP5(this,2323);
}
