int maxDelay = 1000;
int bufferSize = ceil(maxDelay/frameinterval);
float[] fifoBuffer = new float[bufferSize];

float LowpassFilter(float current_value, float previous_value, float tau)  
{
  float alpha = 1.0 / (tau + 1);
  float swim = 0.0;
  swim = previous_value + alpha * (current_value - previous_value);
  return swim;
}


//Buffer update function

float[] updateFifoBuffer(float[] buffer, float value)
{
  float[] v = {value};
  float[] temp = shorten(buffer);
  float[] updatedBuffer = concat(v, temp);
  return updatedBuffer; 
}

// Average an array

float arrayAvg(float[] arrayToAvg) 
{
  int len = arrayToAvg.length;
  float sum = 0;
  for (int i = 0; i<arrayToAvg.length; i++) 
  {
    sum += arrayToAvg[i]; 
  }
  float avg = sum / len;
  return avg;
}


//quit using keyboard

void keyPressed() 
{
    if (key == ESC)
  {
    print("Forced to quit with keyboard!\n");
    exit();
  } 
}
