import oscP5.*;
import netP5.*;

OscP5 oscP5;

float gain = 1.0;
double raw_k = 0.0; 
float k = 0.0; 
float prev_k = 0.0; 
int slidingWindowWidth = 4;
float[] slidingWindow = new float[slidingWindowWidth];
float tailsamplinginterval = 20; //milliseconds (after accounting for sliding window averaging) 
float timecourse = 10; 
float tau = timecourse / tailsamplinginterval;   
int current_event_time = 0;
int prev_event_time = 0;

//Read values from Bonsai

void oscEvent(OscMessage theOscMessage) 
{
  current_event_time = millis();
  tailsamplinginterval = current_event_time - prev_event_time;
  prev_event_time = current_event_time;
  tau = timecourse / tailsamplinginterval;
  raw_k = theOscMessage.get(0).doubleValue();
  k = (float) raw_k;
  k = LowpassFilter(k, prev_k, tau);
  prev_k = k;
  k = k * gain / pixelWidth;
}
