void draw() 
{  
  set_zero();
  
  if (!init)
  {
    for (int i = 0; i < cc_datawriter.length; i++)
    {
      cc_datawriter[i] = createWriter(file_path + cc_file_names[i] + ".csv");
    }
    init = true;
    notes = createWriter(file_path + "notes.txt");
    write_notes();
  }

  //response to cs pre-training
  if (no_pre_cs != 0 && trial[stimulus_count] == "precs" && millis() >= init_delay && millis() >= timing[stimulus_count])
  {
    println("Trial " + stimulus_count);
    cs();
    stimulus_count++;
  }

  //response to us pre-training
  if (no_pre_us != 0 && trial[stimulus_count] == "preus" && millis() >= timing[stimulus_count])
  {
    println("Trial " + stimulus_count);
    us();
    stimulus_count++;
  }

  //training
  if (no_training != 0 && trial[stimulus_count] == "training" && millis() >= timing[stimulus_count])
  {
    println("Trial " + stimulus_count);
    train();
    stimulus_count++;
  }
  
  //probe trials
  if (no_probe != 0 && trial[stimulus_count] == "probe" && millis() >= timing[stimulus_count])
  {    
    println("Trial " + stimulus_count);
    cs();
    stimulus_count++;
  }

  //test trials
  if (no_test != 0 && trial[stimulus_count] == "test" && millis() >= timing[stimulus_count])
  {
    println("Trial " + stimulus_count);
    cs();
    stimulus_count++;
  }

  //end of program
  if (stimulus_count == timing.length)
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

    
    println("Program ended!");
    noLoop();
  }
}

