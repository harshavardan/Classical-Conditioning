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

// Find if element is in an array and return true or false

boolean ifisin(int element, int[] array) 
{
  boolean found = false;
  for (int i=0; i<array.length; i++) 
  {
    if (element == array[i]) 
    {
      found = true;
      break;
    }  
  }
  return found;
}

// Average an array

float arrayAvg(float[] arrayToAvg) 
{
  int len = arrayToAvg.length;
  float sum = 0;
  for (int i = 0; i<arrayToAvg.length; i++) {
    sum += arrayToAvg[i]; 
  }
  float avg = sum/len;
  return avg;
}


int arraySum(int[] array) {
  int sum = 0;
  for (int i=0; i<array.length; i++) {
    sum += array[i];
  }
  return sum;
}


//quit

void keyPressed() 
{
    if (key == ESC)
  {
    print("Forced to quit with keyboard!");
    exit();
  } 
}
