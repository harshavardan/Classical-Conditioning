////////////////////Closed Loop Stuff//////////////////////////////

String[] data = new String[2];
PrintWriter[] dataWriter = new PrintWriter[2];
PrintWriter notes;
String time=(str(hour())+":"+str(minute())+":"+str(second()));
String[] file_names = {"grating","time"};

// lowpass filter

float lowpass_filter(float current_value, float previous_value, float tau)  
{
  float alpha = 1.0 / (tau + 1);
  float swim = 0.0;
  swim = previous_value + alpha * (current_value - previous_value);
  return swim;
}

// returns date

String generate_date()
{  
  String year,month,day,Date;
  
  year = str(year() % 1000);
  if (month() < 10)
  {month = str(0) + str(month());}
  else
  {month = str(month());}
  if (day() < 10)
  {day = str(0) + str(day());}
  else
  {day = str(day());}
  Date = year + month + day;
  
  return Date;
}

//quit using keyboard

void keyPressed() 
{
    if (key == ESC)
  {
    for (int i = 0; i < dataWriter.length; i++) 
    {
      dataWriter[i].flush();
      dataWriter[i].close();
    }
    
    notes.println();
    notes.println("Comments\t\t:\t");
    notes.flush();
    notes.close();
    
    print("Forced to quit with keyboard!\n");
    exit();
  } 
}

//////////////////////////////////////////////////////////////////////


void generate_timing()
{
  index = 0;
  for(int i = 0; i < structure.length; i++)
  {
    if (i < (structure.length - no_test))
    {
      structure[i] = i * iti + init_delay;
    }
    else if(i == (structure.length - no_test))
    {
      structure[i] = structure[i - 1] + wait;
    }
    else
    {
      structure[i] = structure[i - 1] + iti;
    }
  }
}

void pick_probe()
{
  int i = 0;
  while(i < probe.length)
  {
    int rnd =  int(random(0, (no_training - 1)));
    int present = 0; //checks if rnd is present in the probe array
    for(int j = 0; j < probe.length; j++)
    {
      if(probe[j] == rnd || probe[j] == (rnd - 1) || probe[j] == (rnd + 1))
      {
        present = 1;
      }
    }
      if(present == 0)
      {
        probe[i] = rnd;
        probe_str = append(probe_str, str(rnd));
        i++;
      }
    }
    
    probe = sort(probe); 
    
    for(i = 0; i < probe.length; i++)
    {
      print(probe[i] + ", ");
      probe[i] += (no_pre_cs + no_pre_us);
    }
    
    int index = 0;
    
    for(i = 0; i< structure.length; i++)
    {
      if(index < no_probe && i == probe[index])
      {
        trial = append(trial, "probe");
        index++;
      }
      else if(i < no_pre_cs)
      {
        trial = append(trial, "precs");
      }
      else if(i < (no_pre_cs + no_pre_us))
      {
        trial = append(trial, "preus");
      }
      else if(i < (no_pre_cs + no_pre_us + no_training))
      {
        trial = append(trial, "training");
      }
      else if(i < structure.length)
      {
        trial = append(trial, "test");
      }
    }
}

void generate_random_timing()
{
  index = 0;
  for(int i = 0; i < structure.length; i++)
  {
    if (i < (structure.length - no_test))
    {
      structure[i] = i * random(min, max) + init_delay;
    }
    else if(i == (structure.length - no_test))
    {
      structure[i] = structure[i - 1] + wait;
    }
    else
    {
      structure[i] = structure[i - 1] + random(min, max);
    }
  }
}

