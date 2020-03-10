void setup() 
{
  ////////////////////Closed Loop Stuff//////////////////////////////
  
  size(window_width, window_height, P2D);
  myshader = loadShader("sine.frag");
  myshader.set("resolution", float(window_width), float(window_height));
  noCursor();
  
  //////////////////////////////////////////////////////////////////////
}
