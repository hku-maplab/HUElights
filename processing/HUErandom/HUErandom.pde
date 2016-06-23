/*****************************************************
 Author: Machiel Veltkamp machiel.veltkamp@hku.nl
 Name: HUErandom
 Description:
 a sketch that changes each HUE lamp to a random hue every so often.
 We choose one new random value and then distract three new randoms values from this one value 
 so that the colors are reasonably "close" to each other
 *****************************************************/
// --> IMPORTS
import processing.net.*;

// --> VARS
PImage img;
String apiKey = "VolR8C0SKKpWEkxzKRgQWTZiuKonGSAWgcDE1UIg"; //developer name used when setting up bridge
String ip = "10.200.200.157";
String[] hueIDs = {"1", "2", "3"};

int nextColor = 0;        // int to store when the next color change will be
int minNextColor = 10;     // min time in seconds for next color change
int maxNextcolor = 30;    // max time in seconds for next color change
int time = 10;             // time to fade to the next color
int count = 0;            // counter to measure time since last color change
int hue_base = 0;         // the base hue value to base the random colors on
int offsetHue = 10000;    // set the max color offset of the main new random value




// --> OBJECTS
Client client;

// --> SETUP
void setup()
{
  size(100, 100);

  // set when the next time is that we choose a new random color
  nextColor = int(random(minNextColor*30, maxNextcolor*30));

  frameRate(30);
  colorMode(HSB, 360, 255, 255);
}


// --> DRAW
void draw()
{
  background(0);

  // If this is true then it is time to change the color
  if (count >= nextColor) {
    count = 0;
    // set when the next time is that we choose a new random color
    nextColor = int(random(minNextColor*30, maxNextcolor*30));
    println("change color");

    // get a new random hue and create using this new random value
    // three values that are relatively "close" together
    hue_base = int(random(0, 65280));
    // set the new colors for the lamps
    for (int i = 0; i < hueIDs.length; i++)
    {
      int hue = int(random(hue_base-offsetHue, hue_base+offsetHue));
      setHue(hueIDs[i], hue, 255, 255, time);
    }
  } else {
    // count towards the next color change
    count ++;
    // display the counter and the current base hue
    text(count+"/"+nextColor+"\n"+hue_base, 20, 60);
  }
}

// Function to actually set the parameters of one of the HUE lamps
void setHue(String id, int hue, int sat, int bri, int time) {

  // build the body string and print it
  String t = "{\"hue\":" + hue +", \"sat\":"+sat+", \"bri\":" + bri + ", \"transitiontime\":"+ time +"}\r\n";
  int leng = t.length();
  println(leng, t);

  // is mainly for pure data, but may com in handy anyway
  id = id.replace('"', ' ');
  id = trim(id);

  // create client send data and close the connection 
  client = new Client(this, ip, 80); // Connect to server on port 80
  client.write("PUT /api/" + apiKey +"/lights/" + id + "/state HTTP/1.1\r\n"); 
  client.write("Content-Length: " + leng + "\r\n\r\n");
  client.write(t);
  client.write("\r\n");
  client.stop();
}

// convenience function to turn the hues on and off
void turnHueOn(String id, String on) {

  String t = "{\"on\":" + on +"}\r\n";
  int leng = t.length();

  client = new Client(this, ip, 80); // Connect to server on port 80
  client.write("PUT /api/" + apiKey +"/lights/" + id + "/state HTTP/1.1\r\n"); 
  client.write("Content-Length: " + leng + "\r\n\r\n");
  client.write(t);
  client.write("\r\n");
  client.stop();
}




// --> keyPressed
void keyPressed()
{
}

// --> keyReleased
void keyReleased()
{
  if (key == 'q') {
    turnHueOn("1", "true");
    turnHueOn("2", "true");
    turnHueOn("3", "true");
    println("turn lights on");
  }

  if (key == 'w') {
    turnHueOn("1", "false");
    turnHueOn("2", "false");
    turnHueOn("3", "false");
    println("turn lights off");
  }
}

// --> mousePressed
void mousePressed()
{
}

// --> mouseReleased
void mouseReleased()
{
}