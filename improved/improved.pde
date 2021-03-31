//////////////////////////////////////////////////////////////////////

/* Classical conditioning with light as cs and shock as us. 
 A number of cs and us can be given to establish baseline 
 responses before training begins. During training, the cs 
 goes on and the us can be delivered anywhere within the cs.
 Probe trials can be randomly delivered during training. 
 Finally, cs-only test trials are given to extinguish learning.*/

//////////////////////////////////////////////////////////////////////

import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

//fish information

String genotype = "Indian Wild Type";
String dpf = "8";
String fish = "F4";
String file_path = "../../data/" + generate_date() + "/" + fish + "/";

//////////////////////////////////////////////////////////////////////

