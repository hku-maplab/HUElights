/*****************************************************
 Author: Machiel Veltkamp (machiel.veltmap@hku.nl)
 Name: HueOSCbridge
 Description:
 This sketch enables you to communicate with the HUE lights over OSC
 use the label "/setHUE" with four arguments to change the lights
 *****************************************************/
import processing.net.*;
import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


Client client;

String apiKey = "yourapikey";  // Developer name used when setting up bridge
String ip = "ipaddresbridge";  // IP adress of your bridge
String oscLabel = "/setHue";    // OSC label to listen to

void setup() {
  size(200, 200);
  background(50);
  noStroke();
  
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 6600);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  // direct all messages with label setHue and four arguments to the function setHue
  oscP5.plug(this, "setHue", oscLabel);
}

void draw() {


}

/**********************************
 Parameters: lampID, Hue, Saturation, Brightness
 Message structure
 label: /setHue
 paramaters 0: lampID string
 paramaters 1: Hue  int 0 - 65535
 paramaters 2: Saturation int 0 - 254
 paramaters 3: Brightness int 1 - 254
 **********************************/
void setHue(String id, int hue, int sat, int bri) {

  // create the body string and print it
  String t = "{\"hue\":" + hue +", \"sat\":"+sat+", \"bri\":" + bri + "}\r\n";
  // get length of message so we can pass it into our request
  int leng = t.length();
  println(t);
 
  // is mainly for pure data, but may com in handy anyway
  id = id.replace('"',' ');
  id = trim(id);
 
  // open a connection to the bridge sent the data and close it again
  client = new Client(this, ip, 80); // Connect to server on port 80
  client.write("PUT /api/" + apiKey +"/lights/" + id + "/state HTTP/1.1\r\n"); 
  client.write("Content-Length: " + leng + "\r\n\r\n");
  client.write(t);
  client.write("\r\n");
  client.stop();
  
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  
  String label = theOscMessage.addrPattern();
  int numArguments = theOscMessage.typetag().length();
  
  // Check if incoming message has right label and number of arguments
  if(label.equals(oscLabel) && theOscMessage.typetag().length() != 4)
  {
    println("Recieved OSC message with correct label but wrong numer of arguments ("+numArguments+")\nPlease use four arguments");
  }
  else if(!label.equals(oscLabel)) {
    println("Recieved OSC message with WRONG label ("+label+")\nPlease use as label: "+oscLabel);
  }
  
}