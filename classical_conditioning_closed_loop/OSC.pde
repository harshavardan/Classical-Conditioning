////////////////////Closed Loop Stuff//////////////////////////////

import oscP5.*;
import netP5.*;

OscP5 oscP5;

float gain = 1.0;
double raw_k = 0.0; 
float k = 0.0; 
float prev_k = 0.0; 
float tail_sampling_interval = 20; //milliseconds (after accounting for sliding window averaging) 
float timecourse = 10; 
float tau = timecourse / tail_sampling_interval;   
int current_event_time = 0;
int prev_event_time = 0;

//Read values from Bonsai

void oscEvent(OscMessage theOscMessage) 
{
  current_event_time = millis();
  tail_sampling_interval = current_event_time - prev_event_time;
  prev_event_time = current_event_time;
  tau = timecourse / tail_sampling_interval;
  raw_k = theOscMessage.get(0).doubleValue();
  k = (float) raw_k;
  k = lowpass_filter(k, prev_k, tau);
  prev_k = k;
  k = k * gain / pixelWidth;
}

//////////////////////////////////////////////////////////////////////
