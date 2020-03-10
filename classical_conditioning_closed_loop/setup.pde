void setup() 
{
  ////////////////////Closed Loop Stuff//////////////////////////////
  
  size(window_width, window_height, P2D);
  frameRate(frame_rate);
  background(255, 255, 255);       
  noStroke();                
  fill(0, 0, 0);
  noCursor();
  
   notes = createWriter(file_path + "/" + generate_date() + "/" + fish + "/" + "parameters.txt");
   notes.println("Date\t\t\t:\t" + generate_date());
   notes.println("Time\t\t\t:\t" + time);
   notes.println("Genotype\t\t:\t" + genotype);
   notes.println("Days Post Fertilization\t:\t" + dpf);
     
  // loading shader and setting parameters
  


  delay(100);
  oscP5 = new OscP5(this,2323);
    
  //////////////////////////////////////////////////////////////////////
  
  ///////////////////Classical Conditioning/////////////////////////////
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(CS_pin, Arduino.OUTPUT);
  
    index = 0;
  
    for(int i = 0; i < structure.length; i++)
    {
      if (i < (structure.length - no_test))
      {
        structure[i] = i * isi + init_delay;
      }
      else if(i == (structure.length - no_test))
      {
        structure[i] = structure[i - 1] + wait;
      }
      else
      {
        structure[i] = structure[i - 1] + isi;
      }
    }
    
    print("Probe trials: ");
  
    int i = 0;
    while(i < probe.length)
    {
      int rnd =  int(random(0, (no_training - 1)));
      int present = 0; //checks if rnd is present in the probe array
  
      for(int j = 0; j < probe.length; j++)
        if(probe[j] == rnd || probe[j] == (rnd - 1) || probe[j] == (rnd + 1))
          present = 1;
    
      if(present == 0)
      {
        probe[i] = rnd;
        probe_str = append(probe_str, str(rnd));
        print(probe[i] + ", ");
        i++;
      }
    }
    
    probe = sort(probe); 
    
    for(i = 0; i < probe.length; i++)
    {
      probe[i] += (no_pre_CS + no_pre_US);
    }
    
    int index = 0;
    
    for(i = 0; i< structure.length; i++)
    {
      if(index < no_probe && i == probe[index])
      {
        trial = append(trial, "probe");
        index++;
      }
      else if(i < no_pre_CS)
      {
        trial = append(trial, "preCS");
      }
      else if(i < (no_pre_CS + no_pre_US))
      {
        trial = append(trial, "preUS");
      }
      else if(i < (no_pre_CS + no_pre_US + no_training))
      {
        trial = append(trial, "training");
      }
      else if(i < structure.length)
      {
        trial = append(trial, "test");
      }
    }
    
    println();  
    
  
  println("Program started");
  
  ////////////////////////////////////////////////////////////////////
}
