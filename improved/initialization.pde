String time=(str(hour())+":"+str(minute())+":"+str(second()));
String[] cc_data = new String[2];
PrintWriter[] cc_datawriter = new PrintWriter[2];
String[] cc_file_names = {"timing", "trial"};
PrintWriter notes;

// returns date

String generate_date()
{  
  String year, month, day, date;

  year = str(year() % 1000);
  if (month() < 10)
  {
    month = str(0) + str(month());
  } else
  {
    month = str(month());
  }
  if (day() < 10)
  {
    day = str(0) + str(day());
  } else
  {
    day = str(day());
  }
  date = year + month + day;

  return date;
}

//generates timing of trials when iti is not randomized
void generate_timing()
{
  for (int i = 0; i < timing.length; i++)
  {
    if (i < (timing.length - no_test))
    {
      timing[i] = i * iti + init_delay;
    } 
    else if (i == (timing.length - no_test))
    {
      timing[i] = timing[i - 1] + wait;
    } 
    else
    {
      timing[i] = timing[i - 1] + iti;
    }
  }
}

//generates timing of trials when iti is randomized
void generate_random_timing()
{
  for (int i = 0; i < timing.length; i++)
  {
    if (i < (timing.length - no_test))
    {
      timing[i] = i * int(random(min, max)) + init_delay;
    } else if (i == (timing.length - no_test))
    {
      timing[i] = timing[i - 1] + wait;
    } else
    {
      timing[i] = timing[i - 1] + random(min, max);
    }
  }
}

//picks 1 probe trial in every 10 training trials. 
void pick_probe()
{
  print("Probe trials:");
  
  for(int i = 0; i < probe.length; i++ )
  {
    probe[i] = int(random(i * 10, (i + 1) * 10));
  } 

  for (int i = 0; i < probe.length; i++)
  {
    probe[i] += (no_pre_cs + no_pre_us);
    print(probe[i] + ", ");
  }
}

//generates trial structure
void generate_trials()
{
  int index = 0;
  for (int i = 0; i< timing.length; i++)
  {
    if (index < no_probe && i == probe[index])
    {
      trial = append(trial, "probe");
      index++;
    } 
    else if (i < no_pre_cs)
    {
      trial = append(trial, "precs");
    } 
    else if (i < (no_pre_cs + no_pre_us))
    {
      trial = append(trial, "preus");
    } 
    else if (i < (no_pre_cs + no_pre_us + no_training))
    {
      trial = append(trial, "training");
    } 
    else if (i < timing.length)
    {
      trial = append(trial, "test");
    }
  }
}

// triggers CS
void cs()
{
  oscP5.send(myMessage, location); 
  arduino.digitalWrite(cs_pin, Arduino.HIGH);
  println("CS");
  cc_datawriter[0].println(str(millis()) + ",");
  cc_datawriter[1].println(trial[stimulus_count] + ",");
  wait(cs_dur);
  arduino.digitalWrite(cs_pin, Arduino.LOW);
  cc_datawriter[0].println(str(millis()) + ",");
}

//triggers US
void us()
{
  oscP5.send(myMessage, location); 
  arduino.digitalWrite(us_pin, Arduino.HIGH);
  println("US");
  cc_datawriter[0].println(str(millis()) + ",");
  cc_datawriter[1].println(trial[stimulus_count] + ",");
  wait(us_dur);
  arduino.digitalWrite(us_pin, Arduino.LOW);
  cc_datawriter[0].println(str(millis()) + ",");
}

//triggers training trial
void train()
{
  oscP5.send(myMessage, location);
  arduino.digitalWrite(cs_pin, Arduino.HIGH);
  println("CS");
  cc_datawriter[0].println(str(millis()) + ",");
  cc_datawriter[1].println(trial[stimulus_count] + ",");
  wait(int(us_pos * cs_dur));
  arduino.digitalWrite(us_pin, Arduino.HIGH);
  println("US");
  cc_datawriter[0].println(str(millis()) + ",");
  wait(us_dur);
  arduino.digitalWrite(us_pin, Arduino.LOW);
  cc_datawriter[0].println(str(millis()) + ",");
  wait(int((1 - us_pos) * cs_dur - us_dur));
  arduino.digitalWrite(cs_pin, Arduino.LOW);
  cc_datawriter[0].println(str(millis()) + ",");
}

//waits for d milliseconds
void wait(int d)
{
  long t = millis();
  while((millis() - t) <= d){}
}
  
void write_notes()
{
  notes.println("Genotype\t\t\t:\t" + genotype);
  notes.println("Age\t\t\t\t:\t" + dpf);
  notes.println("Fish id\t\t\t\t:\t" + fish);
  notes.println("Date\t\t\t\t:\t" + generate_date());
  notes.println("Initial delay (ms)\t\t:\t" + init_delay);
  notes.println("Wait period before test\t\t:\t" + wait);
  notes.println("No. pre training CS\t\t:\t" + no_pre_cs);
  notes.println("No. pre-training US\t\t:\t" + no_pre_us);
  notes.println("No. training trials\t\t:\t" + no_training);
  notes.println("No. test trials\t\t\t:\t" + no_test);
  notes.println("No. probe trials\t\t:\t" + no_probe);
  notes.println("CS duration (ms)\t\t:\t" + cs_dur);
  notes.println("US duration (US)\t\t:\t" + us_dur);
  notes.println("US position\t\t\t:\t" + us_pos);
  notes.println("Current value (mA)\t\t:\t" + current);
  
  if (random)
  {
    notes.println("Minimum ITI (ms)\t\t:\t" + min);
    notes.println("Maximum ITI(ms)\t\t:\t" + max);
  }
  else
    notes.println("ITI (ms)\t\t\t:\t" + iti);
}

//quit using keyboard

void keyPressed() 
{
  if (key == ESC)
  {
    for (int i = 0; i < cc_datawriter.length; i++) 
    {
      cc_datawriter[i].flush();
      cc_datawriter[i].close();
    }

    notes.println();
    notes.println("Comments\t\t\t:\t");
    notes.flush();
    notes.close();

    print("Forced to quit with keyboard!\n");
    exit();
  }
}
