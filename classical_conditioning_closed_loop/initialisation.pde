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
