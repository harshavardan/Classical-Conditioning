// lowpass filter

float LowpassFilter(float current_value, float previous_value, float tau)  
{
  float alpha = 1.0 / (tau + 1);
  float swim = 0.0;
  swim = previous_value + alpha * (current_value - previous_value);
  return swim;
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
