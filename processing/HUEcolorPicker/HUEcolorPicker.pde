/*****************************************************
 Author: Machiel Veltkamp (machiel.veltmap@hku.nl)
 Name: HUEcolorPicker
 Description:
 Use an image and some colord lines to be able to set the color of your hue lights by moving it's icon over the color you want.
 The color mapping from the processing HUE values to the Philips HUE valus is not optimal yet.
 
 *****************************************************/
// --> IMPORTS
import processing.net.*;

// --> VARS
PImage img;
String apiKey = "yourapikey"; // developer name used when setting up bridge
String ip = "ipaddresbridge";                               // IP adress of your bridge
String[] hueIDs = {"1","2","3"};                            // ID's of your HUE lights



// --> OBJECTS
HueLampPicker[] hues;
Client client;

// --> SETUP
void setup()
{
  size(800,600);
  
  // set number of HUE lamp objects depending on number of HUE names
  hues = new HueLampPicker[hueIDs.length];
  
  // create Hue colorpicker object for each lamp
  for(int i =0;i<hueIDs.length;i++){
    hues[i] = new HueLampPicker(hueIDs[i],new PVector(random(100,400),random(100,300)),new PVector(20,20));
  }
  
  // Load reference image
  img = loadImage("photo1.jpeg");
  
  // set framerate and color mode and text mode
  frameRate(30);
  colorMode(HSB,360,255,255);
  textAlign(CENTER);
  
}


// --> DRAW
void draw()
{
  background(0);
  
  // draw the image
  image(img,0,0,width,height);
  
  // create the color spectrum to choose from instead of a part of the image
  for(int i =0; i<360; i++){
    fill(i,255,255);
    rect(0,i,75,1);
  }
  
  // loadPixels() is called to be able to get pixel color imfomation
  loadPixels();
  // display and update the HUE color pickers
  for(int i =0;i<hues.length;i++){
    hues[i].run();
  } 
}

// Function to actually set the parameters of one of the HUE lamps
void setHue(String id, int hue, int sat, int bri) {

  // build the body string and print it
  String t = "{\"hue\":" + hue +", \"sat\":"+sat+", \"bri\":" + bri + ", \"transitiontime\":0}\r\n";
  int leng = t.length();
  println(t);
 
  // is mainly for pure data, but may come in handy anyway
  id = id.replace('"',' ');
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
void turnHueOn(String id, String on){
  
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
  if(key == 'q'){
    turnHueOn("1", "true");
    turnHueOn("2", "true");
    turnHueOn("3", "true");
    println("turn lights on");
  }
  
  if(key == 'w'){
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
  for(int i =0;i<hues.length;i++){
    hues[i].mouseReleased();
  }
}