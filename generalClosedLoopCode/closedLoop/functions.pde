float LowpassFilter(float current_value, float previous_value, float tau)  
{
  float alpha = 1.0 / (tau + 1);
  float swim = 0.0;
  swim = previous_value + alpha * (current_value - previous_value);
  return swim;
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
